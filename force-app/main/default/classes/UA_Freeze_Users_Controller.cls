public class UA_Freeze_Users_Controller { 
    public List<user> UsersToFreeze {get; set;}
    List<user> user_NameList {get;set;}
    String[] tmp1 = New String[]{};
    String nameString;
    public List<String> picklistValues{get;set;}
    Public List<String> leftSelected {get;set;}
    Public List<String> rightSelected {get;set;}
    Set<String> leftValues = new Set<String>();
    Set<String> rightValues = new Set<String>();
     
    public UA_Freeze_Users_Controller(){  //start of constructor
//user_NameList = [Select ID, name FROM user where IsActive = TRUE AND ID IN (SELECT USERID from UserLogin where IsFrozen = False)];
user_NameList = [Select ID, name FROM user where IsActive = TRUE AND ID IN (SELECT USERID from UserLogin where IsFrozen = False) AND id != :userinfo.getuserid()];

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
    } //end of constructor
     
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
    
    Public void updateUserLoginToFreezeUsers(){
    system.debug('Value of right Selected is: ' + rightvalues); 
    //UsersToFreeze = [SELECT Id, name from user where IsActive = True AND Name NOT IN : rightvalues];
    UsersToFreeze = [SELECT Id, name from user where IsActive = True AND Name NOT IN : rightvalues AND ID IN(SELECT UserId from UserLogin where IsFrozen = False) AND id != :userinfo.getuserid()];
    system.debug('Value of Users To Freeze is: ' + UsersToFreeze); 
    system.debug('Number of Users To Freeze is: ' + UsersToFreeze.size()); 
    List<UserLogin> UserLoginList = new List<UserLogin>();
    if ((UsersToFreeze.size() > 0) && (rightvalues.size() > 0)) {
    
for(UserLogin ul : [SELECT Id, IsFrozen, UserId From UserLogin Where UserId = :UsersToFreeze] ){
   ul.IsFrozen= true;
   UserLoginList.add(ul);         
}}

if((UserLoginList.size() >0)&& (rightvalues.size() > 0)) {
       System.debug('UserLogin List is ' + UserLoginList);
       update UserLoginList;
       ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,'All active users except the selected ones are frozen successfully'));
       
    }
//if ((UsersToFreeze.size() == 0) || (rightvalues.size() == 0)) {
if (rightvalues.size() == 0) {
ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'Select at least one user to exclude from freezing'));
}

if ((leftvalues.size() == 0)&& (UserLoginList.size() == 0)) {
ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'There is no active and unfrozen user availble to freeze'));
}
    
    }
    
public pageReference cancel() {
PageReference pageRef = page.UA_Freeze_Users_VF;
pageRef.setRedirect(true);
return pageRef;     
    } 
    }