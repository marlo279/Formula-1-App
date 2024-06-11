import { LightningElement, wire } from 'lwc';
import calloutRaces from '@salesforce/apex/RaceRankingCallout.getRaceRankings';


export default class OptionalsCard extends LightningElement {

    races;

    getRaces(){
        console.log(this.races);
    }

    @wire(calloutRaces)
    getProfile(response) {

        const {data, error} = response;

        if(error) {
            console.log(error);
            return;
        }
        if (data) {
            // console.log(data);
            console.log(JSON.parse(data));
            var parsedRaces = JSON.parse(data);

            // console.log(JSON.parse(data.response));
            console.log('Only Races: ');
            console.log(parsedRaces.response);
    
        }
    }

}