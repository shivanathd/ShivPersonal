/**********************************************************************
Name:  CommentEmail()
Copyright © 2012  AAR Corp 
============================================================================================================
Purpose:                                                           
-------  
This Trigger is when ever CaseComment is created or modified a CaseComment Email is sent to the case team
                                                        
============================================================================================================
History                                                           
-------                                                           
VERSION  AUTHOR                                 DATE              DETAIL                      
   1.0 - Simplion(SD)						    11/12/2012        INITIAL DEVELOPMENT     

***********************************************************************/

trigger CommentEmail on CaseComment (after insert,after update) {
   CaseCommentEmailHelper Obj = new CaseCommentEmailHelper();
   Obj.SendCaseCommentEmail(Trigger.new);
   }