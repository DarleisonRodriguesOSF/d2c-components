import { LightningElement, api } from 'lwc';
import getAllProducts from "@salesforce/apex/ProductDataService.getAllProducts";

/**
* A Lightning web component that handles personalization for a specific campaign
* @extends LightningElement
* @property {string} title - the title of the campaign
* @property {string} MCPcampaign - the MCP campaign associated with the component
* @property {Object[]} products - an array of products associated with the campaign
* @property {string} products.id - the ID of the product
* @property {string} products.imageUrl - the URL of the product image
* @property {string} products.name - the name of the product
* @property {string} products.description - the description of the product
* @property {string} products.altText - the alt text for the product image
* @property {string} products.link - the link to the product
* @method get productImages - returns an array of product images with additional information
*/
export default class Personalization extends LightningElement {
    @api title;
    @api MCPcampaign;
    @api products = [];

    getAllProducts() {
        return this.products.map(product => {
            return {
                id: product.id,
                imageUrl: product.imageUrl,
                name: product.name,
                description: product.description,
                altText: product.altText,
                link: product.link
            };
        });
    }
}