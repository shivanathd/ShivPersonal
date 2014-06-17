/**********************************************************************
Name:  CaseCommentEmailHelper()
Copyright © 2012  AAR Corp 
============================================================================================================
Purpose:                                                           
-------  
This Class helps to send the email out to all the case team members when ever a Case Comment is created/Edited
Trigger Associated: CommentEmail
Scenario: 
1)Case has contacts and/or Users as Case Team Members
2)Send Email only if Case Comment is Public
                                                        
============================================================================================================
History                                                           
-------                                                           
VERSION  AUTHOR                                 DATE              DETAIL                      
   1.0 - Simplion(SD)						    11/12/2012        INITIAL DEVELOPMENT     

***********************************************************************/

public class CaseCommentEmailHelper {
	
	public Map<id,List<id>> CaseToUserCaseTeamMembersMap;
    public Map<id,List<id>> CaseToContactCaseTeamMembersMap;
    public Map<id,Case> CaseObjs;
    public Map<id,User> UserObjs;
	public Map<id,Contact> ContactObjs;
	public set<id> ContactMembers;
    public Set<id> UserMembers;
	
	public CaseCommentEmailHelper()
	{
	  CaseToUserCaseTeamMembersMap = new Map<id,List<id>>();
      CaseToContactCaseTeamMembersMap = new Map<id,List<id>>();
      CaseObjs = new Map<id,Case>();
      UserObjs = new Map<id,User>();
	  ContactObjs = new Map<id,Contact>();
	  ContactMembers = new Set<id>();
	  UserMembers = new set<id>();
	}
    
    public void SendCaseCommentEmail(List<CaseComment> newTrigger)
    {
    	system.debug('Entered Case Comment');
        Set<id> parentCaseIds = new Set<id>();
        Set<id> CommentedUsers = new Set<id>(); // To set the reply-to Address
        
       
        List<CaseComment> isValidComment = new List<CaseComment>();
        
        for(CaseComment CC :newTrigger)
        {
         if(CC.IsPublished==true)//Only if comment is public, send out emails 
         {
          isValidComment.add(CC);
          parentCaseIds.add(CC.ParentId);
          CommentedUsers.add(CC.LastModifiedById);
         }
        }
        
        if(isValidComment.size()>0)
        {
           UserMembers.addall(CommentedUsers);
           List<CaseTeamMember> CTMembers =[SELECT Id,MemberId,ParentId FROM CaseTeamMember WHERE ParentId in:parentCaseIds];
	       InitializeCaseTeamValues(parentCaseIds,CTMembers);
	         
	         for(CaseComment CC :newTrigger)
		        {
		          List<String> toAddresses = new List<String>();
		          toAddresses = getCaseTeamToAddressList(CC.ParentId);
		          
		          if(toAddresses.size()>0)	
		          SendCommentEmail(toAddresses,UserObjs.get(CC.LastModifiedById).Email,CaseObjs.get(CC.parentId),CC.CommentBody);
		        }   
        }   
      
    }
    
    
    //============== Reuseable Methods=======================\
    
    public List<string> getCaseTeamToAddressList (id CaseID)
    {
    	 List<String> toAddresses = new List<String>();
    
        // Add Users in case Team to email list    
        if((!CaseToUserCaseTeamMembersMap.isEmpty())&&CaseToUserCaseTeamMembersMap.get(CaseID).size()>0)
      	toAddresses.addall(getUserEmailList(UserObjs,CaseToUserCaseTeamMembersMap.get(CaseID)));
      	//Add Contacts in Case Team to Email List
      	if((!CaseToContactCaseTeamMembersMap.isEmpty())&&CaseToContactCaseTeamMembersMap.get(CaseID).size()>0)
      	toAddresses.addall(getContactEmailList(ContactObjs,CaseToContactCaseTeamMembersMap.get(CaseID)));
      	
      	return toAddresses;
    }
    
