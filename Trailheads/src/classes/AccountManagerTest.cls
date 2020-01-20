@IsTest
public with sharing class AccountManagerTest {

    @TestSetup
    public static void setup() {
        Account expectedAccount = new Account(Name = 'Test1', BillingCity = 'Test1');
        insert expectedAccount;
    }

    @IsTest
    public static void getAccountTest() {
        Account expectedAccount = [SELECT Id FROM Account WHERE Name = 'Test1'];
        RestRequest request = new RestRequest();
        request.requestUri = '/services/data/v47.0/sobjects/Account/' + expectedAccount.Id;
        request.httpMethod = 'GET';
        RestContext.request = request;
        Account account = AccountManager.getAccount();
        System.assert(account != null);
        System.assertEquals(expectedAccount.Id, account.Id);
    }

    @IsTest
    public static void createAccountTest() {
        Id accountId = AccountManager.createAccount('Test2');
        System.assert(accountId != null);
        Account account = [SELECT Name FROM Account WHERE Name = 'Test2'];
        System.assert(account != null);
    }

    @IsTest
    public static void upsertAccountTest() {
        Account expectedAccount = [SELECT Name, BillingCity FROM Account WHERE Name = 'Test1'];
        expectedAccount.BillingCity = 'Prague';
        RestRequest request = new RestRequest();
        request.requestUri = '/services/data/v47.0/sobjects/Account/';
        request.httpMethod = 'PUT';
        request.requestBody = Blob.valueOf(JSON.serialize(expectedAccount));
        RestContext.request = request;
        Id accountId = AccountManager.upsertAccount();
        System.assert(accountId != null);
        System.assertEquals(expectedAccount.Id, accountId);
        Account account = [SELECT BillingCity FROM Account WHERE Id = :accountId];
        System.assertEquals('Prague', account.BillingCity);
    }

    @IsTest
    public static void deleteAccountTest() {
        Account expectedAccount = [SELECT Name, BillingCity FROM Account WHERE Name = 'Test1'];
        RestRequest request = new RestRequest();
        request.requestUri = '/services/data/v47.0/sobjects/Account/' + expectedAccount.Id;
        request.httpMethod = 'DELETE';
        RestContext.request = request;
        AccountManager.deleteAccount();
        System.assertEquals(0, [SELECT COUNT() FROM Account WHERE Id = :expectedAccount.Id]);
    }

    @IsTest
    public static void updateAccountTest() {
        Account expectedAccount = [SELECT Name, BillingCity FROM Account WHERE Name = 'Test1'];
        expectedAccount.BillingCity = 'Prague';
        RestRequest request = new RestRequest();
        request.requestUri = '/services/data/v47.0/sobjects/Account/' + expectedAccount.Id;
        request.httpMethod = 'PATCH';
        request.requestBody = Blob.valueOf(JSON.serialize(expectedAccount));
        RestContext.request = request;
        Id accountId = AccountManager.updateAccountFields();
        System.assert(accountId != null);
        System.assertEquals(expectedAccount.Id, accountId);
        Account account = [SELECT BillingCity FROM Account WHERE Id = :accountId];
        System.assertEquals('Prague', account.BillingCity);
    }
}