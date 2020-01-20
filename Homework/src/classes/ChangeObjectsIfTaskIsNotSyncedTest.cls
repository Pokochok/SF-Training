@IsTest
public with sharing class ChangeObjectsIfTaskIsNotSyncedTest {
    @TestSetup
    public static void setup() {
        List<Account> accounts = ChangeObjectsTestDataHelper.createAccounts(100, true);
        insert accounts;
        List<Task> tasks = ChangeObjectsTestDataHelper.assignTasksToAccounts(accounts);
        if (!tasks.isEmpty()) {
            insert tasks;
        }

    }

    @IsTest
    public static void executeTest() {
        Test.startTest();
        Database.executeBatch(new ChangeObjectsIfTaskIsNotSynced(), 400);
        Test.stopTest();
        System.assertEquals(100, [SELECT COUNT() FROM Account WHERE Updated_By_Task__c = TRUE]);
        System.assertEquals(400, [SELECT COUNT() FROM Task WHERE Is_Synced__c = TRUE]);
    }
}