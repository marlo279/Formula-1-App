public with sharing class ChassisController {

    @AuraEnabled(cacheable=true)
    public static List<Chassis__c> getAllChassis(){
        return ChassisService.getAllChassis();
    }

}