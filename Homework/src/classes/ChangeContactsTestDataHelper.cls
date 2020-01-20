@IsTest
public with sharing class ChangeContactsTestDataHelper {
    public static List<Account> createAccounts(Integer accAmount, Boolean neededToInsert) {
        List<Account> accounts = new List<Account>();
        for (Integer i = 1; i <= accAmount; i++) {
            accounts.add(new Account(Name = 'Account ' + i, BillingStreet = 'Test', BillingState = 'Test',
                    BillingPostalCode = '000001', BillingCountry = 'Test', BillingCity = 'Test'));
        }

        return accounts;
    }

    public static List<Contact> assignContactsToAccounts(List<Account> accounts){
        List<Contact> contacts = new List<Contact>();
        for (Account account : accounts){
            for (Integer i = 1; i <= 3; i++) {
                contacts.add(new Contact(Is_Synced__c = false, AccountId = account.id, FirstName = account.Name + i, LastName = account.Name + 'Last ' + i));
            }
        }

        return contacts;
    }
}