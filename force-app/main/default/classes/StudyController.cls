public class StudyController {
    
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContacts() {
        return [SELECT Id, Name FROM Contact];
    }

    @AuraEnabled(cacheable=true)
    public static Contact getContact() {
        return [SELECT Id, Name FROM Contact LIMIT 1];
    }

}