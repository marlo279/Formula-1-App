import { LightningElement, wire } from 'lwc';
import { publish, MessageContext } from 'lightning/messageService';
import PLAYER_NAME from '@salesforce/messageChannel/PlayerNameCard__c';
import playerNameCheck from '@salesforce/apex/ProfileController.playerNameAvailable';


export default class PlayerName extends LightningElement {    
  
  @wire(MessageContext)
  messageContext;
  playerName;
  playerNameAvailability;
  playerNameNotAvailable

  handleNameChange(event) {
      this.playerName = event.target.value;
   }

   handleClick(){

      this.isPlayerNameAvailable();

      setTimeout(() => {
         console.log('HandleClick Erna: ' + this.playerNameAvailability);

         if (this.playerNameAvailability) {
            console.log('Player name is available');
            const payload = { 
              playername: this.playerName,
            };
            publish(this.messageContext, PLAYER_NAME, payload);
        } else {
            console.log('Player name is not available');
            this.playerNameNotAvailable = true;
        }

     }, 3000); 

   }

   resetNameField() {
      this.playerNameAvailability = false;
      this.removeCreateProfileButton()
   }

   removeCreateProfileButton(){
      console.log('removeCreateProfileButton() is aangeroepen');
      const payload = { 
         playername: null,
       };
       publish(this.messageContext, PLAYER_NAME, payload);
   }


   isPlayerNameAvailable() {
      return new Promise((resolve, reject) => {
         playerNameCheck({playerName: this.playerName})
            .then(result => { 
               console.log('Name available: ', result);
               this.playerNameAvailability = result;
         })
         .catch(error => {
               console.error('Fout bij het maken van het record: ', error);
         });
      });
  }
   
}