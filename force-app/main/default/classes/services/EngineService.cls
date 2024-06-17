public with sharing class EngineService {

    public static List<Engine__c> getAllEngines(){
        return [SELECT Id, Name, Team__c FROM Engine__c];
    }

}