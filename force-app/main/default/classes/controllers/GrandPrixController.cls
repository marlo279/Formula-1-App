public with sharing class GrandPrixController {
    
    @AuraEnabled(cacheable=true)
    public static List<String> getAllGrandPrixes() {
        return GrandPrixService.getAllGrandPrixes();
    }

    @AuraEnabled
    public static GrandPrix__c getCircuitByGrandPrix(String grandPrix){
        return GrandPrixService.getCircuitByGrandPrix(grandPrix);
    }

    @AuraEnabled(cacheable=true)
    public static String getGrandPrixByCurrentDate(){
        return GrandPrixService.getGrandPrixByCurrentDate();
    }

    @AuraEnabled(cacheable=true)
    public static List<Score> CalculateScore(){
        return GrandPrixService.CalculateScore('Canadian Grand Prix');
    }

}