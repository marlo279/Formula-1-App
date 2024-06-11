import { LightningElement, wire, track } from 'lwc';
import myImageResource from '@salesforce/resourceUrl/DashboardIcon';
import HideLightningHeader from '@salesforce/resourceUrl/removeHeader';
import { loadStyle } from 'lightning/platformResourceLoader';
import getAllGrandPrixes from '@salesforce/apex/GrandPrixController.getAllGrandPrixes';

import getProfileData from '@salesforce/apex/ProfileController.getProfileData';
import getUser from '@salesforce/apex/ProfileController.getUser';
import getProfile from '@salesforce/apex/ProfileController.getProfile';



export default class SectionTeamDetails extends LightningElement {

    dashboardIcon = myImageResource;
    selectedRace;
    userName;
    grandPrix;
    team;
    balance;

    carOne;
    carTwo;

    loadData;

    handleRaceChange(event) {
        this.selectedRace = event.detail.value;

        const selectedEvent = new CustomEvent('racechange', {
            detail: { race: this.selectedRace }
        });
        this.dispatchEvent(selectedEvent);
        this.getGrandPrixByName(event.detail.value);
    }

    getGrandPrixByName(race) {
        this.template.querySelector("c-circuit-card").getGrandPrixByName(race);
    }

    get races() {
         
        return this.loadData;

    }

    @wire(getProfile)
    getProfile(response) {

        const {data, error} = response;

        if(error) {
            console.log(error);
            return;
        }
        if (data) {
            this.team = data.Team__c;
        }
    }

    @wire(getUser)
    getUser(response) {

        const {data, error} = response;

        if(error) {
            console.log(error);
            return;
        }
        if (data) {
            this.userName = data.Name;
        }
    }

    @wire(getAllGrandPrixes)
    getAllRaces(response) {

        const {data, error} = response;

        if(error) {
            console.log(error);
            return;
        }
        if (data) {
            this.grandPrix = data.map(grandPrix => {
                return { label: grandPrix, value: grandPrix };
            });
        }
    }

    connectedCallback() {
        loadStyle(this, HideLightningHeader)
    }

    @wire(getProfileData)
    getProfileData(response) {

        const {data, error} = response;

        if(error) {
            console.log(error);
            return;
        }
        if (data) {
            this.carOne = data.Team__r.CarOne__r;
            this.carTwo = data.Team__r.CarTwo__r;
            this.balance = data.Balance__c;

            console.log(data);
        }
    }

    
}