public with sharing class RacesController {

    

    @AuraEnabled(cacheable=true)
    public static List<String> getAllRaces() {
        List<Races__c> raceRecords = [
            SELECT Name
            FROM Races__c
            ORDER BY raceDate__c
        ];
        
        List<String> raceNames = new List<String>();
        
        for (Races__c race : raceRecords) {
            raceNames.add(race.Name);
        }
        
        return raceNames;

    }



}