public with sharing class GameEngine {

    public static List<Score> CalculateScore(String grandPrix) {

        // Get current Results
        List<Results__c> results = GrandPrixService.getResultsByGrandprix(grandPrix);

        // Get User Profile
        Profile__c profile = getUserProfile();

        String engineOne = profile.Team__r.CarOne__r.Engine__r.Name;
        String engineManufacturerOne = profile.Team__r.CarOne__r.Engine__r.Team__c;
        String engineTwo = profile.Team__r.CarTwo__r.Engine__r.Name;
        String engineManufacturerTwo = profile.Team__r.CarTwo__r.Engine__r.Team__c;
        String chassisOne = profile.Team__r.CarOne__r.Chassis__r.Name;
        String chassisManufacturerOne = profile.Team__r.CarOne__r.Chassis__r.Team__c;
        String chassisTwo = profile.Team__r.CarTwo__r.Chassis__r.Name;
        String chassisManufacturerTwo = profile.Team__r.CarTwo__r.Chassis__r.Team__c;



        
        // Calculate Engine Points
        List<Score> enginePoints = calculateEnginePoints(results, engineManufacturerOne, engineManufacturerTwo);

        // Calculate Chassis Points
        List<Score> chassisPoints = calculateChassisPoints(results, chassisManufacturerOne, chassisManufacturerTwo);

        List<Score> combinedPoints = new List<Score>();
        combinedPoints.addAll(enginePoints);
        combinedPoints.addAll(chassisPoints);


        return combinedPoints;
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
                Team__r.CarOne__r.Chassis__r.Team__c,
                Team__r.CarTwo__r.Chassis__r.Name,
                Team__r.CarTwo__r.Chassis__r.Team__c
     
            FROM Profile__c
            WHERE UserId__c = :userId
        ];

        return profileRecord;
    } 

    
    public static List<Score> calculateEnginePoints(List<Results__c> results, String engineManufacturerOne, String engineManufacturerTwo) {


        List<Decimal> positionsForEngineOne = getPositions(results, engineManufacturerOne);
        List<Decimal> positionsForEngineTwo = getPositions(results, engineManufacturerTwo);
        List<Decimal> combinedPositions = new List<Decimal>();

        combinedPositions.addAll(positionsForEngineOne);
        combinedPositions.addAll(positionsForEngineTwo);

        Score totalScore = ScoreSystem.positionPoints(combinedPositions, 'Engine');
        
        List<Score> scoreList = new List<Score>();
        scoreList.add(totalScore);

        return scoreList;
    }

    public static List<Score> calculateChassisPoints(List<Results__c> results, String ChassisOne, String ChassisTwo) {

        List<Decimal> positionsForChassisOne = getPositions(results, ChassisOne);
        List<Decimal> positionsForChassisTwo = getPositions(results, ChassisTwo);
        List<Decimal> combinedPositions = new List<Decimal>();

        combinedPositions.addAll(positionsForChassisOne);
        combinedPositions.addAll(positionsForChassisTwo);

        Score totalScore = ScoreSystem.positionPoints(combinedPositions, 'Chassis');

        List<Score> scoreList = new List<Score>();
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
