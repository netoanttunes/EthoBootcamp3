@RestResource(urlMapping='/marvel/availableheroes/*')
global class GetAvailableHeroesIS {
    
    @httpGet
    global static String doGet(){
        
        String habilidadeParam = RestContext.request.params.get('habilidade');
        String nivelParam = RestContext.request.params.get('nivel');
        
        
        return habilidadeParam;
    }   

}