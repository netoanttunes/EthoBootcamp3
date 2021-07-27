public class AtualizarRankingHabilidadesScheduler implements Schedulable{

    public Integer minutes;
    public Boolean runOnlyOnce;

    public AtualizarRankingHabilidadesScheduler(){
        this.minutes = 60;
        this.runOnlyOnce = false;
    }

    public AtualizarRankingHabilidadesScheduler(Integer minutes, Boolean runOnlyOnce){
        this.minutes = minutes;
        this.runOnlyOnce = runOnlyOnce;
    }

    public void reeschedule(){
        Datetime nextMinute = System.now().addMinutes(minutes);

        Integer year = nextMinute.year();
        Integer month = nextMinute.month();
        Integer day = nextMinute.day();
        Integer hour = nextMinute.hour();
        Integer min = nextMinute.minute();
        Integer ss = nextMinute.second();

        String nextFireTime = ss + ' ' + min + ' ' + hour + ' ' + day + ' ' + month + ' ? ' + year;

        AtualizarRankingHabilidadesScheduler scheduler = new AtualizarRankingHabilidadesScheduler();

        String jobId = '';

        if(runOnlyOnce){
            System.schedule('AtualizarRankingHabilidadesScheduler - Starded: ' + String.valueOf(Datetime.now()), nextFireTime, scheduler);
        }else{
            System.schedule('AtualizarRankingHabilidadesScheduler  AUTOMATIC - IT RUNS EVERY '+minutes+ ' minute(s)', nextFireTime, scheduler);
        }

    }

    public void execute(SchedulableContext sc){
        //Eliminando Job Existente
        Id jobId = sc.getTriggerId();
        System.abortJob(jobId);

        if(!runOnlyOnce) reeschedule();

        run();
    }

    public void run(){
        AtualizaRankingBatchable ranking = new AtualizaRankingBatchable();
        Id BatchId = Database.executeBatch(ranking, 10);
        System.debug('>>> BATCH IN :: ' + BatchId);
    }

    public static void starJob(Integer minutes, Boolean runOnlyOnce){
        new AtualizarRankingHabilidadesScheduler(minutes, runOnlyOnce).reeschedule();
    }

}