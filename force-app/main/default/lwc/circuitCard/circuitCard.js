import { LightningElement, api } from 'lwc';
import getCircuitByGrandPrix from '@salesforce/apex/GrandPrixController.getCircuitByGrandPrix'

export default class CircuitCard extends LightningElement {

    @api
    grandPrix;
    circuitImg;
    circuit;
    laps;
    raceDate;

    @api getGrandPrixByName(grandPrix) {

        if (typeof grandPrix === 'undefined') {
            grandPrix = 'Bahrain Grand Prix';
        }


        return new Promise((resolve, reject) => {
            getCircuitByGrandPrix({grandPrix: grandPrix})
              .then(result => { 
                 console.log('GP: ', result);
                 this.circuitImg = result.Circuit__r.CircuitImgUrl__c;
                 this.circuit = result.Circuit__r.Name;
                 this.laps = result.Circuit__r.Laps__c;
                 this.raceDate = result.Date__c;
           })
           .catch(error => {
                 console.error('Fout bij het maken van het record: ', error);
           });
        });
    }

    connectedCallback() {
        this.getGrandPrixByName();
    }

}