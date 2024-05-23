public with sharing class ProfileController {
    
    @AuraEnabled
    public static Profile__c createProfile(String playerName, Id selectedTeam) {
        try {
            // Maak een nieuw Custom Object Record aan

            Id userId = UserInfo.getUserId();
            String userName = [SELECT Name FROM User WHERE Id = :UserInfo.getUserId()].Name;

            Profile__c newProfile = new Profile__c();
            
            newProfile.Name = userName;
            newProfile.Player__c = playerName;
            newProfile.Points__c = 0;
            newProfile.Balance__c = 10000;
            newProfile.Team__c = selectedTeam;

            insert newProfile;
            return newProfile;

        } catch(Exception e) {
            // Vang eventuele fouten op
            System.debug('Fout bij het maken van record: ' + e.getMessage());
            throw new AuraHandledException('Er is een fout opgetreden bij het maken van het record.');
        }
    }

    @AuraEnabled
    public static Boolean playerNameAvailable(String playerName){

        List<Profile__c> checkPlayerName = [SELECT Player__c FROM Profile__c WHERE Player__c = :playerName];

        if (checkPlayerName.isEmpty()) {
            return true; 
        } else {
            return false;
        }
    }

}
