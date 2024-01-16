public with sharing class ProductDataService {

    // create getAllProducts function
    @AuraEnabled(cacheable = true)
    public static List<Product2> getAllProducts() {
        return [
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
                Rating__c,
                (SELECT Id, Comment__c, Rating__c, LastModifiedDate, CreatedDate, CreatedBy.Name, CreatedBy.SmallPhotoUrl, CreatedBy.CompanyName FROM ProductReviews__r)
            FROM
                Product2
            WITH SECURITY_ENFORCED
            ORDER BY
                CreatedDate DESC
        ];
    }
                   
}

public with sharing class PersonalizationService {
    public PersonalizationService() {
        // create a api call to a service using the http class and store the response in a variable 

        // create a http request
        

        // parse the response and store it in a variable

        // store the response in a custom setting

        // use the custom setting to personalize the application

    }
}