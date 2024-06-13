public with sharing class ProfileController {
    
    @AuraEnabled
    public static Profile__c createProfile(String playerName, Id selectedTeam) {
        return ProfileService.createProfile(playerName, selectedTeam);
    }

    @AuraEnabled(cacheable=true)
    public static User getUser(){
        return ProfileService.getUser();
    }

    @AuraEnabled(cacheable=true)
    public static Profile__c getProfile(){
        return ProfileService.getProfile();
    }

    @AuraEnabled
    public static Boolean playerNameAvailable(String playerName){
        return ProfileService.playerNameAvailable(playerName);
    }

    @AuraEnabled(cacheable=true)
    public static Profile__c getProfileData(){
        return ProfileService.getProfileData();
    }



}