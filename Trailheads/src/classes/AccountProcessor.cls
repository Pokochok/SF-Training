/**
 * Created by Павлик on 22/12/2019.
 */

public with sharing class AccountProcessor {
    @Future
    public static void countContacts(List<Id> ids){
        List<Account> accounts = new List<Account>();
        for (Id id : ids){
            List<List<SObject>> sObjects = [FIND '' IN ALL FIELDS RETURNING Account(Id WHERE Id=:id),
                Contact(Id WHERE AccountId=:id)];
            Account account = (Account)sObjects[0].get(0);
            account.Number_of_Contacts__c = sObjects[1].size();
            accounts.add(account);
        }
        update accounts;
    }
}