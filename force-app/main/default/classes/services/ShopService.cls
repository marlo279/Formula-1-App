public with sharing class ShopService {

    public static Profile__c profile = getProfile();

    public static String buyDriver(String driverName){

        Decimal profileBalance = ShopService.profile.Balance__c;

        Driver__c driver = [SELECT Id, Price__c FROM Driver__c WHERE Name = :driverName];
        Decimal driverPrice = driver.Price__c;


        if (profileBalance >= driverPrice) {
            Inventory__c item_Driver = new Inventory__c();
            item_Driver.Driver__c = driver.Id;
            item_Driver.Profile__c = profile.Id;
            item_Driver.Item_Type__c = 'Driver';
            insert item_Driver;
            
            ShopService.updateProfileBalance(driverPrice.intValue());
        }


        return 'Je hebt Driver ';

    }

    public static Profile__c getProfile(){
        Id userId = UserInfo.getUserId();
        return [SELECT Id, Balance__c FROM Profile__c WHERE UserId__c = :userId];
    }



    public static void updateProfileBalance(Integer balance){

        ShopService.profile.Balance__c -= balance;
        update ShopService.profile;

    }

}