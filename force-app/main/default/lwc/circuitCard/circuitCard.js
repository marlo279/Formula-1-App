import { LightningElement, api } from 'lwc';
import getGrandPrix from '@salesforce/apex/RacesController.getGrandPrixByName'

export default class CircuitCard extends LightningElement {

    @api
    grandPrix;
    circuitImg;
    circuit;
    laps;
    raceDate;

    @api getGrandPrixByName(race) {

        if (typeof race === 'undefined') {
            race = 'Bahrain Grand Prix';
        }


        return new Promise((resolve, reject) => {
           getGrandPrix({grandPrix: race})
              .then(result => { 
                 console.log('GP: ', result);
                 this.circuitImg = result.CircuitUrl__c;
                 this.circuit = result.Circuit__c;
                 this.laps = result.Laps__c;
                 this.raceDate = result.RaceDate__c;
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