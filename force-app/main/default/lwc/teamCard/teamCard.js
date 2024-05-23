import { LightningElement, wire, track } from 'lwc';
import getLastThreeRanks from '@salesforce/apex/RankingController.getLastThreeRanks';
import createProfile from '@salesforce/apex/ProfileController.createProfile';
import { subscribe, MessageContext } from 'lightning/messageService';
import PLAYER_NAME from '@salesforce/messageChannel/PlayerNameCard__c';
import { NavigationMixin } from 'lightning/navigation';


export default class TeamCard extends NavigationMixin(LightningElement) {

  buttonLabel = 'Select';

  @track isActive;
  @track buttonClass = 'slds-button';

    @track playerName;
    @track selectedTeam;
    rankings = [];

    recievedPlayerName;

    @wire(MessageContext)
    messageContext;
    
    subscribeToMessageChannel() {
      this.subscription = subscribe(
        this.messageContext,
        PLAYER_NAME,
        (message) => this.handleMessage(message)
      );
    }

      
  handleMessage(message) {
    
    console.log('Player Name met naam ' + message.playername + ' is door de subscriber ontvangen');

    if (message.playername) {
      this.recievedPlayerName = true;
      this.playerName = message.playername;
    } else {
      console.log('Ja ben aangeroepen nu false');
      this.recievedPlayerName = false;
    }


  }


  handleButtonClick(event) {
    const selectedButton = event.target;

    if (selectedButton.label == "Select") {
      selectedButton.label = "Selected";
      this.selectedTeam = event.target.dataset.value;
    } else {
      selectedButton.label = "Select";
      this.selectedTeam = null;
    }
  }

  deselectButtons() {
    this.buttonLabel = 'Select';
  }


    @wire(getLastThreeRanks)
    getRankingHandler(response) {
        const {data, error} = response;

        if(error) {
            console.log(error);
            return;
        }
        if (data) {
            this.rankings = data;

        }
    }

    handleSubmit() {

      console.log(this.playerName + ' ' + this.selectedTeam);
      createProfile({ playerName: this.playerName, selectedTeam: this.selectedTeam })
            .then(result => {
                console.log('Nieuw record-ID: ', result);
                this.navigateToDashboardTab();
        this[NavigationMixin.Navigate]({
            type: 'standard__navItemPage',
            attributes: {
                apiName: 'Hello'
            }
        });
            })
            .catch(error => {
                console.error('Fout bij het maken van het record: ', error);
            });
    }

    navigateToDashboardTab() {
      this[NavigationMixin.Navigate]({
          type: 'standard__navItemPage',
          attributes: {
              apiName: 'Dashboard'
          }
      });
    }

    connectedCallback() {
        this.subscribeToMessageChannel();
      }

}