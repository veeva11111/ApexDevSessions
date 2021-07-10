@isTest
private class UA_Download_Frozen_Users_ControllerTest{
    @isTest static void testAllMethods() {
        UA_Download_Frozen_Users_Controller c = new UA_Download_Frozen_Users_Controller();
        c.SaveAspdf();
        c.SaveAsExcel();
        c.SaveAsWord();
    }
    }