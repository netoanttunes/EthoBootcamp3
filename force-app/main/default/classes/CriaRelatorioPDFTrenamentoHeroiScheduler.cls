public class CriaRelatorioPDFTrenamentoHeroiScheduler implements Schedulable {
    
    public void execute(SchedulableContext sc) {
        run();
    }

    public static void run(){
        CriaRelatorioPDFTrenamentoHeroiBachable relatorioTreinamentoPDF = new CriaRelatorioPDFTrenamentoHeroiBachable();
        Id BatchId = Database.executeBatch(relatorioTreinamentoPDF, 10);
        System.debug('>>> BATCH IN :: ' + BatchId);
    }
}