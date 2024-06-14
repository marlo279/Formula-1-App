public with sharing class GameEngine {

    public static Decimal CalculateScore(String grandPrix) {

        // Get current Results
        List<Results__c> results = GrandPrixService.getResultsByGrandprix(grandPrix);

        // Get User Profile
        Profile__c profile = getUserProfile();

        String engineOne = profile.Team__r.CarOne__r.Engine__r.Name;
        String engineManufacturerOne = profile.Team__r.CarOne__r.Engine__r.Team__c;
        String engineTwo = profile.Team__r.CarTwo__r.Engine__r.Name;
        String engineManufacturerTwo = profile.Team__r.CarTwo__r.Engine__r.Team__c;


        
        // Calculate Engine Points
        // Decimal engineOneName = calculateEnginePoints(results, engineManufacturerOne, engineManufacturerTwo);


        return 33.0;
    }

    // public static List<Results__c> getGrandPrixResults(String grandPrix) {
    //     return GrandPrixService.getResultsByGrandprix(grandPrix);
    // }

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

    // List<Results__c> results, String engineManufacturerOne, String engineManufacturerTwo
    public static List<Score> calculateEnginePoints() {

        //START
        List<Results__c> results = GrandPrixService.getResultsByGrandprix('Monaco Grand Prix');
        String engineManufacturerOne = 'Ferrari';
        String engineManufacturerTwo = 'Mercedes';
        //STOP

        List<Decimal> positionsForEngineOne = getPositions(results, engineManufacturerOne);
        List<Decimal> positionsForEngineTwo = getPositions(results, engineManufacturerTwo);
        List<Decimal> combinedPositions = new List<Decimal>();

        combinedPositions.addAll(positionsForEngineOne);
        combinedPositions.addAll(positionsForEngineTwo);

        Score totalScore = ScoreSystem.enginePositionPoints(combinedPositions);
        List<Score> scoreList = new List<Score>();
        scoreList.add(totalScore);
        scoreList.add(totalScore);
        scoreList.add(totalScore);
        scoreList.add(totalScore);
        scoreList.add(totalScore);
        scoreList.add(totalScore);
        scoreList.add(totalScore);




        return scoreList;
    }

    public static List<Decimal> getPositions(List<Results__c> results, String team) {

        List<Driver__c> driverRecords = [SELECT Id, Name
                              FROM Driver__c
                              WHERE Team__c = :team]; 
        
        List<Decimal> positions = new List<Decimal>();

        for (Results__c result : results) {
            for (Driver__c driver : driverRecords) {
                if (driver.Name.contains(result.Driver__c)) {
                    positions.add(result.position__c);
                }
            }
        }

        return positions;
    }


}
