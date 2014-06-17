public with sharing class CnPAccountSettings {
public string AccountNumber {get;set;}
public string AccountGuid {get;set;}
public string WID {get;set;}
public CnPAccountSetting__c SettingRec {get;set;}
public CnPAccountSettings(){

list<CnPAccountSetting__c> SettingsList=[select C_P_AccountGUID__c,C_P_Account_Number__c,WID__c from CnPAccountSetting__c];
if(SettingsList.IsEmpty()){
SettingRec=new CnPAccountSetting__c();
}
if(SettingsList.size()==1){
SettingRec=SettingsList[0];
}
}

public void Save(){

list<CnPAccountSetting__c> SettingsList=[select C_P_AccountGUID__c,C_P_Account_Number__c,WID__c from CnPAccountSetting__c];
if(SettingsList.IsEmpty()){
insert SettingRec;
 ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.confirm,'The record is created successfully');    
      ApexPages.addMessage(myMsg);

}
if(SettingsList.size()==1){

update SettingRec;
  ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.confirm,'The record is updated successfully');    
      ApexPages.addMessage(myMsg);


}


}
}