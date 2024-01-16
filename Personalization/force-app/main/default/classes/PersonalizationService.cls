public with sharing class PersonalizationService {
    public static List<Map<String, Object>> getPersonalizationData() {
        // Make an API call to retrieve the personalized data
        HttpRequest httpRequest = new HttpRequest();
        httpRequest.setEndpoint('https://api.example.com/products'); // Replace with the actual API endpoint
        httpRequest.setMethod('GET'); // Replace with the appropriate HTTP method

        HttpResponse httpResponse = new Http().send(httpRequest);
        String response = httpResponse.getBody();

        // Parse the response and extract the product IDs from the SKUS array
        List<Map<String, Object>> products = new List<Map<String, Object>>();
        Map<String, Object> responseMap = (Map<String, Object>) JSON.deserializeUntyped(response);
        List<Object> skus = (List<Object>) responseMap.get('SKUS');
        for (Object sku : skus) {
            String productId = (String) ((Map<String, Object>) sku).get('id');
            Map<String, Object> product = new Map<String, Object>();
            product.put('id', productId);
            products.add(product);
        }

        return products;
    }

       // create getAllProducts function
       @AuraEnabled(cacheable = true)
       public static List<Product2> getProducts() {
           List<Map<String, Object>> personalizationData = getPersonalizationData(); // call the getPersonalizationData function to retrieve the personalized data
           List<String> skus = new List<String>();
           
           for (Map<String, Object> product : personalizationData) {
               skus.add((String)product.get('id'));
           }
           
           List<Product2> products = [
               SELECT
                   Id,
                   Name,
                   Description,
                   ProductCode,
                   CreatedDate,
                   LastModifiedDate,
                   CreatedBy.Name,
                   CreatedBy.SmallPhotoUrl,
                   CreatedBy.CompanyName,
                   Image__c,
                   Price__c,
                   Rating__c
               FROM
                   Product2
               WHERE
                   ProductCode IN :skus
               WITH SECURITY_ENFORCED
               ORDER BY
                   CreatedDate DESC
           ];
       
           return products;
       }
}