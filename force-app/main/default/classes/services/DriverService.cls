public with sharing class DriverService {

    public static List<Driver__c> getAllDrivers() {
        return [SELECT Name, Price__C, DriverImgUrl__c FROM Driver__c];
    }

}