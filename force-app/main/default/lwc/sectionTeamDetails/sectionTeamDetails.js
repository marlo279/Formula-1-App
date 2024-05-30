import { LightningElement, wire, track } from 'lwc';
import getProfile from '@salesforce/apex/ProfileController.getProfile';
import myImageResource from '@salesforce/resourceUrl/DashboardIcon';
import HideLightningHeader from '@salesforce/resourceUrl/removeHeader';
import { loadStyle } from 'lightning/platformResourceLoader';
import getAllRaces from '@salesforce/apex/RacesController.getAllRaces';



export default class SectionTeamDetails extends LightningElement {

    dashboardIcon = myImageResource;
    selectedRace;
    userName;
    races;

    loadData;

    handleRaceChange(event) {
        this.selectedRace = event.detail.value;

        // Dispatch een custom event met de geselecteerde maand
        const selectedEvent = new CustomEvent('racechange', {
            detail: { race: this.selectedRace }
        });
        this.dispatchEvent(selectedEvent);
    }

    get races() {
         
        return this.loadData;

    }

    connectedCallback() {
        loadStyle(this, HideLightningHeader)
    }


    
    @wire(getProfile)
    getUserProfile(response) {

        const {data, error} = response;

        if(error) {
            console.log(error);
            return;
        }
        if (data) {
            this.userName = data;
        }
    }

    @wire(getAllRaces)
    getUserProfile(response) {

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

    
}
