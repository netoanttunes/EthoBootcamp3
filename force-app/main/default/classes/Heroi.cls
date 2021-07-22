public class Heroi extends Contato {
    
    public String habilidade;
    public String nomeDeHeroi;
    
    public Heroi(String habilidade, String nomeDeHeroi){
        super(nomeDeHeroi + ' Bonzinho', nomeDeHeroi.replace(' ', '') + '@email.com' );
        this.habilidade = habilidade;
        this.nomeDeHeroi = nomeDeHeroi;
    }
}