import { LightningElement } from 'lwc';
import HideLightningHeader from '@salesforce/resourceUrl/removeHeader';
import { loadStyle } from 'lightning/platformResourceLoader';

export default class TeamSectionGrid extends LightningElement {

    connectedCallback() {
        loadStyle(this, HideLightningHeader)
    }

}