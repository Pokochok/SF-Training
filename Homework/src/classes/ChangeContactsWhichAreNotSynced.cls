global class ChangeContactsWhichAreNotSynced implements Database.Batchable<Contact> {
    global static Iterable<Contact> start(Database.BatchableContext bc){
        return [SELECT Is_Synced__c, MailingAddress, MailingStreet, MailingState, MailingPostalcode, MailingCountry, MailingCity, 
AccountId, Account.BillingAddress, Account.BillingStreet, Account.BillingState, Account.BillingPostalcode, Account.BillingCountry, Account.BillingCity
FROM Contact WHERE Is_Synced__c=false];
    }
    
    global static void execute(Database.BatchableContext bc, List<Contact> contacts){
        Set<Id> accountsIds = new Set<Id>();
        for(Contact contact : contacts){
            if(contact.Account.BillingAddress != null){
                contact.MailingStreet = contact.Account.BillingStreet;
                contact.MailingState = contact.Account.BillingState;
                contact.MailingPostalcode = contact.Account.BillingPostalcode;
                contact.MailingCountry = contact.Account.BillingCountry;
                contact.MailingCity = contact.Account.BillingCity;
                contact.Is_Synced__c = true;
                accountsIds.add(contact.AccountId);
            }
        }
        List<Account> accounts = [SELECT Updated_By_Contact__c FROM Account WHERE Id IN :accountsIds];
        for(Account account : accounts){
            account.Updated_By_Contact__c = true;
        }
        if(!contacts.isEmpty() && !accounts.isEmpty()){
            update contacts;
            update accounts;
        }
    }
    
    global static void finish(Database.BatchableContext bc){
        System.debug('Finishing executing change contacts batch');
    }
}