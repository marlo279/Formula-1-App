import { LightningElement, wire } from 'lwc';
import getAllChassis from '@salesforce/apex/ChassisController.getAllChassis';


export default class ChassisShopCard extends LightningElement {

    chassis;


    @wire(getAllChassis)
    getProfile(response) {

        const {data, error} = response;

        if(error) {
            console.log(error);
            return;
        }
        if (data) {
            console.log(data);
            this.chassis = data;
        }
    }



}