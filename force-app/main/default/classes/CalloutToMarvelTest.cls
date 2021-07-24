@isTest
public class CalloutToMarvelTest {
    
    @isTest
    public static void testaCallout_200(){
        CalloutToMarvelMock mock = new CalloutToMarvelMock(200);

        Test.setMock(HttpCalloutMock.class, mock);

        CalloutToMarvel.getPersonagens();

    }
    
    @isTest
    public static void testaCallout_500(){
        CalloutToMarvelMock mock = new CalloutToMarvelMock(500);

        Test.setMock(HttpCalloutMock.class, mock);

        CalloutToMarvel.getPersonagens();

    }

}