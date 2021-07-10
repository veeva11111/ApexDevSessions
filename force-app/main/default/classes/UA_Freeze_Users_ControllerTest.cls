@isTest(SeeAllData=False)
private class UA_Freeze_Users_ControllerTest {

    @isTest  static void allMethodTest(){
UA_Freeze_Users_Controller c1 = new  UA_Freeze_Users_Controller();
c1.getSelect();
c1.getDeselect(); 
c1.getDeselectedValues();
c1.getSelectedValues();
c1.cancel();
        c1.updateUserLoginToFreezeUsers();
     
     }
}