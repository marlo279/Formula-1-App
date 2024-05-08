public class EngineController {

    public EngineController() {

    }

    @AuraEnabled(cacheable=true)
    public static List<Engine__c> getEngines() {
        return [SELECT Id, Name FROM Engine__c];
    }

    @AuraEnabled(cacheable=true)
    public static Engine__c getEngineById(Id engineId) {
        return [SELECT Id, Name, Team__c FROM Engine__c WHERE Id = :engineId LIMIT 1];
    }


}