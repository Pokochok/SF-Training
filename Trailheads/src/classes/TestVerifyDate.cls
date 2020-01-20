@IsTest
public with sharing class TestVerifyDate {
    @IsTest static void testCheckDates_Within30Days(){
        Date expected = Date.newInstance(2020, 1, 10);
        Date date1 = Date.newInstance(2020, 1, 1);
        Date actual = VerifyDate.CheckDates(date1, expected);
        System.assertEquals(expected, actual);
    }

    @IsTest static void testCheckDates_Without30Days(){
        Date date2 = Date.newInstance(2020, 2, 10);
        Date date1 = Date.newInstance(2020, 1, 1);
        Date expected = Date.newInstance(2020, 1, 31);
        Date actual = VerifyDate.CheckDates(date1, date2);
        System.assertEquals(expected, actual);
    }
}