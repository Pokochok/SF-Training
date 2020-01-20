@IsTest
public with sharing class TaskTriggerTestDataHelper {
    public static List<Account> createAccount(Integer accountAmount) {
        List<Account> accounts = new List<Account>();
        for (Integer i = 1; i <= accountAmount; i++) {
            accounts.add(new Account(Name = 'Account ' + i));
        }
        return accounts;
    }

    public static List<Task> updateTasksOfAccounts(List<Account> accounts, Integer completedAccountsAmount) {
        List<Task> tasks = new List<Task>();
        for (Account account : accounts) {
            completedAccountsAmount--;
            for (Task task : account.Tasks) {
                task.Status = 'Completed';
                tasks.add(task);
            }
            if (completedAccountsAmount <= 0) {
                break;
            }
        }
        update tasks;
        return tasks;
    }
}