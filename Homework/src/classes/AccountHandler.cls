public class AccountHandler {
    public static Boolean afterUpdateProcessingFirstRun = true;
    public static Boolean afterInsertProcessingFirstRun = true;

    public static void afterInsertProcessing(Map<Id, Account> oldAccounts, Map<Id, Account> newAccounts){
        if (afterInsertProcessingFirstRun) {
            afterInsertProcessingFirstRun = false;
            AccountTriggerHelper.createNewTaskAndLinkWithAccount(newAccounts.keySet());
        }
    }

    public static void afterUpdateProcessing(Map<Id, Account> oldAccounts, Map<Id, Account> newAccounts){
        if(afterUpdateProcessingFirstRun) {
            afterUpdateProcessingFirstRun = false;
            AccountTriggerHelper.changeContactsOfAccountsWhenBillingAddressUpdated(oldAccounts.values(), newAccounts.values());
            AccountTriggerHelper.changeTasksUser(newAccounts.keySet());
        }
    }
}