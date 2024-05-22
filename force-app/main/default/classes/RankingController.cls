public with sharing class RankingController {


    @AuraEnabled(cacheable=true)
    public static List<Rank__c> getLastThreeRanks() {
        List<Rank__c> rankRecords = [
            SELECT Id, Rank__c, 
                Team__r.Id, Team__r.logoImgUrl__c, Team__r.Name, Team__r.DriverOne__r.Name, Team__r.DriverTwo__r.Name,
                Team__r.DriverOne__r.DriverImgUrl__c, Team__r.DriverTwo__r.DriverImgUrl__c
            FROM Rank__c
            ORDER BY Rank__c DESC
            LIMIT 3
        ];
            
        return rankRecords;
    }

}