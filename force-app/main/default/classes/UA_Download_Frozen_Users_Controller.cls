public class UA_Download_Frozen_Users_Controller 
{
    public List<User> users{get;set;}
    public string renderAsdoc{get;set;}
    public boolean pb1{get;set;}
    public string renderAsExcel{get;set;}
 
    public UA_Download_Frozen_Users_Controller()
    {
        users=[Select ID, Name, Username FROM user where IsActive = TRUE AND ID IN (SELECT USERID from UserLogin where IsFrozen = True)];
        pb1=true;
    }
    
    //pdf generate
    public PageReference SaveAspdf() {
        pb1=false;
        renderAsdoc='pdf';
        //setup a default file name
        string fileName = 'Frozen Users List'+date.today()+'.pdf';
        Apexpages.currentPage().getHeaders().put('content-disposition', 'attachemnt; filename='+fileName);
        return null;
    }

    //Save as Excel
    public PageReference SaveAsExcel() {
        pb1=false;
        renderAsExcel='application/vnd.ms-excel#Frozen Users List.xls';
        return null;
    }
    
    // Save as word 
    public PageReference SaveAsWord() {
         pb1=false;
        renderAsExcel='application/vnd.ms-word#Frozen Users List.doc';
        return null;
    }

}