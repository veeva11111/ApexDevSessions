@isTest(SeeAllData=False)

private class UA_Assign_Role_to_Users_ControllerTest {

@isTest  static void allMethodTest(){
UA_Assign_Role_to_Users_Controller c1 = new UA_Assign_Role_to_Users_Controller();
c1.getProfileNames();
c1.getRoleNames(); 
c1.updateUsersWithRole();
c1.cancel();
c1.verifyRoleAssignment();
     
     }
}