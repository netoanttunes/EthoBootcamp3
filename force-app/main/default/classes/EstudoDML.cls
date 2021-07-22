public class EstudoDML {
    
    public static void mainDML(){
        
        List<Contact> contatos = new List<Contact>();
        
        Contact contato1 = new Contact(
        	firstName = 'contato 1',
            lastName = 'Marvel',
            NomeDeGuerra__c = 'Contato 1',
            StatusCandidato__c = 'AprovadoDireto'
        );
        
            Contact contato2 = new Contact(
        	firstName = 'contato 2',
            lastName = 'Marvel',
            NomeDeGuerra__c = 'Contato 2.1',
            StatusCandidato__c = 'AprovadoDireto'
        );
        
            Contact contato3 = new Contact(
        	firstName = 'contato 3',
            lastName = 'Marvel',
            NomeDeGuerra__c = 'Contato 3.1',
            StatusCandidato__c = 'AprovadoDireto'
        );        
       
        contatos.add(contato1);
        contatos.add(contato2);
        contatos.add(contato3);
        
        //insertContact(contatos, true);
        
        List<Contact> contactsToday = [SELECT ID, firstname, lastname, NomeDeGuerra__c FROM Contact WHERE createddate = today];
        
        for(Integer i=0; i < contactsToday.size(); i++){
           contactsToday[i].NomeDeGuerra__c = 'CLONE TRUE' +i;            
        }
        
        //updateContact( contactsToday, true );
        
        
        //upsertContact(contatos, true);
        
        List<Contact> contactsToDelete = [SELECT ID, firstname, lastname, NomeDeGuerra__c FROM Contact WHERE createddate = today AND NomeDeGuerra__c LIKE 'CLONE%'];  
        
        //deleteContact(contactsToDelete, true);
        
        //List<Contact> contactsToUnDelete = [SELECT ID, firstname, lastname, NomeDeGuerra__c FROM Contact WHERE createddate = today AND NomeDeGuerra__c LIKE 'CLONE%' ALL ROWS];
        
        //undeleteContact(contactsToUnDelete, true);
        
        mergeContact(contactsToDelete[0], contactsToDelete[1], true);
                       
    }
    
    public static void insertContact( List<Contact> contatos, Boolean dbMethod ){
        if( dbMethod ){
            Database.SaveResult[] results = Database.insert(contatos, false);
                trataResult(results);
        }else{
            insert contatos;
            System.debug('>>> contatos :: ' +contatos);
        }
    }
    
    public static void updateContact( List<Contact> contatos, Boolean dbMethod ){
        if( dbMethod ){
            Database.SaveResult[] results = Database.update(contatos, false);
                trataResult(results);
        }else{
            update contatos;
            System.debug('>>> contatos :: ' +contatos);
        }
    }
    
   	public static void upsertContact( List<Contact> contatos, Boolean dbMethod ){
        if( dbMethod ){
            Database.UpsertResult[] results = Database.upsert(contatos, Contact.NomeDeGuerra__c, false);
                trataupsertResult(results);
        }else{
            upsert contatos NomeDeGuerra__c;
            System.debug('>>> contatos :: ' +contatos);
        }
    }
    
  	public static void deleteContact( List<Contact> contatos, Boolean dbMethod ){
        if( dbMethod ){
            Database.DeleteResult[] results = Database.delete(contatos, false);
                //trataupsertResult(results);
        }else{
            delete contatos;
            System.debug('>>> contatos :: ' +contatos);
        }
    }
    
    public static void undeleteContact( List<Contact> contatos, Boolean dbMethod ){
        if( dbMethod ){
            Database.UndeleteResult[] results = Database.undelete(contatos, false);
                //trataupsertResult(results);
        }else{
            undelete contatos;
            System.debug('>>> contatos :: ' +contatos);
        }
    }
   
    public static void mergeContact( Contact contato1, Contact contato2, Boolean dbMethod ){
        if( dbMethod ){
            Database.MergeResult results = Database.merge(contato1, contato2, false);
            System.debug('>>> results :: ' +results);
        }else{
            merge contato1 contato2;
            //System.debug('>>> contatos :: ' +contatos);
        }
    }
    
    
    
    
    
    Public static void trataResult(Database.SaveResult[] results){
        for( Database.SaveResult result : results ){
            if( result.isSuccess() ){
                system.debug('SUCESSE. ID do Registro'+ result.getId());
            }else{
                for( Database.Error erro : result.getErrors() ){
                    system.debug( 'Deu erro. Erro'+ erro.getStatusCode() + ': ' + erro.getMessage() );
                }
            }
        }
    }
    
	Public static void trataupsertResult(Database.upsertResult[] results){
        for( Database.upsertResult result : results ){
            if( result.isSuccess() ){
                system.debug('SUCESSE. ID do Registro'+ result.getId());
            }else{
                for( Database.Error erro : result.getErrors() ){
                    system.debug( 'Deu erro. Erro'+ erro.getStatusCode() + ': ' + erro.getMessage() );
                }
            }
        }
    }

}