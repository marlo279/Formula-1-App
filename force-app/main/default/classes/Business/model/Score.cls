public class Score {

@AuraEnabled
public String achievement;

@AuraEnabled
public Integer points;

@AuraEnabled
public String category;

@AuraEnabled
public String icon;

public Score(String achievement, Integer points, String category, String icon ) {
    this.achievement = achievement;
    this.points = points;
    this.category = category;
    this.icon = icon;
}

}