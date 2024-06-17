public with sharing class ChassisService {

    public static List<Chassis__c> getAllChassis(){
        return [SELECT Id, Name, Team__c, Price__c, ChassisImgUrl__c FROM Chassis__c];
    }

}