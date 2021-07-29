import { LightningElement } from 'lwc';

export default class HelloWordBootcamp extends LightningElement {
    something = 'word';
    chandeHandler(event){
        this.something = event.target.value;
    }
}