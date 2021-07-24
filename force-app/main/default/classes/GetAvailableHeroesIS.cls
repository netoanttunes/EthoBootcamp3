@RestResource(urlMapping='/marvel/availableheroes/*')
global class GetAvailableHeroesIS {
    
    @HttpGet
    global static AvailableHeroes doGet(){
        Map<String, Hero> mapHerois = new Map<String,Hero>();
        List<HabilidadeContato__c> lstHabContatos = new List<HabilidadeContato__c>();
        String habilidadeParam = RestContext.request.params.get('habilidade');
        String nivelParam = RestContext.request.params.get('nivel');
        
        String dynamicQuery = 'select id, Contato__r.NomeDeGuerra__c, Contato__r.NivelDoHeroi__c, Habilidade__r.name, Level__c from HabilidadeContato__c where Contato__r.RecordType.DeveloperName = \'Heroi\' and Contato__c NOT IN ( select Contato__c from BatalhaDoContato__c)';
        if( !String.isBlank(habilidadeParam) ){
            List<String> habilidadesParam = habilidadeParam.split(',');
            dynamicQuery += ' and Habilidade__r.Name IN :habilidadesParam ';
        }
        if( !String.isBlank(nivelParam) ){
            List<String> niveisParam = nivelParam.split(',');
            dynamicQuery += ' and Contato__r.NivelDoHeroi__c IN :niveisParam ';
        } 
        
		lstHabContatos = Database.query(dynamicQuery);
        
        for( HabilidadeContato__c habilidadeContato : lstHabContatos ){
            Skill habilidade = new Skill( habilidadeContato.Habilidade__r.name, String.valueOf(habilidadeContato.Level__c) );
            Hero heroi;    
            
            if( !mapHerois.containsKey( habilidadeContato.Contato__r.NomeDeGuerra__c ) ){
                heroi = new Hero();
                heroi.nome 	= habilidadeContato.Contato__r.NomeDeGuerra__c;
                heroi.nivel = habilidadeContato.Contato__r.NivelDoHeroi__c;
                heroi.habilidades = new List<Skill>{ habilidade };
            }else{
                heroi = mapHerois.get( habilidadeContato.Contato__r.NomeDeGuerra__c );
                heroi.habilidades.add( habilidade );
            }
            mapHerois.put( habilidadeContato.Contato__r.NomeDeGuerra__c, heroi );
        }
        
        return new AvailableHeroes( mapHerois.values() );
        
    }
    
    global class AvailableHeroes{
        public List<Hero> herois;
        public Integer total;
        
        AvailableHeroes( List<Hero> herois ){
            this.herois = herois;
            this.total = herois.size();
        }
    }
    
    global class Hero{
        public String nome;
        public String nivel;
        public List<Skill> habilidades;
    }
    
    global class Skill{
        public String nome;
        public String nivel;
        
        Skill( String nome, String nivel ){
            this.nome = nome;
            this.nivel = nivel != null ? nivel : 'não avaliado';
        }
    }
    

}