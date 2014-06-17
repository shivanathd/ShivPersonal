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
@isTest(SeeAllData= true)
public class CaseCommentHelperTest {
    
    static testMethod void CaseCommentValid() {
    	 
       Case newCase = new Case();
       newCase.Status='New';
       newCase.Origin='Phone';
       newCase.Subject='Test';
       newCase.Description='Test Description';
       insert newCase;
       
       System.assert(newCase!=null);
       
       
       List<CaseTeamMember> CTMs = new List<CaseTeamMember>();
       CTMs=getMixedCaseTeam(newCase);
       insert CTMs;
       
       Insert CaseCommentHelperTest.CreateNewCaseCommentList(5,newCase.Id);
       
       
    }
    
    //======== Utility Methods============
   public static List<CaseComment> CreateNewCaseCommentList(integer MaxRecord,Id CaseID)
   {
   	List<CaseComment> newCaseCommentList = new List<CaseComment>();
	   	for(integer i=0;i<MaxRecord;i++)
	   	{
	   	   CaseComment cc= new CaseComment();
	       cc.CommentBody='Hello '+i;
	       cc.ParentId =CaseID;
	       cc.IsPublished=true;
	       newCaseCommentList.add(cc);
	   	}
   	return newCaseCommentList; 
   }
   
   public static List<Contact> CreateNewContactList(integer MaxRecord)
   {
   	 List<Contact> NewContactList = new List<Contact>();
	   	for(integer i=0;i<MaxRecord;i++)
	   	{
	   	 	Contact c = new Contact();
	   	 	c.LastName='NewContact'+i;
	   	 	c.Email='test'+i+'@simplion.com';
	   	 	NewContactList.add(c);
	   	}
	   	return NewContactList;   
   }
   public static List<CaseTeamMember> getMixedCaseTeam(Case newCase)
   {
   	 //Create a Case Team role
       CaseTeamRole CTR = new CaseTeamRole();
       CTR.AccessLevel='Edit';
       CTR.Name='Test Case Team Role';
       CTR.PreferencesVisibleInCSP=true;
     
      // To avoid the Mixed DML operation Error we start a new Context
     
          System.runAs(new User(Id = Userinfo.getUserId())) {
          insert CTR;
          }
      
       System.assert(CTR!=null);
       
      
       List<contact> newContacts = new List<contact>();
       integer RecordsToBeCreated = 3;
       newContacts=CaseCommentHelperTest.CreateNewContactList(RecordsToBeCreated);
       insert newContacts;
       
       System.assert(newContacts.size()==RecordsToBeCreated);
   	 
       UserLicense UL = [Select u.id From UserLicense  u where u.name='Salesforce' Limit 1];
       List<profile> profiles= [Select id from profile where UserLicenseID = :UL.id];
       
       // Select The Active Users with this profile
       List<User> ActiveUsers = [select id from User where ProfileId in:profiles and IsActive =true Limit 3];
       
       List<CaseTeamMember> CTMs = new List<CaseTeamMember>();
       //Add a User to Case Team
       for(User u : ActiveUsers)
       {
       	CaseTeamMember CTM = new CaseTeamMember();
       	CTM.MemberId=u.id;
       	CTM.ParentId=newCase.id;
       	CTM.TeamRoleId = CTR.Id;
       	CTMs.add(CTM);
       }
       //Add Contacts to Case Team
       for(Contact c : newContacts)
       {
       	CaseTeamMember CTM = new CaseTeamMember();
       	CTM.MemberId=c.id;
       	CTM.ParentId=newCase.id;
       	CTM.TeamRoleId = CTR.Id;
       	CTMs.add(CTM);        
       }
       return CTMs;
   }
}