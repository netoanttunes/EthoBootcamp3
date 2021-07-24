public class AtualizaRankingScheduler implements Schedulable{
    
    public void execute(SchedulableContext sc) {
        run();
    }

    public void run(){
        Datetime now = System.now();

        List<HabilidadeContato__c> habilidadesContato = [SELECT Id, Contato__c 
                                                        FROM HabilidadeContato__c 
                                                        WHERE Level__c != null
                                                        AND SystemModstamp >= :now.addMinutes(-30) ALL ROWS];

        Set<Id> idsContato = new Set<Id>();
        for(HabilidadeContato__c habilidadeContato :  habilidadesContato){
            idsContato.add(habilidadeContato.Contato__c);
        }

        HabilidadeContatoBO.getInstance().atualizaRanking(idsContato);

    }
}