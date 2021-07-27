public class ContactTriggerHandler {
    
    public void onBeforeInsert( List<Contact> newRecords){        
        System.debug('>>> onBeforeInset <<<');      
    }
    
    public void onBeforeUpdate( List<Contact> newRecords, Map<ID, Contact> oldMap ){        
        System.debug('>>> onBeforeUpdate <<<');      
    }
    
	public void onAfterInsert( List<Contact> newRecords ){        
        System.debug('>>> onAfterInsert <<<');
       	ContactTriggerHelper.criaTarefaParaEncontrarFraquezasVilao(newRecords); 		        
    }  
    
    public void onAfterUpdate( List<Contact> newRecords, Map<ID, Contact> oldMap ){    
        System.debug('>>> onAfterUpdate <<<');
    }
    
    public void onBeforeDelete( List<Contact> oldRecords, Map<ID, Contact> oldMap ){    
        System.debug('>>> onAfterUpdate <<<');
        ContactTriggerHelper.naoPermiteApagarQuandoExisteTaskEmAberto( oldRecords, oldMap );
    }

}