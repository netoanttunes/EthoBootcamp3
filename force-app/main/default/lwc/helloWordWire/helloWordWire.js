import { LightningElement, wire, api } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';

const FIELDS = [
    'Contact.Name',
];

export default class HelloWordWire extends LightningElement {

    @api recordId;
    
    @wire(getRecord, {
        recordId : '$recordId',
        fields: FIELDS,
    })
    contact;

    get name(){
        return this.contact.data.fields.name.value;
    }

}