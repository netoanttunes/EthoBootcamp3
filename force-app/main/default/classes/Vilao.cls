public class Vilao extends Contato {
    
    public String habilidade;
    public String nomeDeVilao;
    
    public Vilao(String habilidade, String nomeDeVilao){
        super(nomeDeVilao + ' Bonzinho', nomeDeVilao.replace(' ', '') + '@email.com' );
        this.habilidade = habilidade;
        this.nomeDeVilao = nomeDeVilao;
    }
}