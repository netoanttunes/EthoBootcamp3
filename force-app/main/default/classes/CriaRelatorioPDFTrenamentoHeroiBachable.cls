public class CriaRelatorioPDFTrenamentoHeroiBachable implements Database.Batchable<SObject> {
  

    public Database.QueryLocator start(Database.BatchableContext bc){
        System.debug('>>> Start <<<');

        List<String> statusCandidato = new List<String>();

        Datetime lastHour = Datetime.now().addMinutes(-60);

        String query = 'SELECT Id, Name, DataDaAprovacao__c FROM Contact WHERE DataDaAprovacao__c >= ' +lastHour.format('yyyy-MM-dd')+'T'+lastHour.format('HH:mm:ss.SSSZ') +' AND StatusCandidato__c IN (\'Aprovado no Treinamento\', \'AprovadoDireto\')';
        System.debug('>>> QUERY :: '+query);


        return Database.getQueryLocator(query);
    }

    public void execute(Database.BatchableContext bc, List<Contact> lstContatos){
        System.debug('Execute');

        System.debug('>>> lstContatos :: ' + lstContatos);        

        Set<Id> idsContato = new Set<Id>();
        for(Contact contato :  lstContatos){
            idsContato.add(contato.Id);
        }

        RelatorioPDFTreinamentoBO.getinstance().gerarPDFTreinamento(idsContato);
    }

    public void finish(Database.BatchableContext bc){
        System.debug('Finish');

        AsyncApexJob job = [SELECT Id, Status, NumberOfErrors, JobItemsProcessed, TotalJobItems, CreatedBy.Email
                            FROM AsyncApexJob
                            WHERE Id = : bc.getJobId()];

        System.debug('>>> JOB :: ' + job);
    }
}