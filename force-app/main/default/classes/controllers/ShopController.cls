public with sharing class ShopController {

    @AuraEnabled(cacheable=true)
    public static String buyDriver(String driverName){
        return ShopService.buyDriver(driverName);
    }
    


}