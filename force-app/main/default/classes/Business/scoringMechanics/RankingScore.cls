public with sharing class RankingScore {

    public static Map<Integer, Integer> positionPointsMap = new Map<Integer, Integer>{
        1 => 50,
        2 => 35,
        3 => 30,
        4 => 20,
        5 => 18,
        6 => 15,
        7 => 13,
        8 => 10,
        9 => 7,
        10 => 5,
        11 => 4,
        12 => 3,
        13 => 3,
        14 => 2,
        15 => 1,
        16 => 0,
        17 => 0,
        18 => 0,
        19 => 0,
        20 => 0
    };

    public static Integer getPointsByPosition(Integer position) {
        if (positionPointsMap.containsKey(position)) {
            return positionPointsMap.get(position);
        } else {
            throw new IllegalArgumentException('Invalid position: ' + position);
        }
    }
    
}