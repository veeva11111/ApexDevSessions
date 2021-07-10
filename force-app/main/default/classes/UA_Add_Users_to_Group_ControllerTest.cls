@isTest(SeeAllData=False)
private class UA_Add_Users_to_Group_ControllerTest {

    @isTest  static void getProfileNamesTest(){
     List<Profile> ProfilesInOrg = [SELECT ID, Name from Profile];   
       UA_Add_Users_to_Group_Controller c1 = new UA_Add_Users_to_Group_Controller();
     List<selectOption> ProfileList = c1.getProfileNames();
     
     }
    
     @isTest  static void getGroupNamesTest(){
       
       UA_Add_Users_to_Group_Controller c2 = new UA_Add_Users_to_Group_Controller();
     List<selectOption> GroupList = c2.getGroupNames();
     
     }
    
     @isTest  static void createUpdateGroupMemberTest(){
     //List<Profile> ProfilesInOrg = [SELECT ID, Name from Profile];   
       UA_Add_Users_to_Group_Controller c3 = new UA_Add_Users_to_Group_Controller();
       c3.createUpdateGroupMember();
         c3.cancel();
         c3.verifyUserAddition();
     
     }
    
    
    
}