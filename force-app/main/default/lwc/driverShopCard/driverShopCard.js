import { LightningElement, wire } from 'lwc';
import buyDriver from '@salesforce/apex/ShopController.buyDriver';
import getAllDrivers from '@salesforce/apex/DriverController.getAllDrivers';



export default class DriverShopCard extends LightningElement {

    drivers;


    handleSubmit(event) {

        const driverName = event.target.value;

        buyDriver({ driverName: driverName})
              .then(result => {
                  console.log('Driver gekocht', result);
              })
              .catch(error => {
                  console.error('Fout bij het maken van het record: ', error);
              });
    }

    @wire(getAllDrivers)
    getProfile(response) {

        const {data, error} = response;

        if(error) {
            console.log(error);
            return;
        }
        if (data) {
            console.log(data);
            this.drivers = data;
        }
    }

}