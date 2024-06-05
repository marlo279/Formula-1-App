import { LightningElement, wire, track } from 'lwc';
import getUser from '@salesforce/apex/ProfileController.getUser';
import getProfile from '@salesforce/apex/ProfileController.getProfile';
import myImageResource from '@salesforce/resourceUrl/DashboardIcon';
import HideLightningHeader from '@salesforce/resourceUrl/removeHeader';
import { loadStyle } from 'lightning/platformResourceLoader';
import getAllRaces from '@salesforce/apex/RacesController.getAllRaces';

import getProfileData from '@salesforce/apex/ProfileController.getProfileData';




export default class SectionTeamDetails extends LightningElement {

    dashboardIcon = myImageResource;
    selectedRace;
    userName;
    races;
    team;
    balance;

    carOne;
    carTwo;

    loadData;

    handleRaceChange(event) {
        this.selectedRace = event.detail.value;

        // Dispatch een custom event met de geselecteerde maand
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

    connectedCallback() {
        loadStyle(this, HideLightningHeader)
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

    @wire(getAllRaces)
    getAllRaces(response) {

        const {data, error} = response;

        if(error) {
            console.log(error);
            return;
        }
        if (data) {
            this.races = data.map(race => {
                return { label: race, value: race };
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
