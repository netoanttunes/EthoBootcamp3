public class ContactTriggerHelper {
    
    public static void criaTarefaParaEncontrarFraquezasVilao( List<Contact> newRecords ){
  		List<task> taskToInsert = new List<Task>();
        for( Contact contato: newRecords ){
            ID vilaoId = Schema.SObjectType.Contact.getRecordTypeInfosByDeveloperName().get('Vilao').getRecordTypeId();
            if( contato.RecordTypeId == vilaoId ){
                Task tarefa = new Task();
                	tarefa.Subject 	= 'Descobrir fraquezas do Vilão';
                	tarefa.OwnerId	= contato.OwnerId;
                	tarefa.WhoId 	= contato.Id;
                	tarefa.Status  	= 'Open';  
                taskToInsert.add(tarefa);
            }
        }
        if( !taskToInsert.isEmpty() ){
        	insert taskToInsert;    
        }
    }

    public static void naoPermiteApagarQuandoExisteTaskEmAberto( List<Contact> oldRecords, Map<ID, Contact> mapOld ){
       
        List<Task> tasks = [SELECT id, status, WhoId From task WHERE WhoId IN :oldRecords and Status != 'Completed'];
        
        for(Task tarefa : tasks){
			mapOld.get( tarefa.WhoId ).addError('Não é possivel deletar contatos com tarefas em aberto!!!');            
        }
        
    }

}