@IsTest
public with sharing class GetAccountUsingRESTAPITest {
    @IsTest
    public static void callGetAccountTest() {Database.
        StaticResourceCalloutMock mock = AccountCalloutMock.get('GET');
        Test.setMock(HttpCalloutMock.class, mock);
        HTTPResponse res = GetAccountUsingRESTAPI.callGetAccount('0012w000001xxDiAAI');
        System.assertEquals('{"attributes" : {"type" : "Account","url" : "/services/data/v47.0/sobjects/Account/0012w000001xxDiAAI"},"Name" : "CalloutAccount","Id" : "0012w000001xxDiAAI"}', res.getBody());
        System.assertEquals(200, res.getStatusCode());
        System.assertEquals('application/json', res.getHeader('Content-Type'));
    }

    @IsTest
    public static void callPostAccountTest() {
        StaticResourceCalloutMock mock = AccountCalloutMock.get('POST');
        Test.setMock(HttpCalloutMock.class, mock);
        HTTPResponse res = GetAccountUsingRESTAPI.callPostAccount('Name');
        System.assertEquals('"0012w000001xxDiAAI"', res.getBody());
        System.assertEquals(200, res.getStatusCode());
        System.assertEquals('application/json', res.getHeader('Content-Type'));
    }

    @IsTest
    public static void callPutAccountTest() {
        StaticResourceCalloutMock mock = AccountCalloutMock.get('PUT');
        Test.setMock(HttpCalloutMock.class, mock);
        HTTPResponse res = GetAccountUsingRESTAPI.callPutAccount('Name', '0012w000001xxDiAAI', '3333388896', '0001', '0012w000001xxDiAAI');
        System.assertEquals('"0012w000001xxDiAAI"', res.getBody());
        System.assertEquals(200, res.getStatusCode());
        System.assertEquals('application/json', res.getHeader('Content-Type'));
    }

    @IsTest
    public static void callPatchAccountTest() {
        StaticResourceCalloutMock mock = AccountCalloutMock.get('PATCH');
        Test.setMock(HttpCalloutMock.class, mock);
        HTTPResponse res = GetAccountUsingRESTAPI.callPatchAccount('Name', '0012w000001xxDiAAI', '3333388896', '0001', '0012w000001xxDiAAI');
        System.assertEquals('"0012w000001xxDiAAI"', res.getBody());
        System.assertEquals(200, res.getStatusCode());
        System.assertEquals('application/json', res.getHeader('Content-Type'));
    }

    @IsTest
    public static void callDeleteAccountTest() {
        StaticResourceCalloutMock mock = AccountCalloutMock.get('DELETE');
        Test.setMock(HttpCalloutMock.class, mock);
        HTTPResponse res = GetAccountUsingRESTAPI.callDeleteAccount('0012w000001xxDiAAI');
        System.assertEquals('""', res.getBody());
        System.assertEquals(200, res.getStatusCode());
        System.assertEquals('application/json', res.getHeader('Content-Type'));
    }
}