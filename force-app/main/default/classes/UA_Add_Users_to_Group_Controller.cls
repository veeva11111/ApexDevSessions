public with sharing class UA_Add_Users_to_Group_Controller{
public List<profile> profiles{get; set;}
public List<User> UsersToAdd{get; set;}
public List<Group> GrpId{get; set;}

public List<profile> profilesVerify{get; set;}
public List<User> UsersToAddVerify{get; set;}
public List<Group> GrpIdVerify{get; set;}

public String SelectedProfile{get;set;}
public String SelectedGroup{get;set;}
List<selectOption> AllProfiles = new List<selectOption>();
List<selectOption> AllGroups = new List<selectOption>();
Public UA_Add_Users_to_Group_Controller(){   } 
// Picklist for profiles
public List<selectOption> getProfileNames() {
AllProfiles.clear();
AllProfiles.add(new SelectOption('','-None-'));
for(Profile prf : [select Id,name from profile]) {
AllProfiles.add(new selectOption(prf.name,prf.name));
}
return AllProfiles;
}
// Picklist for groups
public List<selectOption> getGroupNames() {
AllGroups.clear();
AllGroups.add(new SelectOption('','-None-'));
for(Group grp : [SELECT Id, name, type FROM Group where type ='regular']) {
AllGroups.add(new selectOption(grp.name,grp.name));
}
return AllGroups;
}
//Add users for the selected profile to the selected group
Public void createUpdateGroupMember(){
List<GroupMember> GMList = new List<GroupMember>();
UsersToAdd = [SELECT ID, name, profile.name from user where profile.name = :SelectedProfile AND ID NOT IN (SELECT UserOrGroupId FROM GroupMember where group.name = :SelectedGroup)];
GrpId = [SELECT Id FROM Group where name = :SelectedGroup];
profiles = [SELECT name FROM profile WHERE Name =:SelectedProfile];
if(SelectedProfile == '' || SelectedProfile == null || profiles.size() == 0 )
ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'Please check profile name'));
if(SelectedGroup == '' || SelectedGroup == null || GrpId.size() == 0)
ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please check group name'));
if ((profiles.size()>0) && (UsersToAdd.size()> 0) && (GrpId.size() > 0)){  
//for loop should execute in case users and the group--both exist   
    for(User U : UsersToAdd) {
            GroupMember GM = new GroupMember();
            GM.GroupId = GrpId[0].Id;
            GM.UserOrGroupId = U.Id;
            GMList.add(GM);         
        }
        System.debug('Group Member List is ' + GMList);
      insert GMList;
      ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,'Users are successfully added to the group'));
    }
    
else if ((profiles.size()>0) && (UsersToAdd.size() == 0) && (GrpId.size() > 0))
ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'Users are already added or profile has no user assigned'));
}   
//Go to the initial vf page
public pageReference cancel() {
PageReference pageRef = page.UA_Add_Users_To_Group_VF;
//PageReference pageRef = new PageReference('/');
pageRef.setRedirect(true);
return pageRef;     
    } 
//Verify that all the users associated with selected profile is already added to the selected group or not
Public void verifyUserAddition(){
UsersToAddVerify = [SELECT ID, name, profile.name from user where profile.name = :SelectedProfile AND ID NOT IN (SELECT UserOrGroupId FROM GroupMember where group.name = :SelectedGroup)];
GrpIdVerify = [SELECT Id FROM Group where name = :SelectedGroup];
profilesVerify = [SELECT name FROM profile WHERE Name =:SelectedProfile];
if((SelectedProfile == '') || (SelectedProfile == null) || (profilesVerify.size() == 0) )
ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'Please check profile name'));
if((SelectedGroup == '') || (SelectedGroup == null) || (GrpIdVerify.size() == 0))
ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please check group name'));
if ((profilesVerify.size()>0) && (UsersToAddVerify.size()> 0) && (GrpIdVerify.size() > 0)){  
       ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'Please click on Add Users To Group button to add users to the group'));
    } 
else if ((profilesVerify.size()>0) && (UsersToAddVerify.size() == 0) && (GrpIdVerify.size() > 0))
ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'Users are already added or profile has no user assigned'));
}
}