public with sharing class UA_Add_Group_to_Group_Controller{
Public String SelectedGroupToBeAdded{get;set;} 
Public String SelectedTargetGroup{get;set;} 
public List<Group> GrpId_Target{get; set;}
public List<Group> GroupToBeAdded{get; set;}
public List<GroupMember> CheckGroupMemberForGroupToBeadded{get; set;} //check existence of group member record for the group to be added.
List<selectOption> AllGroupsToAdd = new List<selectOption>();
List<selectOption> AllTargetGroups = new List<selectOption>();
Public UA_Add_Group_to_Group_Controller(){   } 
//To display groups to be addded in picklist
public List<selectOption> getGroupToAdd() {
AllGroupsToAdd.clear();
AllGroupsToAdd.add(new SelectOption('','-None-'));
for(Group grpa : [SELECT Id, name, type FROM Group where type ='regular']) {
AllGroupsToAdd.add(new selectOption(grpa.name,grpa.name));
}
return AllGroupsToAdd;
}

//To display target groups in pick list
public List<selectOption> getTargetGroup() {
AllTargetGroups.clear();
AllTargetGroups.add(new SelectOption('','-None-'));
for(Group grpt : [SELECT Id, name, type FROM Group where type ='regular' AND (NOT Name LIKE 'A%')]) {
AllTargetGroups.add(new selectOption(grpt.name,grpt.name));
}
return AllTargetGroups;
}

Public void createUpdateGroupMember(){
List<GroupMember> GMList = new List<GroupMember>();
/*GroupToBeAdded = [SELECT ID, name from Group where Name = : SelectedGroupToBeAdded AND ID NOT IN (SELECT UserOrGroupId FROM GroupMember where Group.name = : SelectedGroupToBeAdded)]; */
GroupToBeAdded = [SELECT ID, name from Group where Name = : SelectedGroupToBeAdded];
CheckGroupMemberForGroupToBeadded = [Select Id, Group.Name, GroupId, UserorGroupId From GroupMember  WHERE group.name = :SelectedTargetGroup AND UserorGroupId IN (SELECT ID from Group Where Name = : SelectedGroupToBeAdded)];

//GroupToBeAdded = [SELECT ID from Group where  ID NOT IN (SELECT UserOrGroupId FROM GroupMember)];
GrpId_Target = [SELECT Id FROM Group where name = :SelectedTargetGroup];
if((SelectedGroupToBeAdded == '') || (SelectedGroupToBeAdded == null) || (GroupToBeAdded.size() == 0) )
ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'Please check group name which you want to add'));
if((SelectedTargetGroup == '')|| (SelectedTargetGroup == null) || (GrpId_Target.size() == 0))
ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please check target group name to which you want to add'));
if ( (GroupToBeAdded.size()> 0) && (GrpId_Target.size() > 0) && (CheckGroupMemberForGroupToBeadded.size() == 0) && (SelectedGroupToBeAdded != SelectedTargetGroup)){  
//for loop should execute in case groups to be added and the target group--both exist   
    for(Group G : GroupToBeAdded) {
            GroupMember GM = new GroupMember();
            GM.GroupId = GrpId_Target[0].Id;
            GM.UserOrGroupId = G.Id;
            GMList.add(GM);         
        }
    

       System.debug('Group Member List is ' + GMList);
       //insert GMList;
       //ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,'Group is successfully added to target group'));
       try{
insert GMList;
ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,'Group is successfully added to target group'));     
}
 catch(Exception e){
    System.debug('Exception type caught: ' + e.getTypeName());    
    System.debug('Message: ' + e.getMessage());    
    System.debug('Cause: ' + e.getCause());    // returns null
    System.debug('Line number: ' + e.getLineNumber());    
    System.debug('Stack trace: ' + e.getStackTraceString());  
    string ErrorMsg = e.getMessage();
 ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,ErrorMsg));
}
    }
else if ( (CheckGroupMemberForGroupToBeadded.size() > 0) && (GrpId_Target.size() > 0) )
 ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'Group is already added to target group'));
 //else if ((SelectedGroupToBeAdded == SelectedTargetGroup))
  else if ((SelectedGroupToBeAdded != null) && (SelectedTargetGroup != null)&& (SelectedGroupToBeAdded == SelectedTargetGroup))
 ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'A group cannot be added in the same group'));
}


//For cancel button
public pageReference cancel() {
PageReference pageRef = page.UA_Add_Group_To_Group_VF;
pageRef.setRedirect(true);
return pageRef;     
    } 
//Verify group addition 
Public void verifyGroupAddition(){
GroupToBeAdded = [SELECT ID, name from Group where Name = : SelectedGroupToBeAdded];
CheckGroupMemberForGroupToBeadded = [Select Id, Group.Name, GroupId, UserorGroupId From GroupMember  WHERE group.name = :SelectedTargetGroup AND UserorGroupId IN (SELECT ID from Group Where Name = : SelectedGroupToBeAdded)];

//GroupToBeAdded = [SELECT ID from Group where  ID NOT IN (SELECT UserOrGroupId FROM GroupMember)];
GrpId_Target = [SELECT Id FROM Group where name = :SelectedTargetGroup];
if((SelectedGroupToBeAdded == '') || (SelectedGroupToBeAdded == null) || (GroupToBeAdded.size() == 0) )
ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'Please check group name which you want to add'));
if((SelectedTargetGroup == '')|| (SelectedTargetGroup == null) || (GrpId_Target.size() == 0))
ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please check target group name to which you want to add'));
if ( (GroupToBeAdded.size()> 0) && (GrpId_Target.size() > 0) && (CheckGroupMemberForGroupToBeadded.size() == 0) ){  
ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'Please click on Add Group To Target Group button to add the group to target group'));
    }
else if ( (CheckGroupMemberForGroupToBeadded.size() > 0) && (GrpId_Target.size() > 0) )
 ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'Group is already added to target group. No further action is required to add the group.'));
}
}