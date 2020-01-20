/**
 * Created by Павлик on 23/12/2019.
 */

public with sharing class AccountTriggerHelper {
    @Future
    public static void createNewTaskAndLinkWithAccount(Set<Id> accountIds) {
        List<Task> tasks = new List<Task>();
        for (Account acc : [SELECT Name FROM Account WHERE Account.Id IN :accountIds]) {
            tasks.add(new Task(Subject = 'Negotiations with ' + acc.Name, WhatId = acc.Id, Is_Synced__c = false));
        }
        if (!tasks.isEmpty()) {
            insert tasks;
        }
    }

    public static void changeContactsOfAccountsWhenBillingAddressUpdated(List<Account> oldAccounts, List<Account> newAccounts) {
        Map<Id, Account> updatedAccounts = new Map<Id, Account>();
        for (Integer i = 0; i < newAccounts.size(); i++) {
            if (oldAccounts[i].BillingCity != newAccounts[i].BillingCity
                    || oldAccounts[i].BillingCountry != newAccounts[i].BillingCountry
                    || oldAccounts[i].BillingStreet != newAccounts[i].BillingStreet
                    || oldAccounts[i].BillingPostalCode != newAccounts[i].BillingPostalCode) {
                updatedAccounts.put(newAccounts[i].Id, newAccounts[i]);
            }
        }
        if (!updatedAccounts.isEmpty()) {
            System.debug('Count of changed accounts is ' + newAccounts.size());
            performChangingContactsOfAccountsWhenBillingAddressUpdated(updatedAccounts.keySet());
            ChangeContactsWhenBillingAddressUpdated changeContacts =
                    new ChangeContactsWhenBillingAddressUpdated(updatedAccounts);
            System.enqueueJob(changeContacts);
        }
    }

    @Future
    public static void performChangingContactsOfAccountsWhenBillingAddressUpdated(Set<Id> accountIds) {
        List<Contact> contacts = [SELECT Is_Synced__c, Processed_By_Future__c FROM Contact WHERE AccountId IN :accountIds];
        for (Contact contact : contacts) {
            contact.Is_Synced__c = false;
            contact.Processed_By_Future__c = true;
        }
        if (!contacts.isEmpty()) {
            update contacts;
        }
    }
    
    public static void changeTasksUser(Set<Id> accountsIds){
        List<Task> tasks = [SELECT OwnerId, WhatId FROM Task WHERE WhatId IN :accountsIds];
        User integrationUser = [SELECT Id FROM User WHERE Email = 'integration@example.com'];
        Map<Id, List<Task>> accountIdsWithTasks = new Map<Id, List<Task>>();
        for(Id accountId : accountsIds){
            List<Task> tasksOfAccount = new List<Task>();
            for(Task task : tasks){
                if(accountId == task.WhatId){
                    tasksOfAccount.add(task);
                }
            }
            accountIdsWithTasks.put(accountId, tasksOfAccount);
        }
        Set<Task> tasksToUpdate = new Set<Task>(); 
        for(List<Task> tasksOfAccount: accountIdsWithTasks.values()){
            if(tasksOfAccount.size() > 3){
                for(Task task : tasksOfAccount){
                    task.OwnerId = integrationUser.Id;
                    tasksToUpdate.add(task);
                }
            }
        }
        if(!tasksToUpdate.isEmpty()){
            update new List<Task>(tasksToUpdate);
        }
    }
}