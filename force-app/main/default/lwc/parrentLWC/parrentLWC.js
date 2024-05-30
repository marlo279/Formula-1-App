import { LightningElement } from 'lwc';
import HideLightningHeader from '@salesforce/resourceUrl/removeHeader';
import { loadStyle } from 'lightning/platformResourceLoader';
import myImageResource from '@salesforce/resourceUrl/DashboardIcon';



export default class ParentLwc extends LightningElement {

    dashboardIcon = myImageResource;
    selectedMonth;

    handleMonthChange(event) {
        this.selectedMonth = event.detail.value;

        // Dispatch een custom event met de geselecteerde maand
        const selectedEvent = new CustomEvent('monthchange', {
            detail: { month: this.selectedMonth }
        });
        this.dispatchEvent(selectedEvent);
    }

    get monthOptions() {
        return [
            { label: 'January', value: 'January' },
            { label: 'February', value: 'February' },
            { label: 'March', value: 'March' },
            { label: 'April', value: 'April' },
            { label: 'May', value: 'May' },
            { label: 'June', value: 'June' },
            { label: 'July', value: 'July' },
            { label: 'August', value: 'August' },
            { label: 'September', value: 'September' },
            { label: 'October', value: 'October' },
            { label: 'November', value: 'November' },
            { label: 'December', value: 'December' }
        ];
    }

    connectedCallback() {
        loadStyle(this, HideLightningHeader)
    }
    
}