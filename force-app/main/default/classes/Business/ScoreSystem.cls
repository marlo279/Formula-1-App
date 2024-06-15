public with sharing class ScoreSystem {


    public static Score positionPoints(List<Decimal> positions, String category) {

        Integer total = 0; 
        String achievementName = category + '_Position';

        for (Decimal position : positions) {
            Integer points = RankingScore.getPointsByPosition(position.intValue());
            total += points;
        }

        Achievement__c icon = [SELECT achievementImgUrl__c FROM Achievement__c WHERE Name = :achievementName];

        Score score = new Score( category + ' Points', total, category, icon.achievementImgUrl__c);
        
        return score;
    }

}