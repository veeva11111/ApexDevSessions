@isTest
public class UA_TestDataFactory {

        public static List<Group> createGroups(Integer numGrps) {
        List<Group> grps = new List<Group>();
        
        for(Integer i=0;i<numGrps;i++) {
            Group g = new Group(Name='Test Group' + i, DeveloperName= 'TestGroup'+i);
            grps.add(g);
        }
        insert grps;
        return grps;
        }
      //====================================================
    
   public static List<User> createUsers(String profileName, Integer numUsers){
    UserRole userRole = new UserRole(DeveloperName = 'TestingTeam', Name = 'Testing Team');
    insert userRole;
    
      List<User> usersToCreate =  new List<User>();
       for(Integer i=0; i<numUsers; i++){
      User u = new User();
      u.ProfileId = [SELECT Id FROM Profile WHERE Name = :profileName].Id;
      u.LastName = 'last';
      u.Email = 'uatest@uatest.com';
      u.Username = 'uatest@uatest' + i +'.com';
      u.CompanyName = 'Testing Co';
      u.Title = 'Captian';
      u.Alias = 'alias'+i;
      u.TimeZoneSidKey = 'America/Los_Angeles';
      u.EmailEncodingKey = 'UTF-8';
      u.LanguageLocaleKey = 'en_US';
      u.LocaleSidKey = 'en_US';
      u.UserRoleId = userRole.Id;
           usersToCreate.add(u);
           }
    
    insert usersToCreate;
    return usersToCreate;
  }
    
    //=====================================================
     public static List<User> createInactiveUsers(String profileName, Integer numUsers){
    UserRole userRole = new UserRole(DeveloperName = 'TestingTeam', Name = 'Testing Team');
    insert userRole;
    
      List<User> inactiveUsersToCreate =  new List<User>();
       for(Integer i=0; i<numUsers; i++){
      User u = new User();
      u.ProfileId = [SELECT Id FROM Profile WHERE Name = :profileName].Id;
      u.LastName = 'last';
      u.IsActive = false;
      u.Email = 'uatest@uatest.com';
      u.Username = 'uatest@uatest_inactive' + i +'.com';
      u.CompanyName = 'Testing Co';
      u.Title = 'Captian';
      u.Alias = 'inact'+i;
      u.TimeZoneSidKey = 'America/Los_Angeles';
      u.EmailEncodingKey = 'UTF-8';
      u.LanguageLocaleKey = 'en_US';
      u.LocaleSidKey = 'en_US';
      u.UserRoleId = userRole.Id;
           inactiveUsersToCreate.add(u);
           }
    
    insert inactiveUsersToCreate;
    return inactiveUsersToCreate;
  }
  }