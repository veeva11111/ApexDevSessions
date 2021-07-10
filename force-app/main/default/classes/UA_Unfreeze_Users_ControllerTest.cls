@isTest(SeeAllData=False)
private class UA_Unfreeze_Users_ControllerTest {

    @isTest  static void allMethodTest(){
UA_Unfreeze_Users_Controller c1 = new  UA_Unfreeze_Users_Controller();
c1.getSelect();
c1.getDeselect(); 
c1.getDeselectedValues();
c1.getSelectedValues();
c1.cancel();
c1.updateUserLoginToUnfreezeAllUsers();
c1.updateUserLoginToUnfreezeSysAdmUsers();
c1.getProfileNames();
c1.updateUserLoginToUnfreezeProfileSpecUsers();
c1.getRoleNames();
c1.updateUserLoginToUnfreezeRoleSpecUsers();
c1.getGroupNames();
c1.updateUserLoginToUnfreezeGroupSpecUsers();

     
     }
}