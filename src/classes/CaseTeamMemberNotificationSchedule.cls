/**********************************************************************
Name:  CaseTeamMemberNotificationSchedule()
Copyright © 2012  AAR Corp 
============================================================================================================
Purpose:                                                           
-------  
Scheduler class to run hourly. to send out Email to Case Team Members created in the last hour                                                        
============================================================================================================
History                                                           
-------                                                           
VERSION  AUTHOR                                 DATE              DETAIL                      
   1.0 - Simplion(SD)						    11/12/2012        INITIAL DEVELOPMENT     

***********************************************************************/


global class CaseTeamMemberNotificationSchedule implements schedulable
{
    global void execute(SchedulableContext sc)
    {
     
     //The following Batch Class sends out Emails to Team Members added newly to the case,
     //and send email per case to all team members in that case.
     //i.e. If 11 cases have new members in the last hour will run into governor limits
     //This is a work around here, Since SendEmail can be invoked only 10 times in a Execution Cycle
     //Instead of batching the Case Team Member, We create batches of 10 for cases
     
     // Since Last one hour
     DateTime SinceLastHour = System.now().addHours(-1);
     List<CaseTeamMember> CTMs = [select id,MemberId,ParentID from CaseTeamMember where CreatedDate >=:SinceLastHour];
     string CaseIds = '(';
			  
	for(CaseTeamMember CTM: CTMs){
	   if(CaseIds.length() > 1) // If strReturnedIds is not empty, adds a comma as separator before adding new values.
	    CaseIds += ','; 
	    
	    CaseIds += '\'' + CTM.ParentId + '\'';
	  }
	  CaseIds += ')';
	  
	     string query='Select Id from Case where Id in'+CaseIds;
	     CaseTeamMemberNotificationBatch b = new CaseTeamMemberNotificationBatch(query); 
	     database.executebatch(b,10);
	    
    }
}