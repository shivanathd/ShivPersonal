global with sharing class imageGalleryController {
public String strParentId{get;set;}
public String strAttachmentId{get;set;}

 public List<Attachment> lstAtt{get;set;}
 
 public imageGalleryController(){
    //strParentId='001d000000CMpe1';
    if(strParentId==null || strParentId==''){
        strParentId=ApexPages.currentPage().getParameters().get('id');
    }
    lstAtt=getAttachmentDetail();
    
 }

 public List<Attachment> getAttachmentDetail(){
    return [Select id,parentId,description,name from Attachment where parentId=:strParentId ];
 }

public pagereference deleteFile(){
 delete[select id from Attachment  where id=:strAttachmentId];
    lstAtt=getAttachmentDetail();
    
    return null;
}
 @RemoteAction
 global static String deleteFile(String strAttachmentId){
    delete[select id from Attachment  where id=:strAttachmentId];
    
    return null;
 }

}