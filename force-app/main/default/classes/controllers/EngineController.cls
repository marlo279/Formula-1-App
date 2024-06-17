public with sharing class EngineController {

    @AuraEnabled(cacheable=true)
    public static List<Engine__c> getAllEngines(){
        return EngineService.getAllEngines();
    }

}