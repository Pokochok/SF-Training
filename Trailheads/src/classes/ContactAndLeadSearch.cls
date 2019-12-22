/**
 * Created by Павлик on 21/12/2019.
 */

public with sharing class ContactAndLeadSearch {
    public static List<List<SObject>> searchContactsAndLeads(String substring){
        List<List<SObject>> sObjects = [FIND :substring IN ALL FIELDS RETURNING Contact(Name, LastName),
            Lead(Name, LastName)];
        return sObjects;
    }
}