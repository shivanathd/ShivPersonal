/**********************************************************************
Name:  CaseTeamMemberNotificationBatch()
Copyright © 2012  AAR Corp 
============================================================================================================
Purpose:                                                           
-------  
This Batch Class Gathers batches of cases to send emails to Case Team Members Created Recently.
The Reason, The batch class uses Cases, is a workaround for a possible corner case

-- Governor Limit - Only 10 SendEmail Method Invocations in a execution cycle

So if Batch Was in CaseTeamMember Batches, if Team members are added to more than 11 Cases in a hour
we would hit the limit.
This is avoided by Batching Cases in batches of 10 and sending out emails
                                                        
============================================================================================================
History                                                           
-------                                                           
VERSION  AUTHOR                                 DATE              DETAIL                      
   1.0 - Simplion(SD)						    11/12/2012        INITIAL DEVELOPMENT     

***********************************************************************/

global class CaseTeamMemberNotificationBatch implements Database.Batchable<sObject>{
     public string query;
     public CaseTeamMemberNotificationBatch(string q)
     {
     	query =q;
     }
	global Database.querylocator start(Database.BatchableContext BC){
            return Database.getQueryLocator(query);}
            
	global void execute(Database.BatchableContext BC, List<sObject> scope){
	    
	    //We Get Scope as Case --> now we take all case team members created in the last hour
	    List<Case> Cases = (List<Case>)scope;
	    set<id> CaseIDs= new set<id>();
	    DateTime SinceLastHour = System.now().addHours(-1);
	      
	    for(Case c:Cases)
   	    	CaseIDs.add(c.Id);
	  
     	List<CaseTeamMember> CTMs = [select id,MemberId,ParentID from CaseTeamMember where CreatedDate >=:SinceLastHour AND ParentId in:CaseIDs];
     
	    // Send Emails to the New Case Team Members
	    
	    Map<id,Case> CaseMap = new Map<id,Case>();
	    
	    CaseCommentEmailHelper helper = new CaseCommentEmailHelper();
        
	  
	      helper.InitializeCaseTeamValues(CaseIds,CTMs);
	      CaseMap = helper.CaseObjs;
	      for(id CaseID :CaseIds)
	        {
	          List<String> toAddresses = new List<String>();
	          toAddresses = helper.getCaseTeamToAddressList(CaseID);
	          SendCaseTeamEmail(toAddresses,'admin@aarcorp.com',CaseMap.get(caseID));	          
	        } 
	       
	}
	
	global void finish(Database.BatchableContext BC){
	
	}
	
//============= Private Methods===========
	private void SendCaseTeamEmail(List<String> toAddresses,string replyTo,Case CurrentCase)
	{
		
	    String CaseLink =System.URL.getSalesforceBaseUrl().toExternalForm().remove('-api' )+'/'+CurrentCase.Id;
	    string TXTEmailBody ='You have been added to the below Case Team:\n\n'
    						+'Case #'+CurrentCase.CaseNumber
    						+(String.isNotBlank(CurrentCase.Subject)?'\nSubject: '+CurrentCase.Subject:'')
	    					+(String.isNotBlank(CurrentCase.Description)?'\nDescription: '+CurrentCase.Description:'')
	    					+'\n\n Click on the link to access the case: '+CaseLink
	    					+'\n\n Thank You! \n AAR Corp';
	    					
	    string Subject ='You have been added to Case #'+CurrentCase.CaseNumber;
	    
	    // Send Email
	    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
	    mail.setToAddresses(toAddresses);
	    mail.setReplyTo(replyTo);
	    mail.setSubject(Subject);
	    mail.setUseSignature(false);
	    mail.setPlainTextBody(TXTEmailBody);
	    Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });   
	   
    }

	
	
}