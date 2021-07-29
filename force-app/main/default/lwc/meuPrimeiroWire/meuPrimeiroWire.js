import { LightningElement, wire, api } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';

const FIELDS = ['Contact.Name', 'Contact.NomeDeGuerra__c', 'Contact.NivelDoHeroi__c'];

export default class HelloWordWire extends LightningElement {
    
    @api recordId;
    
    @wire(getRecord, { recordId: '$recordId', fields: FIELDS })
    contacts; 

    get name(){
        console.log('contacts', this.contacts);
        return this.contacts.data.fields.Name.value;
    }
    get nomeDeGuerra(){
        return this.contacts.data.fields.NomeDeGuerra__c.value;
    }
    get nivelDoHeroi(){
        return this.contacts.data.fields.NivelDoHeroi__c.value;
    }

}