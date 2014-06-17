/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an organization are executed whenever Apex code is deployed
 * to a production organization to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production organization. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the organization size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
private class CaseTeamMemberNotificationBatchTest {

		static testMethod void testBatchClass()	{
			 
			 Case newCase = new Case();
			   newCase.Status='New';
			   newCase.Origin='Phone';
			   newCase.Subject='Test';
			   newCase.Description='Test Description';
			   insert newCase;
			   
			List<CaseTeamMember> CTMs = new List<CaseTeamMember>();
			CTMs=CaseCommentHelperTest.getMixedCaseTeam(newCase);
			insert CTMs;
			
			System.Assert(CTMs.size()>0);
		
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