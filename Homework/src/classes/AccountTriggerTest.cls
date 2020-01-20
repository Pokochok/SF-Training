@IsTest
public class AccountTriggerTest {

    @TestSetup static void setup() {
        Map<String, Account> accounts = AccountTriggerTestDataHelper.createAccounts(100, true);
        insert accounts.values();
        List<Contact> contacts = AccountTriggerTestDataHelper.assignContactsToAccounts(accounts.values());
        insert contacts;
        List<Task> tasks = AccountTriggerTestDataHelper.assignTasksToAccounts(accounts.values());
        insert tasks;
    }

    @IsTest
    public static void createNewTaskAndLinkWithAccountTest() {
        Map<String, Account> accounts = AccountTriggerTestDataFactory.createAccounts(100);
        Test.startTest();
        List<Database.SaveResult> results = Database.insert(accounts.values(), false);
        Test.stopTest();
        List<Id> ids = new List<Id>();
        for (Database.SaveResult saveResult : results) {
            if (saveResult.isSuccess()) {
                ids.add(saveResult.id);
            }
        }
        System.assertEquals(100, [SELECT COUNT() FROM Task WHERE AccountId IN :ids]);
    }

    @IsTest
    public static void changeContactsOfAccountsWhenBillingAddressUpdatedTest() {
        List<Account> accounts = [SELECT Name, BillingCity FROM Account LIMIT 50];
        for (Account account : accounts) {
            account.BillingPostalCode = '00000001';
        }
        Test.startTest();
        List<Database.SaveResult> result = Database.update(accounts, false);
        Test.stopTest();
        System.assertEquals(150, [SELECT COUNT() FROM Contact WHERE Processed_By_Future__c = TRUE AND Is_Synced__c = FALSE]);
    }

    @IsTest
    public static void changeTasksUserTest() {
        List<Account> accounts = [SELECT Name, BillingCity FROM Account LIMIT 50];
        for (Account account : accounts) {
            account.BillingCity = 'Prague';
        }
        Test.startTest();
        List<Database.SaveResult> result = Database.update(accounts, false);
        Test.stopTest();
        System.assertEquals(200, [SELECT COUNT() FROM Task WHERE OwnerId = '0052w000000ysEWAAY']);
    }
}