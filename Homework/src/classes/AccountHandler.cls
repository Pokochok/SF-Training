public class AccountHandler {
    public static Boolean afterUpdateProcessingFirstRun = true;

    public static void afterInsertProcessing(Map<Id, Account> oldAccounts, Map<Id, Account> newAccounts){
        AccountTriggerHelper.createNewTaskAndLinkWithAccount(oldAccounts.keySet());
    }

    public static void afterUpdateProcessing(Map<Id, Account> oldAccounts, Map<Id, Account> newAccounts){
        if(afterUpdateProcessingFirstRun) {
            afterUpdateProcessingFirstRun = false;
            AccountTriggerHelper.changeContactsOfAccountsWhenBillingAddressUpdated(oldAccounts.values(), newAccounts.values());
            AccountTriggerHelper.changeTasksUser(newAccounts.keySet());
        }
    }
}