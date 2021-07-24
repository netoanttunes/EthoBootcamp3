public with sharing class HeroiPDFWithApexController {

    public Contact contato {get; set;}

    public HeroiPDFWithApexController() {
        Id contactId = ApexPages.currentPage().getParameters().get('id');

        this.contato = [SELECT Id, 
                        Name, 
                        NomeDeGuerra__c, 
                        StatusCandidato__c,
                        feedbackTreinamento__c,
                        (SELECT Habilidade__r.Name, Level__c FROM HabilidadeContato__r ORDER BY Level__c DESC)
                        FROM Contact WHERE Id = :contactId ];
    }
}