public with sharing class EditarContatoHabilControllerExt {

    private Contact contato;

    public List<HabilidadeContato__c> habilidades {get; private set;}

    public EditarContatoHabilControllerExt( ApexPages.StandardController controller ) {


        this.contato = (Contact) controller.getRecord();
        this.habilidades = [ SELECT id, Habilidade__r.Name, Level__c FROM HabilidadeContato__c WHERE Contato__c = :this.contato.Id ];

    }

    public Pagereference cancelar(){
        Pagereference pg = new Pagereference('/'+ this.contato.Id);
        pg.setRedirect(true);
        return pg;
    }

    public void salvar(){
        try{
            update this.contato;
            update this.habilidades;

            ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.CONFIRM, 'Os registros foram atualizados!'));
        }catch( Exception e ){
            System.debug('>>> ERROR::'+e.getMessage());
            ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.ERROR, 'O correu um erro no ao Atualizar registro'));
        }
    }

}
