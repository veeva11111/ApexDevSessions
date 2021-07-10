public with sharing class UA_Assign_Role_to_Users_Controller{
List<selectOption> AllProfiles = new List<selectOption>();
List<selectOption> AllRoles = new List<selectOption>();
public List<profile> profiles{get; set;}
public List<UserRole> UserRoleList{get; set;}
public List<User> UsersToAssignRole{get; set;}
public String SelectedProfile{get;set;}
public String SelectedRole{get;set;}
Public UA_Assign_Role_to_Users_Controller(){   } 
// Picklist for profiles
public List<selectOption> getProfileNames() {
AllProfiles.clear();
AllProfiles.add(new SelectOption('','-None-'));
for(Profile prf : [select Id,name from profile]) {
AllProfiles.add(new selectOption(prf.name,prf.name));
}
return AllProfiles;
}
// Picklist for roles
public List<selectOption> getRoleNames() {
AllRoles.clear();
AllRoles.add(new SelectOption('','-None-'));
for(UserRole rol : [SELECT Id, name FROM UserRole]) {
AllRoles.add(new selectOption(rol.name,rol.name));
}
return AllRoles;
}
//Role assignment
Public void updateUsersWithRole(){
List<User> UserList = new List<User>();
UsersToAssignRole = [SELECT Id from user where profile.name = :SelectedProfile AND (UserRole.Name !=  :SelectedRole OR UserRole.Name = null)];
UserRoleList = [select Id from UserRole where Name = :SelectedRole];
profiles = [SELECT name FROM profile WHERE Name =:SelectedProfile];
if((SelectedProfile == '') || (SelectedProfile == null) || (profiles.size() == 0) )
ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'Please check profile name'));
if((SelectedRole == '') || (SelectedRole == null )|| (UserRoleList.size() == 0))
ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please check role name'));
if((UserRoleList.size() >0 ) && (UsersToAssignRole.size() >0 )) {
for(User u : UsersToAssignRole ){
   u.UserRoleId = UserRoleList[0].id ;
   UserList.add(u);         
}}

if((!UserList.isEmpty())&& (SelectedProfile != '') && (SelectedProfile != null )&& (profiles.size() > 0) && (UsersToAssignRole.size() >0 )) {
        System.debug('UserList is ' + UserList);
update UserList;
ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,'Role is successfully assigned to the users'));

    }
    else if ((profiles.size()>0) && (UsersToAssignRole.size() == 0) && (UserRoleList.size() > 0))
ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'Role is already assigned to the users'));
    }
//Functionality for cancel button
public pageReference cancel() {
PageReference pageRef = page.UA_Assign_Role_To_Users_VF;
//PageReference pageRef = new PageReference('/');
pageRef.setRedirect(true);
return pageRef;     
    } 
//Verify role assignment to the users
Public void verifyRoleAssignment(){
UsersToAssignRole = [SELECT Id from user where profile.name = :SelectedProfile AND (UserRole.Name !=  :SelectedRole OR UserRole.Name = null)];
UserRoleList = [select Id from UserRole where Name = :SelectedRole];
profiles = [SELECT name FROM profile WHERE Name =:SelectedProfile];
if((SelectedProfile == '') || (SelectedProfile == null) || (profiles.size() == 0 ))
ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'Please check profile name'));
if((SelectedRole == '') || (SelectedRole == null) || (UserRoleList.size() == 0))
ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please check role name'));

if ((profiles.size()>0) && (UsersToAssignRole.size()>0) && (UserRoleList.size() > 0)) 
ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'Click on Assign Role to Users button to assign the role to users'));

else if ((profiles.size()>0) && (UsersToAssignRole.size() == 0) && (UserRoleList.size() > 0))
ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'Role is already assigned to the users'));
}
}