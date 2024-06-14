public class Score {

@AuraEnabled
public String title;

@AuraEnabled
public Integer points;

@AuraEnabled
public String category;

public Score(String title, Integer points, String category ) {
    this.title = title;
    this.points = points;
    this.category = category;
}

}