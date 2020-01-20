/**
 * Created by Pavel_Pakanechny on 1/3/2020.
 */

@RestResource(urlMapping='/v1/Accounts/*')
global with sharing class AccountManager {
    @HttpGet
    global static Account getAccount() {
        RestRequest request = RestContext.request;
        String accountId = request.requestURI.substring(
                request.requestURI.lastIndexOf('/') + 1);
        Account acc = [SELECT Name, (SELECT Name FROM Contacts) From Account WHERE Id = :accountId];
        return acc;
    }
    @HttpPost
    global static ID createAccount(String name) {
        Account account = new Account(Name = name);
        insert account;
        return account.Id;
    }
    @HttpDelete
    global static void deleteAccount() {
        RestRequest request = RestContext.request;
        String accountId = request.requestURI.substring(
                request.requestURI.lastIndexOf('/') + 1);
        Account acc = [SELECT Id FROM Account WHERE Id = :accountId];
        delete acc;
    }

    @HttpPut
    global static ID upsertAccount() {
        RestRequest request = RestContext.request;
        Account account = (Account) JSON.deserialize(request.requestBody.toString(), Account.class);
        upsert account;
        return account.Id;
    }

    @HttpPatch
    global static ID updateAccountFields() {
        RestRequest request = RestContext.request;
        String accountId = request.requestURI.substring(
                request.requestURI.lastIndexOf('/') + 1);
        Account account = [SELECT Id FROM Account WHERE Id = :accountId];
        Map<String, Object> params = (Map<String, Object>) JSON.deserializeUntyped(request.requestbody.tostring());
        for (String fieldName : params.keySet()) {
            if (fieldName != 'attributes') {
                account.put(fieldName, params.get(fieldName));
            }
        }
        update account;
        return account.Id;
    }
}