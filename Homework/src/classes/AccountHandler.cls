public class AccountHandler {
    public static void createNewTaskAndLinkWithAccount(List<Account> accounts){
        List<Task> tasks = new List<Task>();
        for (Account acc : accounts){
            tasks.add(new Task(Subject='Negotiations with ' + acc.Name, WhatId=acc.Id));
        }
        insert tasks;
    }
}