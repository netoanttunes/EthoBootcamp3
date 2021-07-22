public class EstudoSOQL {
    
    public static List<Contact> getAllContacts(){
        List<Contact> contatos = [SELECT ID, Name, CreatedDate FROM Contact];        
        return contatos;
        
        //OU
		//[SELECT ID, Name, CreatedDate FROM Contact];
    }
    
    public static Contact getContactById(Id contactId){
        Contact contato = [SELECT ID, Name, CreatedDate FROM Contact WHERE Id = :contactId]; 
        return contato;
        
        //List<Contact> contatos = [SELECT ID, Name, CreatedDate, (SELECT Id, Habilidade__r.Name FROM HabilidadeContato__r) FROM Contact WHERE Id = :contactId];
        //if(!conta)
    }
    
    public static Map<String, decimal> getAvgByContact(){
        AggregateResult[] results = [SELECT Contato__r.NomeDeGuerra__c NomeDeGuerra, AVG(Level__c) mediaLevel
										FROM  HabilidadeContato__c
										GROUP BY Contato__r.NomeDeGuerra__c
										HAVING AVG(Level__c) > 0
										ORDER BY AVG(Level__c) DESC];
        Map<String,Decimal> mapa = new map<String, Decimal>();
                                                     
        for(AggregateResult agResult : results){
        	String nomeGuerra = (String) agResult.get('NomeDeGuerra');
            Decimal mediaLevel = (Decimal) agResult.get('mediaLevel');
            mapa.put(nomeGuerra, mediaLevel);
        }
                                                     
        return mapa;
    }
    
    public static List<HabilidadeContato__c> getHabilidadesPorCOntatoOrHabilidades(String NomeDeGuerra, String nomeHabilidade){
        String query = 'SELECT Id, Habilidade__r.Name, Level__c, Contato__r.NomeDeGuerra__c FROM  HabilidadeContato__c WHERE ';
    
        if(!String.isEmpty(NomeDeGuerra)){
            query += 'Contato__r.NomeDeGuerra__c = :NomeDeGuerra';
                }else{
                    query += 'Habilidade__r.Name = :nomeHabilidade';
                }
        
        List<HabilidadeContato__c> HabilidadesDoContato = Database.query(query);
        
        return HabilidadesDoContato;
            
    }
    
}