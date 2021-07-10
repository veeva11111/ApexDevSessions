@isTest(SeeAllData=False)
private class UA_SetPassword_ControllerTest  {
@isTest  static void allMethodTest(){
UA_SetPassword_Controller c1 = new  UA_SetPassword_Controller();
c1.getSelectActiveUsers();
c1.getDeselectActiveUsers();
c1.getDeselectedValuesActiveUsers();
c1.getSelectedValuesActiveUsers();
c1.getSelectInactiveUsers();
c1.getDeselectInactiveUsers();
c1.getDeselectedValuesInactiveUsers();
c1.getSelectedValuesInactiveUsers();
c1.setPasswordForActiveSelectedUsers();
c1.activateInactiveSelectedUsers();
c1.cancel();
     }
@isTest  static void trimmedPasswordTest(){
UA_SetPassword_Controller c1 = new  UA_SetPassword_Controller();
string inputPw = c1.InputPassword = '  Password123$';
c1.TrimmedPassword = inputPw.trim();
}
    @isTest  static void activeUsersListTest(){
UA_SetPassword_Controller c1 = new  UA_SetPassword_Controller();
List<User> Users = UA_TestDataFactory.createUsers('System Administrator', 10); 
c1.AllActiveUsersToSetPassword = users; 
}
    
 @isTest  static void picklistValuesActiveUsersTest(){
UA_SetPassword_Controller c1 = new  UA_SetPassword_Controller();
List<User> AllActiveUsers1 = UA_TestDataFactory.createUsers('System Administrator', 10); 
String[] tmpActiveUsers1 = New String[]{};
String nameStringActiveUsers1;

for(user u : AllActiveUsers1){
   tmpActiveUsers1.add(u.name);  
}

nameStringActiveUsers1 = string.join(tmpActiveUsers1,',');
System.debug('Value of the name string is:' + nameStringActiveUsers1);
c1.picklistValuesActiveUsers = nameStringActiveUsers1.split(',');
}

     
    //===============================
 @isTest  static void picklistValuesInactiveUsersTest(){
UA_SetPassword_Controller c1 = new  UA_SetPassword_Controller();
List<User> AllInactiveUsers1 = UA_TestDataFactory.createInactiveUsers('System Administrator', 10); 
String[] tmpInactiveUsers1 = New String[]{};
String nameStringInactiveUsers1;

for(user u : AllInactiveUsers1){
   tmpInactiveUsers1.add(u.name);  
}
nameStringInactiveUsers1 = string.join(tmpInactiveUsers1,',');
c1.picklistValuesInactiveUsers = nameStringInactiveUsers1.split(',');
} 
}