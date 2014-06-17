public with sharing class Example_Min_Fields {
public CnP_IaaS.PaaS_Class cnpxmlstring{get;set;}
public CnP_IaaS.PaaS_Class.Operation Operation{get;set;}
public CnP_IaaS.PaaS_Class.Order Order{get;set;}
public CnP_IaaS.PaaS_Class.Authentication Authentication{get;set;}
public CnP_IaaS.PaaS_Class.BillingInformation BillingInfo{get;set;}
public CnP_IaaS.PaaS_Class.BillingAddress BillingAddress{get;set;}
public CnP_IaaS.PaaS_Class.PaymentMethod PaymentMethod{get;set;}
public CnP_IaaS.PaaS_Class.Receipt Receipt{get;set;}
public CnP_IaaS.PaaS_Class.cnpTransaction transaction1{get;set;}
public boolean error{Set;get;}
public Example_Min_Fields(){
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

transaction1=new CnP_IaaS.PaaS_Class.cnpTransaction();

string dd=datetime.now().format('MM/dd/yyyy');
string mon=dd.substring(0,2);
string year=dd.substring(7,10);
PaymentMethod.ExpirationMonth=mon;
PaymentMethod.ExpirationYear=year;
}

public void Process(){
list<CnPAccountSetting__c> SettingsList=[select C_P_AccountGUID__c,C_P_Account_Number__c,WID__c from CnPAccountSetting__c limit 1];
Authentication.AccountGuid=SettingsList[0].C_P_AccountGUID__c;
Authentication.AccountID=SettingsList[0].C_P_Account_Number__c;

Order.OrderMode='Test';

for(CnP_IaaS.Paas_Class.Items i : cnpxmlstring.ItemsList){
i.ItemName='Donation';
}
cnpxmlstring.getOperation_node(Operation);
cnpxmlstring.getOrder_node(Order);
cnpxmlstring.getAuthentication_node(Authentication);
cnpxmlstring.getBillingInformation_node(BillingInfo);
cnpxmlstring.getBillingAddress_node(BillingAddress);
cnpxmlstring.getItemsString_node(cnpxmlstring);
cnpxmlstring.getTransactionDetails_node(transaction1);
cnpxmlstring.getPaymentMethod_node(PaymentMethod);
cnpxmlstring.getreceipt_node(Receipt);
cnpxmlstring.getgeneratexml(cnpxmlstring);

if(cnpxmlstring.Verifyxmlfile==false){
  cnpxmlstring.Send_Transaction_api(cnpxmlstring.xmlfile);
  }
 
}
}