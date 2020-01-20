@IsTest
public with sharing class ChangeObjectsTestDataHelper {
    public static List<Task> assignTasksToAccounts(List<Account> accounts) {
        List<Task> tasks = new List<Task>();
        for (Account account : accounts) {
            for (Integer i = 1; i <= 3; i++) {
                tasks.add(new Task(Is_Synced__c = false, Subject = i + ' task assigned to ' + account.Name, WhatId = account.Id));
            }
        }

        return tasks;
    }

    public static List<Account> createAccounts(Integer accAmount, Boolean neededToInsert) {
        List<Account> accounts = new List<Account>();
        for (Integer i = 1; i <= accAmount; i++) {
            accounts.add(new Account(Name = 'Account ' + i));
        }

        return accounts;
    }
}