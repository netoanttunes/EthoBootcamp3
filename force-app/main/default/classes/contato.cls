public virtual class contato {
	
    //visibilidade - tipo de variavel - nome da variavel
    private String nome;
    private String email;    
    
    public Contato(String nome, String email){
        this.nome = nome;
        this.email = email;
    }
    
    public void informaDados(){
        System.debug('>>> nome :: '+this.nome);
        System.debug('>>> nome :: '+this.email);
    }
    
    public static void mostrarTodosContatos( List<Contato> contatos ){
        for( Contato personagem : contatos){
            System.debug('>>> personagem ::' +personagem);
        }        
   }
}