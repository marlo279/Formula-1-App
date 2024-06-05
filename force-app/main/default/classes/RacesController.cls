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

    @AuraEnabled
    public static Races__c getGrandPrixByName(String grandPrix){
        try {

            Races__c circuitRecord = [
                SELECT Name, Laps__c, RaceDate__c, CircuitUrl__c, Circuit__c
                FROM Races__c
                WHERE Name = :grandPrix
            ];

            return circuitRecord;
            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }



}