@isTest(SeeAllData=False)
private class UA_Add_Group_to_Group_ControllerTest {
    
     @isTest  static void getGroupToAddTest(){
     List<Group> GroupCreatedList = UA_TestDataFactory.CreateGroups(10);   
       UA_Add_Group_to_Group_Controller c1 = new UA_Add_Group_to_Group_Controller();
     List<selectOption> GroupList = c1.getGroupToAdd();
     
     }
    
     @isTest  static void getTargetGroupTest(){
     List<Group> GroupCreatedList = UA_TestDataFactory.CreateGroups(15);   
       UA_Add_Group_to_Group_Controller c2 = new UA_Add_Group_to_Group_Controller();
     List<selectOption> GroupList = c2.getTargetGroup();
     
     }
    
     @isTest  static void createUpdateGroupMemberTest(){
     List<Group> GroupCreatedList = UA_TestDataFactory.CreateGroups(15);  
       
     UA_Add_Group_to_Group_Controller c3 = new UA_Add_Group_to_Group_Controller();
     GroupMember gm = new GroupMember(GroupId =GroupCreatedList[0].Id, UserOrGroupId = GroupCreatedList[1].Id );
     insert gm;
     c3.GroupToBeAdded = GroupCreatedList;
     c3.GrpId_Target = GroupCreatedList;
     c3.createUpdateGroupMember();

         
     
     }
    
      @isTest  static void verifyGroupAdditionTest(){
     List<Group> GroupCreatedList = UA_TestDataFactory.CreateGroups(15);   
     UA_Add_Group_to_Group_Controller c4 = new UA_Add_Group_to_Group_Controller();
     c4.verifyGroupAddition();
     
     }
    
    @isTest  static void cancelTest(){
     //List<Group> GroupCreatedList = UA_TestDataFactory.CreateGroups(15);   
     UA_Add_Group_to_Group_Controller c5 = new UA_Add_Group_to_Group_Controller();
     c5.cancel();
     
     }  
}