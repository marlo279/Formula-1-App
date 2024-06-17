public with sharing class DriverController {

    @AuraEnabled(cacheable=true)
    public static List<Driver__c> getAllDrivers() {
        return DriverService.getAllDrivers();
    }

}