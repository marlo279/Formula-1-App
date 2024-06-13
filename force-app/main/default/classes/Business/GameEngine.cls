public with sharing class GameEngine {

    public static String CalculateScore(String grandPrix) {

        // Get current Results
        List<Results__c> results = GrandPrixService.getResultsByGrandprix(grandPrix);

        // Get User Profile
        Profile__c profile = getUserProfile();

        String engineOne = profile.Team__r.CarOne__r.Engine__r.Name;
        String producerEngineOne = profile.Team__r.CarOne__r.Engine__r.Team__c;
        String engineTwo = profile.Team__r.CarTwo__r.Engine__r.Name;
        String producerEngineTwo = profile.Team__r.CarTwo__r.Engine__r.Team__c;


        
        // Calculate Engine Points
        String engineOneName = calculateEnginePoints(results, producerEngineOne, producerEngineTwo);

        return engineOneName;
    }

    public static List<Results__c> getGrandPrixResults(String grandPrix) {
        return GrandPrixService.getResultsByGrandprix(grandPrix);
    }

    public static Profile__c getUserProfile() {

        Id userId = UserInfo.getUserId();

        Profile__c profileRecord = [
            SELECT Id,
                Team__r.Name,
        
                Team__r.CarOne__r.Driver__r.Name, 
                Team__r.CarTwo__r.Driver__r.Name,
        
                Team__r.CarOne__r.Engine__r.Name,
                Team__r.CarOne__r.Engine__r.Team__c,
                Team__r.CarTwo__r.Engine__r.Name,
                Team__r.CarTwo__r.Engine__r.Team__c,
        
                Team__r.CarOne__r.Chassis__r.Name,
                Team__r.CarTwo__r.Chassis__r.Name
     
            FROM Profile__c
            WHERE UserId__c = :userId
        ];

        return profileRecord;
    } 

    public static List<Decimal> getPositions(List<Results__c> results, String team, String driver) {

        List<Decimal> positions = new List<Decimal>();

        for (Results__c result : results) {
            if(result.Team__c == team) {
                positions.add(result.position__c);
            }
        }

        return positions;

    }

    public static String calculateEnginePoints(List<Results__c> results, String producerEngineOne, String producerEngineTwo) {
        return producerEngineOne;
    }


}
