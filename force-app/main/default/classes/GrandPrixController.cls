public with sharing class GrandPrixController {

    
    @AuraEnabled(cacheable=true)
    public static List<String> getAllGrandPrixes() {
        List<GrandPrix__c> grandPrixRecords = [
            SELECT Name
            FROM GrandPrix__c
            ORDER BY Date__c
        ];
        
        List<String> grandPrixes = new List<String>();
        
        for (GrandPrix__c grandPrix : grandPrixRecords) {
            grandPrixes.add(grandPrix.Name);
        }
        
        return grandPrixes;

    }

    @AuraEnabled
    public static GrandPrix__c getCircuitByGrandPrix(String grandPrix){
        try {

            GrandPrix__c circuitRecord = [
                SELECT Circuit__r.Name, Circuit__r.Laps__c, Circuit__r.CircuitImgUrl__c, Date__c
                FROM GrandPrix__c
                WHERE Name = :grandPrix
            ];

            return circuitRecord;
            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled(cacheable=true)
    public static String getGrandPrixByCurrentDate(){
        try {

            Date currentDate = Date.today();

            GrandPrix__c circuitRecord = [
                SELECT Circuit__r.Name, Circuit__r.Laps__c, Circuit__r.CircuitImgUrl__c, Date__c, Name
                FROM GrandPrix__c
                WHERE Date__c < :currentDate
                ORDER BY Date__c DESC
                LIMIT 1
            ];

            return circuitRecord.Name;
            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

}