@RestResource(urlMapping='/marvel/availableheroesold/*')
global class GeyAvailableHeroesIS {
    
    @httpGet
    global static String doGet(){
        
        String habilidadeParam = RestContext.request.params.get('habilidade');
        String nivelParam = RestContext.request.params.get('nivel');
        
        
        return habilidadeParam;
    }   

}