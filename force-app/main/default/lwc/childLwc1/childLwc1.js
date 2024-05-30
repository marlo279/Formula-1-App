import { LightningElement, api, wire } from 'lwc';

export default class ChildLwc1 extends LightningElement {
    @api selectedRace;

    // Logica om data te tonen op basis van de geselecteerde maand
    get data() {
        // Voeg logica toe om data op te halen op basis van de selectedMonth
        return `Data for ${this.selectedRace}`;
    }
}