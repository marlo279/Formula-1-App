public with sharing class GameEngine {

    public static List<Score> CalculateScore(String grandPrix) {

        // Get current Results
        List<Results__c> results = GrandPrixService.getResultsByGrandprix(grandPrix);

        // Get User Profile
        Profile__c profile = getUserProfile();

        String engineManufacturerOne = profile.Team__r.CarOne__r.Engine__r.Team__c;
        String engineManufacturerTwo = profile.Team__r.CarTwo__r.Engine__r.Team__c;
        String chassisManufacturerOne = profile.Team__r.CarOne__r.Chassis__r.Team__c;
        String chassisManufacturerTwo = profile.Team__r.CarTwo__r.Chassis__r.Team__c;
        String driverOne = profile.Team__r.CarOne__r.Driver__r.Name;
        String driverTwo = profile.Team__r.CarTwo__r.Driver__r.Name;
   
        // Calculate Engine Points
        List<Score> enginePoints = calculateEnginePoints(results, engineManufacturerOne, engineManufacturerTwo);

        // Calculate Chassis Points
        List<Score> chassisPoints = calculateChassisPoints(results, chassisManufacturerOne, chassisManufacturerTwo);

        // Calculate Driver Points
        List<Score> driverPoints = calculateDriverPoints(results, driverOne, driverTwo);

        List<Score> scoreList = new List<Score>();
        scoreList.addAll(enginePoints);
        scoreList.addAll(chassisPoints);
        scoreList.addAll(driverPoints);

        updateProfileCareer(scoreList, profile);

        return scoreList;
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
                Team__r.CarTwo__r.Chassis__r.Team__c,

                Balance__c,
                Points__c
     
            FROM Profile__c
            WHERE UserId__c = :userId
        ];

        return profileRecord;
    } 

    
    public static List<Score> calculateEnginePoints(List<Results__c> results, String engineManufacturerOne, String engineManufacturerTwo) {


        List<Decimal> positionsForEngineOne = getPositionsByTeam(results, engineManufacturerOne);
        List<Decimal> positionsForEngineTwo = getPositionsByTeam(results, engineManufacturerTwo);
        List<Decimal> combinedPositions = new List<Decimal>();

        combinedPositions.addAll(positionsForEngineOne);
        combinedPositions.addAll(positionsForEngineTwo);

        Score totalScore = ScoreSystem.positionPoints(combinedPositions, 'Engine');
        
        List<Score> scoreList = new List<Score>();
        scoreList.add(totalScore);

        return scoreList;
    }

    public static List<Score> calculateChassisPoints(List<Results__c> results, String ChassisOne, String ChassisTwo) {

        List<Decimal> positionsForChassisOne = getPositionsByTeam(results, ChassisOne);
        List<Decimal> positionsForChassisTwo = getPositionsByTeam(results, ChassisTwo);
        List<Decimal> combinedPositions = new List<Decimal>();

        combinedPositions.addAll(positionsForChassisOne);
        combinedPositions.addAll(positionsForChassisTwo);

        Score totalScore = ScoreSystem.positionPoints(combinedPositions, 'Chassis');

        List<Score> scoreList = new List<Score>();
        scoreList.add(totalScore);

        return scoreList;
    }

    public static List<Score> calculateDriverPoints(List<Results__c> results, String driverOne, String driverTwo) {

        Decimal positionsForChassisOne = getPositionsByDriver(results, driverOne);
        Decimal positionsForChassisTwo = getPositionsByDriver(results, driverTwo);
        List<Decimal> combinedPositions = new List<Decimal>();

        combinedPositions.add(positionsForChassisOne);
        combinedPositions.add(positionsForChassisTwo);

        Score totalScore = ScoreSystem.positionPoints(combinedPositions, 'Driver');

        List<Score> scoreList = new List<Score>();
        scoreList.add(totalScore);

        return scoreList;
    }

    public static List<Decimal> getPositionsByTeam(List<Results__c> results, String team) {

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

    public static Decimal getPositionsByDriver(List<Results__c> results, String driver) {

        Decimal position = 20;

        for(Results__c result : results) {
            if (result.Driver__c == driver) {
                position = result.position__c;
            }
        }

        return position;

    }

    // IMPORTANT: To many DML statements error, I cant save updated score and balance data
    public static void updateProfileCareer(List<Score> scoreList, Profile__c profile) {


        Integer totalPoints = 0;

        for (Score score : scoreList) {
            totalPoints += score.points;
        }

        Integer newBalance = 100 * totalPoints;
        Integer newScore = totalPoints;

    }
    

}
