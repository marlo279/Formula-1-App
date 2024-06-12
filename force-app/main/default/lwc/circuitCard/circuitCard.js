import { LightningElement, api, wire } from 'lwc';
import getCircuitByGrandPrix from '@salesforce/apex/GrandPrixController.getCircuitByGrandPrix';
import getGrandPrixByCurrentDate from '@salesforce/apex/GrandPrixController.getGrandPrixByCurrentDate';
import testGameEngine from '@salesforce/apex/GrandPrixController.testGameEngine';

export default class CircuitCard extends LightningElement {

    @api
    grandPrix;
    circuitImg;
    circuit;
    laps;
    raceDate;
    currentGrandPrix;

    @api getGrandPrixByName(grandPrix) {

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

    @wire(getGrandPrixByCurrentDate)
    getGrandPrixByCurrentDate(response) {

        const {data, error} = response;

        if(error) {
            console.log(error);
            return;
        }
        if (data) {
            console.log(data);
            this.getGrandPrixByName(data);
        }
        
    }

    // Test Game Engine
    @wire(testGameEngine)
    testGameEngine(response) {

        const {data, error} = response;

        if(error) {
            console.log(error);
            return;
        }
        if (data) {
            console.log('Name of Engine One:')
            console.log(data);
        }
        
    }

    connectedCallback() {
        this.getGrandPrixByName();
    }

}