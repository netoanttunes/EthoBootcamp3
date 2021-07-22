global class NivelHeroi {
    
    @InvocableMethod(label = 'Identifica Nivel do Heroi')
    public static List<Contact> identificaNivelHeroi(List<contactRequest> requests){
        
        List<Contact> contatos = new List<Contact>();
        
        for(contactRequest request : requests){
            Decimal media = 0;
            Decimal somaLevel = 0; 
            
            for(HabilidadeContato__c habilidadeContato : request.habilidadesContato){
                somaLevel += habilidadeContato.Level__c;
            }
            
            media = somaLevel/request.habilidadesContato.size();
            
            String nivel = '';
            if(media >= 80){
            	nivel = 'Sênior'; 	   
            }else if(media >= 40){
                nivel = 'Pleno';
            }else{
                nivel = 'Júnior';
            }            
           
            request.contact.NivelDoHeroi__c = nivel;
            contatos.add(request.contact);
        }
        
        update contatos;
		return contatos;        
    }
    
    global class contactRequest{
        @InvocableVariable(required=true)
        global Contact contact;
        @InvocableVariable(required=true)
        global List<HabilidadeContato__c> habilidadesContato;
    }
    
}