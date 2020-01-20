/**
 * Created by Pavel_Pakanechny on 04-Jan-20.
 */

public class GetAccountUsingRESTAPI {
    private static final String clientId = '3MVG9n_HvETGhr3ATa1UMxtYu4XqWdwzPD9lT.nGByWLf3.8q20edL7Lh.80F3uxph5BdxDxrZVJc8Lrl9e7w';
    private static final String clientSecret = '3805C2208DC89CA0789C9B36B79A75CCB1296ABA2941416CDC200A055CB08026';
    private static final String username = 'pavel_pakanechny@curious-otter-6mc3bw.com';
    private static final String password = 'Pzoxicuvybtnrm1234567890EiJbdpp4lqiPrIkozfrsdONo';
    private static final String accessToken = '00D2w000000lR44!ARoAQBuykTNOYBNQ.vDfz0uBseZCHphvsVTbS3AWgpO3Mj4.DVx.iJBxWP74gQgV6xVBhox8RuSU1YNGmpud8X5Rn1cvwPOt';

    public static HttpResponse callGetAccount(String accountId) {
        String endPoint = 'https://curious-otter-6mc3bw-dev-ed.my.salesforce.com/services/apexrest/v1/Accounts/' + accountId;
        Http h2 = new Http();
        HttpRequest req1 = new HttpRequest();
        req1.setHeader('Authorization', 'Bearer ' + accessToken);
        req1.setHeader('Content-Type', 'application/json');
        req1.setHeader('accept', 'application/json');
        req1.setMethod('GET');
        req1.setEndpoint(endPoint);
        HttpResponse res1 = h2.send(req1);
        String trimmedResponse = res1.getBody().unescapeCsv().remove('\\');
        system.debug('@@@RESPONSE@@' + trimmedResponse);
        Account account;
        if (res1.getBody().contains('"type":"Account"')) {
            account = (Account) JSON.deserialize(res1.getBody(), Account.class);
        }
//        return account;
        return res1;
    }

    public static HttpResponse callPostAccount(String name) {
        String endPoint = 'https://curious-otter-6mc3bw-dev-ed.my.salesforce.com/services/apexrest/v1/Accounts/';
        Http h2 = new Http();
        HttpRequest req1 = new HttpRequest();
        req1.setHeader('Authorization', 'Bearer ' + accessToken);
        req1.setHeader('Content-Type', 'application/json');
        req1.setHeader('accept', 'application/json');
        req1.setMethod('POST');
        req1.setEndpoint(endPoint);
        req1.setBody('{"name" : "' + name + '"}');
        HttpResponse res1 = h2.send(req1);
        String trimmedResponse = res1.getBody().unescapeCsv().remove('\\');
        system.debug('@@@RESPONSE@@' + trimmedResponse);
        Id accountId;
        if (!res1.getBody().contains('errorCode')) {
            accountId = (Id) JSON.deserialize(res1.getBody(), Id.class);
        }
//        return accountId;
        return res1;
    }

    public static HttpResponse callDeleteAccount(String accountId) {
        String endPoint = 'https://curious-otter-6mc3bw-dev-ed.my.salesforce.com/services/apexrest/v1/Accounts/' + accountId;
        Http h2 = new Http();
        HttpRequest req1 = new HttpRequest();
        req1.setHeader('Authorization', 'Bearer ' + accessToken);
        req1.setHeader('Content-Type', 'application/json');
        req1.setHeader('accept', 'application/json');
        req1.setMethod('DELETE');
        req1.setEndpoint(endPoint);
        HttpResponse res1 = h2.send(req1);
        String trimmedResponse = res1.getBody().unescapeCsv().remove('\\');
        system.debug('@@@RESPONSE@@' + trimmedResponse);
        return res1;
    }

    public static HttpResponse callPutAccount(String name, String ownerId,
            String phone, String accountNumber, String id){
        String endPoint = 'https://curious-otter-6mc3bw-dev-ed.my.salesforce.com/services/apexrest/v1/Accounts/';
        Http h2 = new Http();
        HttpRequest req1 = new HttpRequest();
        req1.setHeader('Authorization', 'Bearer ' + accessToken);
        req1.setHeader('Content-Type', 'application/json');
        req1.setHeader('accept', 'application/json');
        req1.setMethod('PUT');
        req1.setEndpoint(endPoint);
        Account account = new Account(Name = name, OwnerId = ownerId, Phone = phone, AccountNumber = accountNumber, Id = id);
        req1.setBody(JSON.serializePretty(account, true));
        HttpResponse res1 = h2.send(req1);
        String trimmedResponse = res1.getBody().unescapeCsv().remove('\\');
        system.debug('@@@RESPONSE@@ ' + trimmedResponse);
        Id accountId;
        if (!res1.getBody().contains('errorCode')) {
            accountId = (Id) JSON.deserialize(res1.getBody(), Id.class);
        }
//        return accountId;
        return res1;
    }

    public static HttpResponse callPatchAccount(String name, String ownerId,
            String phone, String accountNumber, String accountId){
        String endPoint = 'https://curious-otter-6mc3bw-dev-ed.my.salesforce.com/services/apexrest/v1/Accounts/' + accountId + '?_HttpMethod=PATCH';
        Http h2 = new Http();
        HttpRequest req1 = new HttpRequest();
        req1.setHeader('Authorization', 'Bearer ' + accessToken);
        req1.setHeader('Content-Type', 'application/json');
        req1.setHeader('accept', 'application/json');
        req1.setMethod('POST');
        req1.setEndpoint(endPoint);
        Account account = new Account();
        if (accountId != null) {
            if (ownerId != null) {
                account.OwnerId = ownerId;
            }
            if (phone != null) {
                account.Phone = phone;
            }
            if (accountNumber != null) {
                account.AccountNumber = accountNumber;
            }
            req1.setBody(JSON.serialize(account));
        }
        HttpResponse res1 = h2.send(req1);
        String trimmedResponse = res1.getBody().unescapeCsv().remove('\\');
        system.debug('@@@RESPONSE@@' + trimmedResponse);
        Id accountIdResponse = (Id) JSON.deserialize(res1.getBody(), Id.class);
//        return accountIdResponse;
        return res1;
    }
}