import { LightningElement, wire, track } from 'lwc';
import calculateScore from '@salesforce/apex/GrandPrixController.CalculateScore';


export default class ScoreCard extends LightningElement {

    score;
    @track totalPoints;

    calculateTotalPoints() {
        let total = 0;

        this.score.forEach(element => {
            total += element.points;
        });

        this.totalPoints = total;
    }


    @wire(calculateScore)
    getUser(response) {

        const {data, error} = response;

        if(error) {
            console.log(error);
            return;
        }
        if (data) {
            this.score = data;
            this.calculateTotalPoints();
        }
    }

}