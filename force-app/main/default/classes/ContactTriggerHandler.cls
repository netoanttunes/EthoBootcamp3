public class ContactTriggerHandler {
    
    public void onBeforeInsert( List<Contact> newRecords ){        
        System.debug('>>> onBeforeInset <<<');        
    }
    
    public void onBeforeUpdate( List<Contact> newRecords, Map<ID, Contact> mapOld ){        
        System.debug('>>> onBeforeUpdate <<<');
        for( Contact contato : newRecords ) {
            System.debug('>>> Before Contato New LastModifiedDate :: ' + contato.LastModifiedDate);
            System.debug('>>> Before Contato New :: ' + contato);
            System.debug('>>> Before Contato Old ::' + mapOld.get(contato.Id));
        }        
    }
    
	public void onAfterInsert( List<Contact> newRecords ){        
        System.debug('>>> onAfterInsert <<<');
       	ContactTriggerHelper.criaTarefaParaEncontrarFraquezasVilao(newRecords); 		        
    }  
    
    public void onAfterUpdate( List<Contact> newRecords, Map<ID, Contact> mapOld ){    
        System.debug('>>> onAfterUpdate <<<');
    }
    
    public void onBeforeDelete( List<Contact> oldRecords, Map<ID, Contact> mapOld ){    
        System.debug('>>> onAfterUpdate <<<');
        ContactTriggerHelper.naoPermiteApagarQuandoExisteTaskEmAberto( oldRecords, mapOld );
    }

}