public with sharing class GrandPrixService {

    public static List<Results__c> getResultsByGrandprix(String grandPrix){
        try {

            GrandPrix__c apiRaceIdRecord = [
                SELECT Id, Race__r.ApiRaceId__c
                FROM GrandPrix__c
                WHERE Name = 'Saudi Arabian Grand Prix'
                LIMIT 1
            ];

            Decimal apiRaceId = apiRaceIdRecord.Race__r.ApiRaceId__c;

            List<Results__c> results = [
                SELECT Id, Driver__c, Grid__c, Laps__c, Pits__c, Points__c, Position__c, Team__c, Time__c
                FROM Results__c
                WHERE ApiRaceId__c = :apiRaceId
                ORDER BY Position__c ASC
            ];

            return results;


        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

}