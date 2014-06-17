public with sharing class Example_eCheck_SelectName {
public CnP_IaaS.PaaS_Class cnpxmlstring{get;set;}
public CnP_IaaS.PaaS_Class.Operation Operation{get;set;}
public CnP_IaaS.PaaS_Class.Order Order{get;set;}
public CnP_IaaS.PaaS_Class.Authentication Authentication{get;set;}
public CnP_IaaS.PaaS_Class.BillingInformation BillingInfo{get;set;}
public CnP_IaaS.PaaS_Class.BillingAddress BillingAddress{get;set;}
public CnP_IaaS.PaaS_Class.PaymentMethod PaymentMethod{get;set;}
public CnP_IaaS.PaaS_Class.Receipt Receipt{get;set;}
public CnP_IaaS.PaaS_Class.cnpTransaction cnptransaction{get;set;}
public boolean error{set;get;}

public Example_eCheck_SelectName(){
list<CnPAccountSetting__c> SettingsList=[select C_P_AccountGUID__c,C_P_Account_Number__c,WID__c from CnPAccountSetting__c limit 1];
if(SettingsList.isempty())
  {
  error=true;
  ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.warning,'Please enter C&P Account details at C&P Account Information Tab and process');    
      ApexPages.addMessage(myMsg);
}

cnpxmlstring=new CnP_IaaS.PaaS_Class();
Operation=new CnP_IaaS.PaaS_Class.Operation();
Order=new CnP_IaaS.PaaS_Class.Order();
Authentication=new CnP_IaaS.PaaS_Class.Authentication();
BillingInfo=new CnP_IaaS.PaaS_Class.BillingInformation();
BillingAddress=new CnP_IaaS.PaaS_Class.BillingAddress();
PaymentMethod=new CnP_IaaS.PaaS_Class.PaymentMethod();
Receipt=new CnP_IaaS.PaaS_Class.Receipt();

cnptransaction=new CnP_IaaS.PaaS_Class.cnpTransaction();
}

public list<selectoption> getFundNames(){
List<SelectOption> Options = new List<SelectOption>();
                    Options.add(new SelectOption('General Fund','General Fund'));
                    Options.add(new SelectOption('Alumni Fund','Alumni Fund'));
                    Options.add(new SelectOption('Student Housing','Student Housing'));
                    Options.add(new SelectOption('Scholarship','Scholarship'));
                    return Options;
}

public void Process(){
list<CnPAccountSetting__c> SettingsList=[select C_P_AccountGUID__c,C_P_Account_Number__c,WID__c from CnPAccountSetting__c limit 1];
Authentication.AccountGuid=SettingsList[0].C_P_AccountGUID__c;
Authentication.AccountID=SettingsList[0].C_P_Account_Number__c;


Order.OrderMode='Test';


PaymentMethod.PaymentType='Check';
PaymentMethod.IdType='Driver';

cnpxmlstring.getOperation_node(Operation);
cnpxmlstring.getOrder_node(Order);
cnpxmlstring.getAuthentication_node(Authentication);
cnpxmlstring.getBillingInformation_node(BillingInfo);
cnpxmlstring.getBillingAddress_node(BillingAddress);
cnpxmlstring.getItemsString_node(cnpxmlstring);
cnpxmlstring.getTransactionDetails_node(cnptransaction);
cnpxmlstring.getPaymentMethod_node(PaymentMethod);
cnpxmlstring.getreceipt_node(Receipt);
cnpxmlstring.getgeneratexml(cnpxmlstring);

if(cnpxmlstring.Verifyxmlfile==false){
  cnpxmlstring.Send_Transaction_api(cnpxmlstring.xmlfile);
  }
   
}

}