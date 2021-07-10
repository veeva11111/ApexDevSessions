public with sharing class CarTypeSearch {
 @AuraEnabled
   public static List<CarType__c> getCarTypes(){
        return [SELECT Id, Name from CarType__c]; 
        } 
}