public with sharing class RankingController {

    @AuraEnabled(cacheable=true)
    public static List<Rank__c> getLastThreeRanks() {
        return RankingService.getLastThreeRanks();
    }

}