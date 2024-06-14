import { LightningElement, wire, track } from 'lwc';
import myImageResource from '@salesforce/resourceUrl/DashboardIcon';
import getScore from '@salesforce/apex/GrandPrixService.totalEnginePoints';


export default class ScoreCard extends LightningElement {
    icon = myImageResource;

    score;
    @track totalPoints;

    calculateTotalPoints() {
        let total = 0;

        this.score.forEach(element => {
            total += element.points;
        });

        this.totalPoints = total;
    }


    @wire(getScore)
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
            this.score = data;
            this.calculateTotalPoints();
        }
    }

}