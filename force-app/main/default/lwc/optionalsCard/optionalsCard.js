import { LightningElement, wire } from 'lwc';
import totalEnginePoints from '@salesforce/apex/GrandPrixService.totalEnginePoints';


export default class OptionalsCard extends LightningElement {

    positions;

    @wire(totalEnginePoints)
    getUser(response) {

        const {data, error} = response;

        if(error) {
            console.log('Gaat iets fout');
            console.log(error);
            return;
        }
        if (data) {
            console.log('Gaat iets Goed');
            console.log(data);
            this.positions = data;
        }
    }

}