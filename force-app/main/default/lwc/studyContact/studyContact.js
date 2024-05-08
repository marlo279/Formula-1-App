import { LightningElement, wire } from 'lwc';
// import getContacts from '@salesforce/apex/StudyController.getContacts';
import getContact from '@salesforce/apex/StudyController.getContact';
import USER_ID from '@salesforce/user/Id';


export default class StudyContact extends LightningElement {

    userId = USER_ID;
    
    
    @wire(getContact)
    contact;

    contactName;
    contactId;

        
    @wire(getContact)
    contactHandler({data, error}){
        if(data){
            console.log(JSON.stringify(data));
            this.contactName = data.Name;
            this.contactId = data.Id;

        }
        if(error){
            console.error(error)
        }
    }




}

// this.contact = data.map(item=>{
//     return item.Name;
// })
