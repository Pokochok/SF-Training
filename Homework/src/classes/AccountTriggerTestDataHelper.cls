@IsTest
public class AccountTriggerTestDataHelper {
    public static Set<Id> createAccountIds(Integer idAmount){
        Set<Id> ids = new Set<Id>();
        for (Integer i = 1; i <= idAmount; i++) {
            if (i >= 100) {
                ids.add('0012w0000' + i + 'lmcAAA');
            } else if (i < 100 && i >= 10) {
                ids.add('0012w00000' + i + 'lmcAAA');
            } else {
                ids.add('0012w000000' + i + 'lmcAAA');
            }
        }
        return ids;
    }

    public static Map<String, Account> createAccounts(Integer accAmount, Boolean neededToInsert) {
        Map<String, Account> accounts = new Map<String, Account>();
        for (Integer i = 1; i <= accAmount; i++) {
            accounts.put('Account ' + i, new Account(Name = 'Account ' + i));
        }
        return accounts;
    }

    public static List<Contact> assignContactsToAccounts(List<Account> accounts){
        List<Contact> contacts = new List<Contact>();
        for (Account account : accounts){
            for (Integer i = 1; i <= 3; i++) {
                contacts.add(new Contact(AccountId = account.id, FirstName = account.Name + i, LastName = account.Name + 'Last ' + i));
            }
        }

        return contacts;
    }

    public static List<Task> assignTasksToAccounts(List<Account> accounts) {
        List<Task> tasks = new List<Task>();
        for (Account account : accounts){
            for (Integer i = 1; i <= 3; i++) {
                tasks.add(new Task(Subject = i + ' task assigned to ' + account.Name, WhatId = account.Id));
            }
        }

        return tasks;
    }
}