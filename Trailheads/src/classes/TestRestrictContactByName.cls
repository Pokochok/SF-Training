@IsTest
public with sharing class TestRestrictContactByName {
    @IsTest static void testRestrictionContactByName_ValidLastName(){
        Contact contact = new Contact(LastName = 'TestLastName');
        Test.startTest();
        Database.SaveResult result = Database.insert(contact, false);
        Test.stopTest();
        System.assert(result.isSuccess());
        System.assert(result.getErrors().size() == 0);
    }

    @IsTest static void testRestrictionContactByName_InvalidLastName(){
        Contact contact = new Contact(LastName = 'INVALIDNAME');
        Test.startTest();
        Database.SaveResult result = Database.insert(contact, false);
        Test.stopTest();
        System.assert(!result.isSuccess());
        System.assert(result.getErrors().size() > 0);
        System.assertEquals('The Last Name "INVALIDNAME" is not allowed for DML', result.getErrors()[0].getMessage());
    }
}