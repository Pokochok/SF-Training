/**
 * Created by Павлик on 22/12/2019.
 */

@IsTest
public with sharing class AccountProcessorTest {
    @IsTest
    static void testCountContacts() {
        Account account1 = new Account(Name = 'Josh');
        List<Id> ids = new List<Id>();
        ids.add(account1.Id);
        Test.startTest();
        AccountProcessor.countContacts(ids);
        Test.stopTest();
        Account account = [SELECT Number_of_Contacts__c FROM Account WHERE Id = :account1.Id];
        Integer contactsNumberActual = (Integer)account.Number_of_Contacts__c;
        System.assertEquals(1, contactsNumberActual);
    }
}