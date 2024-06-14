public with sharing class ScoreSystem {


    public static Score enginePositionPoints(List<Decimal> positions) {

        Integer total = 0; 

        for (Decimal position : positions) {
            Integer points = RankingScore.getPointsByPosition(position.intValue());
            total += points;
        }

        Score score = new Score('Postion Points', total, 'Engine');
        
        return score;
    }

}