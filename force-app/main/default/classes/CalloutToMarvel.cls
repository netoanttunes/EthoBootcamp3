public with sharing class CalloutToMarvel {

    public static final String apiKey = '8290bff8473b1835eb0715918a1e2adc';
    public static final String hash = '79eac710dfb5c06c45814a698b905c71';

    @future(callout=true)
    public static void getPersonagens() {

        final String endpoint = 'http://gateway.marvel.com/v1/public/events/310/characters?ts=1&apikey='+apiKey+'&hash='+hash;
        try{

            Http http = new Http();
            HttpRequest request = new HttpRequest();

            request.setEndpoint(endpoint);
            request.setMethod('GET');

            System.debug('>>> request ::'+request);

            HttpResponse response = http.send(request);
            
            System.debug('>>> response ::'+response);

            if( response.getStatusCode() == 200 ){
                System.debug('>>> response body ::'+response.getBody());

                Map<String, object> dataResults = (Map<String, object>) JSON.deserializeUntyped(response.getBody());
                Map<String, object> data = (Map<String, object>) dataResults.get('data');

                List<Object> results = (List<Object>) data.get('results');

                if(!results.isEmpty()){
                    upsertPersonagens(results);
                } else {
                    System.debug('>>> StatusCode ::'+ response.getStatusCode());
                }               

            }

        }catch(Exception e){
            System.debug('>>> ERROR ::'+e.getMessage());
        }
    }

    private static void upsertPersonagens( List<Object> lstPersonagens ){
        List<Lead> leadsToUpsert = new List<Lead>();
        for( Object personagem : lstPersonagens ){
            Map<String,Object> mapPersonagem = (Map<String,Object>) personagem;
            System.debug('>>> Nome do personagem ::'+ mapPersonagem.get('name'));

            Lead lead = new Lead();
                lead.Company            = 'Marvel API';
                lead.NomeDeGuerra__c    = String.valueOf(mapPersonagem.get('name'));
                lead.Description        = String.valueOf(mapPersonagem.get('description'));
                lead.LastName           = String.valueOf(mapPersonagem.get('name'));
                lead.LeadSource         = 'Importado pela Marvel API';
            leadsToUpsert.add(lead);
        }

        if(!leadsToUpsert.isEmpty()){
            upsert leadsToUpsert NomeDeGuerra__c;
        }
    }
}