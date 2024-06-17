import { LightningElement, wire } from 'lwc';
import getAllEngines from '@salesforce/apex/EngineController.getAllEngines';
import myImageResource from '@salesforce/resourceUrl/Engine_Shop';



export default class EngineShopCard extends LightningElement {

    engines;
    engineIcon = myImageResource;


    @wire(getAllEngines)
    getProfile(response) {

        const {data, error} = response;

        if(error) {
            console.log(error);
            return;
        }
        if (data) {
            console.log(data);
            this.engines = data;
        }
    }

}