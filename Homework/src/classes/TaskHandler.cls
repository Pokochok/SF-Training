/**
 * Created by Павлик on 22/12/2019.
 */

public with sharing class TaskHandler {
    public static void plansDiscussedToTrueWhenTaskCompleted(List<Task> tasks){
        List<Account> accounts = new List<Account>();
        for (Task task : tasks){
            Account account = [SELECT Plans_Discussed__c FROM Account WHERE Id=:task.WhatId];
            if (task.Status == 'Completed') {
                account.Plans_Discussed__c = true;
            } else {
                account.Plans_Discussed__c = false;
            }
            accounts.add(account);
        }
        update accounts;
    }
}