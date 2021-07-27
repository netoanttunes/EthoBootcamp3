public class AtualizaRankingBatchable implements Database.Batchable<SObject>{
    
    public AtualizaRankingBatchable() {}

    public AtualizaRankingBatchable(Integer minutes) {}

    public Database.QueryLocator start(Database.BatchableContext bc){
        System.debug('Start');

        return Database.getQueryLocator(
            'SELECT Id, Contato__c FROM HabilidadeContato__c ALL ROWS'
        );
    }

    public void execute(Database.BatchableContext bc, List<HabilidadeContato__c> records){
        System.debug('Execute');

        
        Set<Id> idsContato = new Set<Id>();
        for(HabilidadeContato__c habilidadeContato :  records){
            idsContato.add(habilidadeContato.Contato__c);
        }

        HabilidadeContatoBO.getInstance().atualizaRanking(idsContato);
    }

    public void finish(Database.BatchableContext bc){
        System.debug('Execute');

        AsyncApexJob job = [SELECT Id, Status, NumberOfErrors, JobItemsProcessed, TotalJobItems, CreatedBy.Email
                            FROM AsyncApexJob
                            WHERE Id = : bc.getJobId()];

        System.debug('>>> JOB :: ' + job);
    }
}