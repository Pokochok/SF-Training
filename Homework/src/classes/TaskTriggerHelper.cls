/**
 * Created by Павлик on 23/12/2019.
 */

public with sharing class TaskTriggerHelper {
    public static void plansDiscussedToTrueWhenTaskCompleted(List<Task> tasks){
        Set<Id> accountIdsToTrue = new Set<Id>();
        Set<Id> accountIdsToFalse = new Set<Id>();
        for(Task task : tasks){
            if (task.Status == 'Completed') {
                accountIdsToTrue.add(task.WhatId);
            } else {
                accountIdsToFalse.add(task.WhatId);
            }
        }
        Set<Account> accountsToTrue = new Set<Account>([SELECT Plans_Discussed__c FROM Account WHERE Id IN :accountIdsToTrue]);
        Set<Account> accountsToFalse = new Set<Account>([SELECT Plans_Discussed__c FROM Account WHERE Id IN :accountIdsToFalse]);
        for (Account account : accountsToTrue){
            account.Plans_Discussed__c = true;
        }
        for (Account account : accountsToFalse){
            account.Plans_Discussed__c = false;
        }
        accountsToFalse.addAll(accountsToTrue);
        System.debug('accountsToFalse0' + accountsToFalse);
        update new List<Account>(accountsToFalse);
    }
}