@isTest
public class ContactCreateTaskTest {
    
    @testSetup
    public static void setup(){
    
    	Contact capitaoAmerica = new Contact(FirstName='Steve', LastName='Rogers', NomeDeGuerra__c='Capitão América', StatusCandidato__c='Em Análise');
    	Contact viuvaNegra = new Contact(FirstName='Natasha', LastName='Romanoff', NomeDeGuerra__c='Viúva Negra', StatusCandidato__c='Em Análise');
        
        List<Contact> herois = new List<Contact> {capitaoAmerica, viuvaNegra};
        insert herois;
        
		Habilidade__c arteMarcial = new Habilidade__c(Name='Arte Marcial');
        Habilidade__c atirador = new Habilidade__c(Name='Atirador');
        Habilidade__c superForca = new Habilidade__c(Name='Super Força');
        
        List<Habilidade__c> habilidades = new List<Habilidade__c>{superForca, atirador, arteMarcial};
        insert habilidades;
        
        HabilidadeContato__c habilidadeContato1 = new HabilidadeContato__c();
        habilidadeContato1.Contato__c = capitaoAmerica.Id;
        habilidadeContato1.Habilidade__c = superForca.Id;
        
        HabilidadeContato__c habilidadeContato2 = new HabilidadeContato__c();
        habilidadeContato2.Contato__c = capitaoAmerica.Id;
        habilidadeContato2.Habilidade__c = arteMarcial.Id;
        
        HabilidadeContato__c habilidadeContato3 = new HabilidadeContato__c();
        habilidadeContato3.Contato__c = viuvaNegra.Id;
        habilidadeContato3.Habilidade__c = arteMarcial.Id;   

        List<HabilidadeContato__c> habilidadesContato = new List<HabilidadeContato__c>{habilidadeContato1, habilidadeContato2, habilidadeContato3};
        insert habilidadesContato;
    }  
    
    @isTest
    public static void ValidarCriacaoDeTask(){        
        List<Contact> contatos = [SELECT Id FROM contact WHERE StatusCandidato__c='Em Análise'];
        
        for(Contact contato: contatos){
            contato.StatusCandidato__c='AprovadoDireto';
        } 
        
        update contatos;
        
        List<task> tasks = [SELECT Id, Subject, Description FROM task ];
        
        system.assertEquals(2, tasks.size());
        system.assertEquals('Alocar contato em Batalha', tasks[0].Subject);
        system.assert(tasks[0].Description.contains('Super Força'));        
        
    }
}