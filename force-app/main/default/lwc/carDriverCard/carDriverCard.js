import { LightningElement, api, track } from 'lwc';

export default class CarDriverCard extends LightningElement {

    @track driver;
    @api car; // to hold the original car object


    printCar() {
        console.log(this.car.Driver__r.Name);
        this.driver = this.car.Driver__r.Name;
    }

    // get driverName() {
    //     return this.car.Driver__r.Name;
    // }

    // get data() {
    //     // Voeg logica toe om data op te halen op basis van de selectedMonth
    //     return `Data for ${JSON.stringify(this.car.Driver__r.Name)}`;
    //     // return `Data for ${this.car.Driver__r.Name}`;

    // }

  

}