public class RelatorioPDFTreinamentoBO {

    private static final RelatorioPDFTreinamentoBO instance = new RelatorioPDFTreinamentoBO();

    private RelatorioPDFTreinamentoBO(){

    }

    public static RelatorioPDFTreinamentoBO getInstance(){
        return instance;
    }
   
    public void gerarPDFTreinamento(Set<Id> ids) {

        System.debug('>>> GERAR PDF TREINAMENTO <<<');

        List<Attachment> anexos = new List<Attachment>();
        
        for(id id : ids){
            Pagereference relatorioPDF = new PageReference ( '/apex/relatoriotreinamentoheroi?id='+id ); 
            Attachment anexo = new Attachment();
            anexo.ParentId = id;
            anexo.Name = 'Relatório Treinamento '+Datetime.now().format('yyyy-MM-dd HH:mm:ss.SSSZ');
            anexo.Body = relatorioPDF.getContentAsPDF();

            anexos.add(anexo);
        }

        insert anexos;
    }
}