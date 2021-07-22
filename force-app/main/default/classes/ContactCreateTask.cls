global class ContactCreateTask {
    
    @InvocableMethod(label = 'Cria Tarefa para o Contato')
    public static void ContactCreateTask( List<CreateTaskRequest> requests ){
        
        List<Id> lstContactIds = new List<Id>();
        for( CreateTaskRequest request : requests )
            lstContactIds.add(request.contactId);
        
        List<HabilidadeContato__c> lstHabContatos = [ select Id, Contato__c, Habilidade__r.Name from HabilidadeContato__c WHERE Contato__c IN :lstContactIds  ];
                
        Map<Id, List<String>> mapContatoHabilidades = new Map<Id, List<String>>(); 
        for( HabilidadeContato__c habilidadeContato : lstHabContatos ){    
            if( mapContatoHabilidades.containsKey( habilidadeContato.Contato__c ) ){
                mapContatoHabilidades.get( habilidadeContato.Contato__c ).add( habilidadeContato.Habilidade__r.Name );
            }else{
                mapContatoHabilidades.put( habilidadeContato.Contato__c, new List<String>{ habilidadeContato.Habilidade__r.Name } );
            }
        }
        
        if( !requests.isEmpty() )
        	createTasks( requests, mapContatoHabilidades );        
    }
    
    public static void createTasks( List<CreateTaskRequest> requests, Map<Id,List<String>> mapContatoHabilidades ){
        List<Task> tasksToInsert = new List<Task>();
        for( CreateTaskRequest request : requests ){
            Task tarefa = new Task();
            	tarefa.Subject 		= request.subject;
            	tarefa.WhoId   		= request.contactId;
            	tarefa.OwnerId 		= request.ownerId;
            	tarefa.Status  		= 'Open';
            	tarefa.Description 	= 'Por favor avalie este heroi. Suas habilidades são: '+ String.valueOf(mapContatoHabilidades.get(request.contactId));
            tasksToInsert.add(tarefa);
        }  
        
        if( !tasksToInsert.isEmpty() )
            insert tasksToInsert;
    }
    
    global class CreateTaskRequest {
        @InvocableVariable(required=true)
        global String contactId;
        @InvocableVariable(required=true)
        global String ownerId;
        @InvocableVariable
        global String subject;
    }

}