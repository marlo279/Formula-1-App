public class Score {

@AuraEnabled
public String achievement;

@AuraEnabled
public Integer points;

@AuraEnabled
public String category;

public Score(String achievement, Integer points, String category ) {
    this.achievement = achievement;
    this.points = points;
    this.category = category;
}

}