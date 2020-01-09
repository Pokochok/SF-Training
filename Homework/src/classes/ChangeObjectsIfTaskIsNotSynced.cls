/**
 * Created by Павлик on 23/12/2019.
 */

global class ChangeObjectsIfTaskIsNotSynced implements Database.Batchable<SObject>, Database.Stateful{
    global Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator('SELECT WhatId, Is_Synced__c, Account_Owner__c, Account.Name FROM Task WHERE Is_Synced__c=false');
    }

    global void execute(Database.BatchableContext bc, List<Task> tasks){
        Set<Id> accountIds = new Set<Id>();
        for (Task task: tasks){
            accountIds.add(task.WhatId);
            task.Is_Synced__c = true;
            task.Account_Owner__c = task.Account.Name;
        }
        List<Account> accounts = new List<Account>();
        for (Account account : [SELECT Updated_By_Task__c FROM Account WHERE Id IN :accountIds]){
            account.Updated_By_Task__c = true;
            accounts.add(account);
        }
        if (!tasks.isEmpty()) {
            update tasks;
            update accounts;
        }
    }

    global void finish(Database.BatchableContext bc){
        System.debug('End of batch executing');
    }
}