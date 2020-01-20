@IsTest
public with sharing class ChangeContactsWhichAreNotSyncedTest {
    @TestSetup
    public static void setup() {
        List<Account> accounts = ChangeContactsTestDataHelper.createAccounts(100, true);
        insert accounts;
        List<Contact> contacts = ChangeContactsTestDataHelper.assignContactsToAccounts(accounts);
        if (!contacts.isEmpty()) {
            insert contacts;
        }
    }

    @IsTest
    public static void executeTest() {
        Test.startTest();
        Database.executeBatch(new ChangeContactsWhichAreNotSynced(), 400);
        Test.stopTest();
        System.assertEquals(300, [SELECT COUNT() FROM Contact WHERE Is_Synced__c = TRUE]);
        System.assertEquals(100, [SELECT COUNT() FROM Account WHERE Updated_By_Contact__c = TRUE]);
    }
}