public class UA_Unfreeze_Users_Controller {
    public List<user> AllUsersToUnfreeze {get; set;}
    public List<user> SysAdmUsersToUnfreeze {get; set;}
    public List<user> ProfileSpecUsersToUnfreeze {get; set;}
    public List<user> RoleSpecUsersToUnfreeze {get; set;}
    public List<user> GroupSpecUsersToUnfreeze {get; set;}   
    public String SelectedProfile{get;set;}
    public String SelectedRole{get;set;}
    public String SelectedGroup{get;set;}
    
    public List<Profile> ProfileList {get; set;}
    public List<UserRole> RoleList {get; set;}
    public List<Group> GroupList {get; set;}
    List<user> user_NameList {get;set;}
    String[] tmp1 = New String[]{};
    String nameString;
    
    public List<String> picklistValues{get;set;}
    Public List<String> leftSelected {get;set;}
    Public List<String> rightSelected {get;set;}
    Set<String> leftValues = new Set<String>();
    Set<String> rightValues = new Set<String>();
    List<selectOption> AllProfiles = new List<selectOption>();
    List<selectOption> AllRoles = new List<selectOption>();
    List<selectOption> AllGroups = new List<selectOption>();
public UA_Unfreeze_Users_Controller(){
user_NameList = [Select ID, name FROM user where IsActive = TRUE AND ID IN (SELECT USERID from UserLogin where IsFrozen = True)];
String[] tmp1 = New String[]{};
String nameString;

for(user u : user_NameList){
   tmp1.add(u.name);  
}

nameString = string.join(tmp1,',');
System.debug('Value of the name string is:' + nameString);
List<String> picklistValues = nameString.split(',');
System.debug(picklistValues);
        leftSelected = new List<String>();
        rightSelected = new List<String>();
        leftValues.addAll(picklistValues);
    }
     
    public PageReference getSelect(){
        rightSelected.clear();
        for(String s : leftSelected){
            leftValues.remove(s);
            rightValues.add(s);
        }
        return null;
    }
     
    public PageReference getDeselect(){    
        leftSelected.clear();
        for(String s : rightSelected){
            rightValues.remove(s);
            leftValues.add(s);
        }
        return null;
    }
     
    public List<SelectOption> getDeselectedValues(){
        List<SelectOption> options = new List<SelectOption>();
        List<String> objList = new List<String>();
        objList.addAll(leftValues);
        objList.sort();
        for(String s : objList){
            options.add(new SelectOption(s,s));
        }
        return options;
    }
     
    public List<SelectOption> getSelectedValues(){
         
        List<SelectOption> options = new List<SelectOption>();
        List<String> objList = new List<String>();
        objList.addAll(rightvalues);
        objList.sort();
        for(String s : objList){
            options.add(new SelectOption(s,s));
        }
        return options;
    }
      
    //Unfreeze all active and frozen users ===================================================================
    Public void updateUserLoginToUnfreezeAllUsers()
    {
    system.debug('Value of right Selected is: ' + rightvalues); 
    AllUsersToUnfreeze = [SELECT Id, name from user where IsActive = True AND ID IN (SELECT USERID from UserLogin where IsFrozen = True) AND Name NOT IN : rightvalues];
    system.debug('Value of Users To Unfreeze is: ' + AllUsersToUnfreeze); 
    List<UserLogin> UserLoginList = new List<UserLogin>();  
if ((leftvalues.size() == 0)&& (rightvalues.size() > 0) && (AllUsersToUnfreeze.size() == 0 )) 
ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'No user found in the left box to unfreeze'));   
   else if (AllUsersToUnfreeze.size() == 0)
//((leftvalues.size() == 0)&& (rightvalues.size() == 0)&& (UserLoginList.size() == 0)) 
{
ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'There is no active and frozen user availble to unfreeze'));
}

