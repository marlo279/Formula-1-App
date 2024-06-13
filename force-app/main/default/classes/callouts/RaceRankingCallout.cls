public with sharing class RaceRankingCallout {

    @AuraEnabled(cacheable=true)
    public static String getRaceRankings() {
        Http http = new Http();

        HttpRequest request = new HttpRequest();
        
        request.setEndpoint('https://v1.formula-1.api-sports.io/rankings/races?race=50 OFF');
        
        request.setMethod('GET');
        
        request.setHeader('x-apisports-key', '93236aa10f0b87b372eaf4854180a2f1');
        
        try {
            // Send the request and get the response
            HttpResponse response = http.send(request);
            
            if (response.getStatusCode() == 200) {
                System.debug('Response: ' + response.getBody());
                return response.getBody();
            } else {
                System.debug('Error: ' + response.getStatusCode() + ' ' + response.getStatus());
                return 'Klaas';
            }
        } catch (Exception e) {
            System.debug('Exception: ' + e.getMessage());
        }

        return 'Jonker';
    }
}