    Public void InitializeCaseTeamValues(Set<id> parentCaseIds,List<CaseTeamMember>CTMembers)
    {
      		CaseObjs = new Map<id,Case>([select Id,Description,Owner.Email,CaseNumber,Subject from Case where id in:parentCaseIds]);// Query all case related Data
	        CaseToUserCaseTeamMembersMap = new Map<id,List<id>>();// Query Case Team Members
	        CaseToContactCaseTeamMembersMap = new Map<id,List<id>>();
	        
	        /* We Maintain 2 maps, Case => User Case Members and Case => Contact Case Members Map to reduce further loops ahead*/
	         
	        for(CaseTeamMember CTMember: CTMembers)
	        {
	        
	        	if(!isContactID(CTMember.MemberID))
	        	{
		         if(CaseToUserCaseTeamMembersMap.get(CTMember.ParentID)!=null)
		          CaseToUserCaseTeamMembersMap.get(CTMember.ParentID).add(CTMember.MemberID); //Add to the list of User Members
		         else
		          CaseToUserCaseTeamMembersMap.put(CTMember.ParentID,new id[]{CTMember.MemberID}); //Create a new List for the case and add the memeber to it
		          
		          UserMembers.add(CTMember.MemberID);
	        	}
	        	else if(isContactID(CTMember.MemberID))
	        	{
	        	 if(CaseToContactCaseTeamMembersMap.get(CTMember.ParentID)!=null)
		          CaseToContactCaseTeamMembersMap.get(CTMember.ParentID).add(CTMember.MemberID); //Add to the list of Contact Members
		         else
		          CaseToContactCaseTeamMembersMap.put(CTMember.ParentID,new id[]{CTMember.MemberID}); //Create a new List for the case and add the memeber to it
		          
		          ContactMembers.add(CTMember.MemberID);
	        	}
	        }
	        
	        /* Now we have the required Data to map and send emails out, 
	           There are 2 scenarios, The Case team can consist of Users and Contacts, 
	           We send out Emails to Contacts only if their Email is not Blank 
	        */
	           
	        if((UserMembers.size() > 0))
	         UserObjs = new Map<id,User>([select id,Email from User where ID in: UserMembers]);//Query all User Required Data 
	         
	        if(!CaseToContactCaseTeamMembersMap.isEmpty()) 
	    	ContactObjs = new Map<id,Contact>([select id,Email from Contact where ID in: ContactMembers AND Email!=NULL AND Email!='']);
    }
    
    //=============== Private Methods ===================
     private  List<String> getUserEmailList(Map<id,User> UserObjs,List<ID>UserIds)
       {
       	List<String> UserEmailList = new List<String>();
       	if(UserIds!=null && UserObjs!=null)
       	{
	       	for(Id userId :UserIDs)
		       	{
		       		if(UserObjs.get(userId)!=null)
		       		   UserEmailList.add(UserObjs.get(userId).Email);
		       	}
       	}
       	return UserEmailList;
       }
       
     private  List<String> getContactEmailList(Map<id,Contact> ContactObjs,List<ID>ContactIds)
       {
       	List<String> ContactEmailList = new List<String>();
       	if(ContactIds!=null && ContactObjs!=null)
       	{
	       	for(Id ContactId :ContactIds)
		       	{
		       		if(ContactObjs.get(ContactId)!=null)
		       		   ContactEmailList.add(ContactObjs.get(ContactId).Email);
		       	}
       	}
       	return ContactEmailList;
       }
       
       private void SendCommentEmail(List<String> toAddresses,string replyTo,Case CurrentCase,string CommentBody)
		{
			
		    String CaseLink =System.URL.getSalesforceBaseUrl().toExternalForm().remove('-api' )+'/'+CurrentCase.Id;
		    string TXTEmailBody =(String.isNotBlank(CurrentCase.Description)?'Description: '+CurrentCase.Description:'')
		    					+'\n\nCase Comment: '+CommentBody
		    					+'\n\n Case Link: '+CaseLink
		    					+'\n\n Thank You! \n AAR Corp';
		    					
		    string Subject ='Case #'+CurrentCase.CaseNumber+': '
		    				+ (String.isNotBlank(CurrentCase.Subject)?CurrentCase.Subject:'')
		    				+' has been updated.';
		    
		    // Send Email
		    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
		    mail.setToAddresses(toAddresses);
		    mail.setReplyTo(replyTo);
		    mail.setSubject(Subject);
		    mail.setUseSignature(false);
		    mail.setPlainTextBody(TXTEmailBody);
		    Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });   
		   
	    }
    
   private boolean isContactID(id IdInQuestion)
	{
		return (IdInQuestion.getSObjectType()== Contact.sObjectType);
	}
}