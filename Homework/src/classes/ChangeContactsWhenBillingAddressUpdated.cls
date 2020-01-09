/**
 * Created by Павлик on 23/12/2019.
 */

public with sharing class ChangeContactsWhenBillingAddressUpdated implements Queueable {
    private Map<Id, Account> accounts;

    public ChangeContactsWhenBillingAddressUpdated(Map<Id, Account> accounts) {
        this.accounts = accounts;
    }

    public void execute(QueueableContext queueableContext) {
        List<Contact> contacts = new List<Contact>();
        for (Contact contact : [
                SELECT Is_Synced__c, Processed_By_Queue__c
                FROM Contact
                WHERE AccountId IN :accounts.keySet()
        ]) {
            contact.Is_Synced__c = false;
            contact.Processed_By_Queue__c = true;
            contacts.add(contact);
        }
        if (!contacts.isEmpty()) {
            update contacts;
        }
    }
}