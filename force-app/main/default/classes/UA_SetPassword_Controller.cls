public class UA_SetPassword_Controller {
public List<user> AllActiveUsers {get;set;}
public List<user> AllInactiveUsers {get;set;}
public List<user> AllActiveUsersToSetPassword {get;set;}  
public List<user> AllInactiveUsersToActivate{get;set;} 
    
public String InputPassword {get;set;}
public String TrimmedPassword {get;set;}
//String[] tmp1 = New String[]{};
//String nameString;
    //Variables for active users
    public List<String> picklistValuesActiveUsers{get;set;}
    Public List<String> leftSelectedActiveUsers {get;set;}
    Public List<String> rightSelectedActiveUsers {get;set;}
    public Set<String> leftValuesActiveUsers = new Set<String>();
    public Set<String> rightValuesActiveUsers = new Set<String>();
    
    //Variables for inactive users
    public List<String> picklistValuesInactiveUsers{get;set;}
    Public List<String> leftSelectedInactiveUsers {get;set;}
    Public List<String> rightSelectedInactiveUsers {get;set;}
    public Set<String> leftValuesInactiveUsers = new Set<String>();
    public Set<String> rightValuesInactiveUsers = new Set<String>();
    //List<selectOption> AllProfiles = new List<selectOption>();
    //List<selectOption> AllRoles = new List<selectOption>();
    //List<selectOption> AllGroups = new List<selectOption>();
     
public UA_SetPassword_Controller(){  //start of constructor =================================

//For active users:
AllActiveUsers = [Select ID, name FROM user where IsActive = TRUE];
String[] tmpActiveUsers = New String[]{};
String nameStringActiveUsers;

for(user u : AllActiveUsers){
   tmpActiveUsers.add(u.name);  
}

nameStringActiveUsers = string.join(tmpActiveUsers,',');
System.debug('Value of the name string is:' + nameStringActiveUsers);
List<String> picklistValuesActiveUsers = nameStringActiveUsers.split(',');
System.debug(picklistValuesActiveUsers);
        leftSelectedActiveUsers = new List<String>();
        rightSelectedActiveUsers = new List<String>();
        leftValuesActiveUsers.addAll(picklistValuesActiveUsers);

//For inactive users:       
AllInactiveUsers = [Select ID, name FROM user where IsActive = FALSE];
String[] tmpInactiveUsers = New String[]{};
String nameStringInactiveUsers; 
for(user u : AllInactiveUsers){
   tmpInactiveUsers.add(u.name);  
}
nameStringInactiveUsers = string.join(tmpInactiveUsers,',');
System.debug('Value of the name string is:' + nameStringInactiveUsers);
List<String> picklistValuesInactiveUsers = nameStringInactiveUsers.split(',');
System.debug(picklistValuesInactiveUsers);
        leftSelectedInactiveUsers = new List<String>();
        rightSelectedInactiveUsers = new List<String>();
        leftValuesInactiveUsers.addAll(picklistValuesInactiveUsers);
        
    } //End of contructor ==================================

//Start of multi-select picklist for active users ===================================  
    public PageReference getSelectActiveUsers(){
        rightSelectedActiveUsers.clear();
        for(String s : leftSelectedActiveUsers){
            leftValuesActiveUsers.remove(s);
            rightValuesActiveUsers.add(s);
        }
        return null;
    }
     
    public PageReference getDeselectActiveUsers(){    
        leftSelectedActiveUsers.clear();
        for(String s : rightSelectedActiveUsers){
            rightValuesActiveUsers.remove(s);
            leftValuesActiveUsers.add(s);
        }
        return null;
    }
     
    public List<SelectOption> getDeselectedValuesActiveUsers(){
        List<SelectOption> optionsActiveUsers = new List<SelectOption>();
        List<String> objListActiveUsers = new List<String>();
        objListActiveUsers.addAll(leftValuesActiveUsers);
        objListActiveUsers.sort();
        for(String s : objListActiveUsers){
            optionsActiveUsers.add(new SelectOption(s,s));
        }
        return optionsActiveUsers;
    }
     
    public List<SelectOption> getSelectedValuesActiveUsers(){
         
        List<SelectOption> optionsActiveUsers = new List<SelectOption>();
        List<String> objListActiveUsers = new List<String>();
        objListActiveUsers.addAll(rightvaluesActiveUsers);
        objListActiveUsers.sort();
        for(String s : objListActiveUsers){
            optionsActiveUsers.add(new SelectOption(s,s));
        }
        return optionsActiveUsers;
    }
    // End of multi-select picklist for active users ===================================  
    
    //Start of multi-select picklist for inactive users ===================================  
      public PageReference getSelectInactiveUsers(){
        rightSelectedInactiveUsers.clear();
        for(String s : leftSelectedInactiveUsers){
            leftValuesInactiveUsers.remove(s);
            rightValuesInactiveUsers.add(s);
        }
        return null;
    }
     
    public PageReference getDeselectInactiveUsers(){    
        leftSelectedInactiveUsers.clear();
        for(String s : rightSelectedInactiveUsers){
            rightValuesInactiveUsers.remove(s);
            leftValuesInactiveUsers.add(s);
        }
        return null;
    }
     
    public List<SelectOption> getDeselectedValuesInactiveUsers(){
        List<SelectOption> optionsInactiveUsers = new List<SelectOption>();
        List<String> objListInactiveUsers = new List<String>();
        objListInactiveUsers.addAll(leftValuesInactiveUsers);
        objListInactiveUsers.sort();
        for(String s : objListInactiveUsers){
            optionsInactiveUsers.add(new SelectOption(s,s));
        }
        return optionsInactiveUsers;
    }
     
    public List<SelectOption> getSelectedValuesInactiveUsers(){
         
        List<SelectOption> optionsInactiveUsers = new List<SelectOption>();
        List<String> objListInactiveUsers = new List<String>();
        objListInactiveUsers.addAll(rightvaluesInactiveUsers);
        objListInactiveUsers.sort();
        for(String s : objListInactiveUsers){
            optionsInactiveUsers.add(new SelectOption(s,s));
        }
        return optionsInactiveUsers;
    }
    //End of multi-select picklist for inactive users ===================================  
      
 //Set password for active selected users ===================================================================
    Public void setPasswordForActiveSelectedUsers()
    {
    //system.debug('Value of right Selected is: ' + rightvalues); 
    if (rightValuesActiveUsers.size() >0){
    AllActiveUsersToSetPassword = [SELECT Id, name from user where IsActive = True AND Name = : rightValuesActiveUsers];
    }
    else if (rightValuesActiveUsers.size() == 0) {
    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'No user is selected to set password'));  
    }
    

