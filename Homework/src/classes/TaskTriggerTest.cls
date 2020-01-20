@IsTest
public with sharing class TaskTriggerTest {
    @TestSetup
    public static void setup(){
        insert TaskTriggerTestDataHelper.createAccount(100);
    }

    @IsTest
    public static void plansDiscussedToTrueWhenTaskCompletedTest(){
        Test.startTest();
        TaskTriggerTestDataHelper.updateTasksOfAccounts([SELECT (SELECT Status FROM Tasks) FROM Account], 50);
        Test.stopTest();
        Integer actual = [SELECT COUNT() FROM Account WHERE Plans_Discussed__c = TRUE];
        System.assertEquals(50, actual);
    }
}