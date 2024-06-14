public with sharing class ScoreSystem {


    public static Score positionPoints(List<Decimal> positions, String category) {

        Integer total = 0; 

        for (Decimal position : positions) {
            Integer points = RankingScore.getPointsByPosition(position.intValue());
            total += points;
        }

        Score score = new Score( category + ' Points', total, category);
        
        return score;
    }

}