public class AlocacaoBatalhaDefault {

    @AuraEnabled
    public static List<BatalhaDoContato__c> getBatalhas(){
        return [select Id, Batalha__r.Name, Contato__r.NomeDeGuerra__c, Contato__r.RecordType.Name, Contato__r.NivelDoHeroi__c, Batalha__r.Status__c from BatalhaDoContato__c LIMIT 200];
    }

}