if ((InputPassword == '') || (InputPassword == null)){
ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'Enter value for password to be set')); 
}
else if ((InputPassword != '') || (InputPassword != null)){
TrimmedPassword = InputPassword.trim(); 
}
if ((leftvaluesActiveUsers.size() == 0)&& (rightvaluesActiveUsers.size() == 0)) {
ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'No user found to set password'));  
} 
if ((rightvaluesActiveUsers.size() > 0) && ((leftvaluesActiveUsers.size() == 0) || (leftvaluesActiveUsers.size() > 0 ))){
if (AllActiveUsersToSetPassword.size() > 0) {
for (User u : AllActiveUsersToSetPassword )
{
try{
    System.setPassword(u.Id, TrimmedPassword);
    System.debug('DONE: ' + u.Id);
    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM, 'Password has been set succesfully'));
    }
catch(InvalidParameterValueException ipve){
    System.debug('Exception type caught: ' + ipve.getTypeName());    
    System.debug('Message: ' + ipve.getMessage());    
    System.debug('Cause: ' + ipve.getCause());    // returns null
    System.debug('Line number: ' + ipve.getLineNumber());    
    System.debug('Stack trace: ' + ipve.getStackTraceString());  
    string ErrorMsg = ipve.getMessage();
 ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,ErrorMsg));}
 catch(Exception e){
    System.debug('Exception type caught: ' + e.getTypeName());    
    System.debug('Message: ' + e.getMessage());    
    System.debug('Cause: ' + e.getCause());    // returns null
    System.debug('Line number: ' + e.getLineNumber());    
    System.debug('Stack trace: ' + e.getStackTraceString());  
    string ErrorMsg = e.getMessage();
 ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,ErrorMsg));}

}
}
}
}

    
//Activate inactive selected users ===================================================================
Public void activateInactiveSelectedUsers(){
AllInactiveUsersToActivate = [SELECT Id, name from user where IsActive = False AND Name IN : rightValuesInactiveUsers];

if ((leftvaluesInactiveUsers.size() == 0)&& (rightvaluesInactiveUsers.size() == 0)) 
ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'No user found to activate'));   


/*if ((leftvaluesInactiveUsers.size() > 0) && (rightvaluesInactiveUsers.size() == 0))
ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'No user is selected to activate')); */

List<User> UsersToActivateList = new List<User>();
if (((leftvaluesInactiveUsers.size() == 0) && (rightvaluesInactiveUsers.size() > 0)) || ((leftvaluesInactiveUsers.size() > 0) && (rightvaluesInactiveUsers.size() > 0))) {
//if ((AllInactiveUsersToActivate.size() > 0) && (rightvaluesInactiveUsers.size() > 0)){
for(User usr : AllInactiveUsersToActivate ){
   usr.IsActive = TRUE;
   UsersToActivateList.add(usr);         
}
}

if(UsersToActivateList.size() >0) {
        System.debug('UsersToActivate List is ' + UsersToActivateList);
       update UsersToActivateList;
       ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,'Selected users are activated succesfully'));
    }
else{
ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'No user selected to activate'));
}
}

public pageReference cancel() {
PageReference pageRef = page.UA_SetPassword_VF;

pageRef.setRedirect(true);
return pageRef;     
    } 
    }