else if ((AllUsersToUnfreeze.size() > 0) && ((rightvalues.size() > 0) ||(rightvalues.size() == 0)) ) {
    
for(UserLogin ul : [SELECT Id, IsFrozen, UserId From UserLogin Where UserId = :AllUsersToUnfreeze] ){
   ul.IsFrozen= false;
   UserLoginList.add(ul);         
}}

if((UserLoginList.size() >0)&& (rightvalues.size() > 0)) {
        System.debug('UserLogin List is ' + UserLoginList);
       update UserLoginList;
       ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,'All active users except the selected ones are unfrozen successfully'));
       
    }
else if ((UserLoginList.size() > 0) && (rightvalues.size() == 0)) {
update UserLoginList;
ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,'No user was selected to keep frozen. All active users are unfrozen successfully'));
}
}


    
    //Unfreeze system admin frozen users ===================================================================
  Public void updateUserLoginToUnfreezeSysAdmUsers(){
   SysAdmUsersToUnfreeze = [Select ID, name FROM user where IsActive = TRUE AND Profile.Name = 'System Administrator' AND ID IN (SELECT USERID from UserLogin where IsFrozen = True)];
    system.debug('Value of System Admin Users To Unfreeze is: ' + SysAdmUsersToUnfreeze); 
    List<UserLogin> UserLoginList = new List<UserLogin>();
    if (SysAdmUsersToUnfreeze.size() > 0) {
    
for(UserLogin ul : [SELECT Id, IsFrozen, UserId From UserLogin Where UserId = :SysAdmUsersToUnfreeze] ){
   ul.IsFrozen= false;
   UserLoginList.add(ul);         
}}

if(UserLoginList.size() >0) {
        System.debug('UserLogin List is ' + UserLoginList);
       update UserLoginList;
       ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,'All the system admin users have been unfrozen successfully'));
    }
else{
ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'All system admin users are already unfrozen'));
}
}

    
//Picklist for profiles  ====================================================================================
public List<selectOption> getProfileNames() {
AllProfiles.clear();
AllProfiles.add(new SelectOption('','-None-'));
for(Profile prf : [select Id,name from profile]) {
AllProfiles.add(new selectOption(prf.name,prf.name));
}
return AllProfiles;
}
    
    
    //Unfreeze profile specific frozen users ===================================================================
    Public void updateUserLoginToUnfreezeProfileSpecUsers(){
    
   ProfileList = [SELECT Id from Profile where name = :SelectedProfile];
   ProfileSpecUsersToUnfreeze = [Select ID, name FROM user where IsActive = TRUE AND Profile.Name = :SelectedProfile AND ID IN (SELECT USERID from UserLogin where IsFrozen = True)];
   if((SelectedProfile == '') || (SelectedProfile == null) || (ProfileList.size() == 0)){
       ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Warning,'Please select required profile from drop-down'));
    }
  /* if(ProfileList.size() == 0) {
       ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Warning,'Please check the profile name'));
    } */
  
    system.debug('Value of Profile Specific Users To Unfreeze is: ' + ProfileSpecUsersToUnfreeze); 
    List<UserLogin> UserLoginList = new List<UserLogin>();
    
    if ((SelectedProfile != '') && (ProfileList.size() > 0) &&(ProfileSpecUsersToUnfreeze.size() > 0)) {
    
for(UserLogin ul : [SELECT Id, IsFrozen, UserId From UserLogin Where UserId = :ProfileSpecUsersToUnfreeze] ){
   ul.IsFrozen= false;
   UserLoginList.add(ul);         
}}

if(UserLoginList.size() >0) {
        System.debug('UserLogin List is ' + UserLoginList);
update UserLoginList;
ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,'All the active users associated with selected profile have been unfrozen successfully'));

    }
else if ((UserLoginList.size() == 0) && (SelectedProfile != '') && (ProfileList.size() > 0)){
ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'All active users associated with selected profile are already unfrozen or the slected profile has no user associated with it'));
}
}
    
