public with sharing class RaceRankingCallout {

    @AuraEnabled(cacheable=true)
    public static String getRaceRankings() {
        // Create an instance of Http
        Http http = new Http();
        
        // Create an instance of HttpRequest
        HttpRequest request = new HttpRequest();
        
        // Set the endpoint URL
        request.setEndpoint('https://v1.formula-1.api-sports.io/rankings/races?race=50');
        
        // Set the method to GET
        request.setMethod('GET');
        
        // Set the headers
        // request.setHeader('x-rapidapi-host', 'v1.formula-1.api-sports.io');
        request.setHeader('x-apisports-key', '93236aa10f0b87b372eaf4854180a2f1');
        
        try {
            // Send the request and get the response
            HttpResponse response = http.send(request);
            
            // Check the response status code
            if (response.getStatusCode() == 200) {
                // Process the response
                System.debug('Response: ' + response.getBody());
                return response.getBody();
            } else {
                System.debug('Error: ' + response.getStatusCode() + ' ' + response.getStatus());
                return 'Klaas';
            }
        } catch (Exception e) {
            // Handle any exceptions
            System.debug('Exception: ' + e.getMessage());
        }

        return 'Jonker';
    }
}