/**
 * Created by Павлик on 20/12/2019.
 */

public with sharing class ContactSearch {
    public static List<Contact> searchForContacts(String lastName, String mailingPostalCode){
        List<Contact> contacts = [SELECT Name FROM Contact WHERE
            (LastName = :lastName AND MailingPostalCode = :mailingPostalCode)];
        return contacts;
    }
}