//Picklist for roles
public List<selectOption> getRoleNames() {
AllRoles.clear();
AllRoles.add(new SelectOption('','-None-'));
for(UserRole rol : [select Id,name from UserRole]) {
AllRoles.add(new selectOption(rol.name,rol.name));
}
return AllRoles;
}
    
        //Unfreeze role specific frozen users ===================================================================
    Public void updateUserLoginToUnfreezeRoleSpecUsers(){
    
   RoleList = [SELECT Id from UserRole where name = :SelectedRole];
    RoleSpecUsersToUnfreeze = [Select ID, name FROM user where IsActive = TRUE AND UserRole.Name = :SelectedRole AND ID IN (SELECT USERID from UserLogin where IsFrozen = True)];
   if((RoleList.size() == 0) || (SelectedRole == '') || (SelectedRole == null))  {
       ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Warning,'Please select required role name from drop-down'));
    }
  
    system.debug('Value of Role Specific Users To Unfreeze is: ' + RoleSpecUsersToUnfreeze); 
    List<UserLogin> UserLoginList = new List<UserLogin>();
    
    if ((RoleList.size() > 0) &&(RoleSpecUsersToUnfreeze.size() > 0)) {
    
for(UserLogin ul : [SELECT Id, IsFrozen, UserId From UserLogin Where UserId = :RoleSpecUsersToUnfreeze] ){
   ul.IsFrozen= false;
   UserLoginList.add(ul);         
}}

if(UserLoginList.size() >0) {
        System.debug('UserLogin List is ' + UserLoginList);
       update UserLoginList;
       ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,'All the active users associated with selected role have been unfrozen successfully'));
 
    }
else if((UserLoginList.size() == 0) && (SelectedRole != '') && (RoleList.size() > 0)) {
ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'All active users associated with the selected role are already unfrozen'));
}
}


//Picklist for group
public List<selectOption> getGroupNames() {
AllGroups.clear();
AllGroups.add(new SelectOption('','-None-'));
for(Group grp : [SELECT Id, name, type FROM Group where type ='regular' AND (NOT Name LIKE 'A%')]) {
AllGroups.add(new selectOption(grp.name,grp.name));
}
return AllGroups;
}


//Unfreeze group specific frozen users ===================================================================
    Public void updateUserLoginToUnfreezeGroupSpecUsers(){
    
   GroupList = [SELECT Id from Group where name = :SelectedGroup];
  if((GroupList.size() == 0) || (SelectedGroup == '') || (SelectedGroup == null)) {
       ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Warning,'Please check the group name'));
    }
   GroupSpecUsersToUnfreeze = [Select ID, name FROM user where IsActive = TRUE AND ID IN (SELECT USERID from UserLogin 
   where IsFrozen = True) AND ID IN (SELECT UserOrGroupId from GroupMember where group.name = :SelectedGroup)];
    system.debug('Value of Group Specific Users To Unfreeze is: ' + GroupSpecUsersToUnfreeze); 
    List<UserLogin> UserLoginList = new List<UserLogin>();
    
    if ((GroupList.size() > 0) &&(GroupSpecUsersToUnfreeze.size() > 0)) {
    
for(UserLogin ul : [SELECT Id, IsFrozen, UserId From UserLogin Where UserId = :GroupSpecUsersToUnfreeze] ){
   ul.IsFrozen= false;
   UserLoginList.add(ul);         
}}

if(UserLoginList.size() >0) {
        System.debug('UserLogin List is ' + UserLoginList);
       update UserLoginList;
       ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,'All the active users associated with the selected group have been unfrozen successfully'));
}
else if((UserLoginList.size() == 0) && (SelectedGroup != '') && (GroupList.size() > 0)){
ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'All active users associated with the selected group are already unfrozen'));
}
}
  
public pageReference cancel() {
PageReference pageRef = page.UA_Unfreeze_Users_VF;
pageRef.setRedirect(true);
return pageRef;     
    }     
    }