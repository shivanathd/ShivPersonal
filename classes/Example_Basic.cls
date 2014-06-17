public with sharing class Example_Basic {


public CnP_IaaS.Paas_Class cnpxmlstring{get;set;}
public CnP_IaaS.Paas_Class.Operation Operation{get;set;}
public CnP_IaaS.Paas_Class.Order Order{get;set;}
public CnP_IaaS.Paas_Class.Authentication Authentication{get;set;}
public CnP_IaaS.Paas_Class.BillingInformation BillingInfo{get;set;}
public CnP_IaaS.Paas_Class.PaymentMethod PaymentMethod{get;set;}
public CnP_IaaS.Paas_Class.Receipt Receipt{get;set;}
public CnP_IaaS.Paas_Class.cnpTransaction cnptransaction{get;set;}
public integer ResultCode {get;set;}
public boolean error{set;get;}
public Example_Basic(){
list<CnPAccountSetting__c> SettingsList=[select C_P_AccountGUID__c,C_P_Account_Number__c,WID__c from CnPAccountSetting__c limit 1];
if(SettingsList.isempty())
  {
  error=true;
  ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.warning,'Please enter C&P Account details at C&P Account Information Tab and process');    
      ApexPages.addMessage(myMsg);
}

cnpxmlstring=new CnP_IaaS.Paas_Class();
Operation=new CnP_IaaS.Paas_Class.Operation();
Order=new CnP_IaaS.Paas_Class.Order();
Authentication=new CnP_IaaS.Paas_Class.Authentication();
BillingInfo=new CnP_IaaS.Paas_Class.BillingInformation();
PaymentMethod=new CnP_IaaS.Paas_Class.PaymentMethod();
Receipt=new CnP_IaaS.Paas_Class.Receipt();

cnptransaction=new CnP_IaaS.Paas_Class.cnpTransaction();

string dd=datetime.now().format('MM/dd/yyyy');
string mon=dd.substring(0,2);
string year=dd.substring(7,10);
PaymentMethod.ExpirationMonth=mon;
PaymentMethod.ExpirationYear=year;

//PaymentMethod.ExpirationMonth=
}


public void process(){

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