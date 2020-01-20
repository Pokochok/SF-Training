@IsTest
global class AccountCalloutMock {
    global static StaticResourceCalloutMock get(String method)
    {
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        switch on method{
            when 'GET' {
                mock.setStaticResource('GetStaticResource');
            } when 'POST', 'PUT', 'PATCH' {
                mock.setStaticResource('PostPutPatchStaticResource');
            } when else {
                mock.setStaticResource('EmptyStaticResource');
            }
        }
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json');
        return mock;
    }
}