public class GrandPrixService {

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

    public static List<Results__c> getResultsByGrandprix(String grandPrix){
        try {

            GrandPrix__c apiRaceIdRecord = [
                SELECT Id, Race__r.ApiRaceId__c
                FROM GrandPrix__c
                WHERE Name = :grandPrix
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

    @AuraEnabled(cacheable=true) // Tijdelijk
    public static List<Score> totalEnginePoints(){
        try {
            List<Score> points = GameEngine.CalculateScore('Canadian Grand Prix');

            return points;
            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

}