public with sharing class imgUpload {
 
 public Attachment file { get; set; }
 public boolean isError{get;set;}
 public boolean isPageLoad{get;set;}
 public String strParentId{get;set;}
 
 public imgUpload(){
     strParentId=ApexPages.currentPage().getParameters().get('id');
    
     file = new Attachment();
     file.parentId=strParentId;
     isPageLoad=true;
      //    strContentId='';
}
 
  public PageReference upload() {
       try{
      
        insert file;
        file = new Attachment();
        file.parentId=strParentId;
     
          isError=false;
         isPageLoad=false;
        //return new PageReference('/' + file.id);*/
         Apexpages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO,'File Uploaded Successfully!'));
       }catch(Exception ex){
          isError=true;
          isPageLoad=false;
            file = new Attachment();
           Apexpages.addMessage(new ApexPages.Message(ApexPages.Severity.error,ex.getMessage()));
       }
        return null;
    }
  
 
 
}