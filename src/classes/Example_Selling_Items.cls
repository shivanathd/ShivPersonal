public with sharing class Example_Selling_Items {

public CnP_IaaS.PaaS_Class cnpxmlstring{get;set;}
public CnP_IaaS.PaaS_Class.Operation Operation{get;set;}
public CnP_IaaS.PaaS_Class.Order Order{get;set;}
public CnP_IaaS.PaaS_Class.Authentication Authentication{get;set;}
public CnP_IaaS.PaaS_Class.BillingInformation BillingInfo{get;set;}
public CnP_IaaS.PaaS_Class.BillingAddress BillingAddress{get;set;}
public list<CnP_IaaS.PaaS_Class.Items> items{get;set;}
public CnP_IaaS.PaaS_Class.PaymentMethod PaymentMethod{get;set;}
public CnP_IaaS.PaaS_Class.Receipt Receipt{get;set;}
public CnP_IaaS.PaaS_Class.cnpTransaction cnpTransaction{get;set;}
public boolean error{set;get;}

public Example_Selling_Items(){
list<CnPAccountSetting__c> SettingsList=[select C_P_AccountGUID__c,C_P_Account_Number__c,WID__c from CnPAccountSetting__c limit 1];
if(SettingsList.isempty())
  {
  error=true;
  ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.warning,'Please enter C&P Account details at C&P Account Information Tab and process');    
      ApexPages.addMessage(myMsg);
}

items = new list<CnP_IaaS.PaaS_Class.Items>();
CnP_IaaS.PaaS_Class.Items TempItem=new CnP_IaaS.PaaS_Class.Items();
TempItem.ItemName='T-Shirt';
TempItem.UnitPrice=15.0;
Items.add(TempItem);


CnP_IaaS.PaaS_Class.Items TempItem1=new CnP_IaaS.PaaS_Class.Items();
TempItem1.ItemName='Last Album DVD';
TempItem1.UnitPrice=25;
Items.add(TempItem1);

CnP_IaaS.PaaS_Class.Items TempItem2=new CnP_IaaS.PaaS_Class.Items();
TempItem2.ItemName='Coffee Cup';
TempItem2.UnitPrice=10;
Items.add(TempItem2);

CnP_IaaS.PaaS_Class.Items TempItem3=new CnP_IaaS.PaaS_Class.Items();
TempItem3.ItemName='Bumper Sticker';
TempItem3.UnitPrice=2;
Items.add(TempItem3);

CnP_IaaS.PaaS_Class.Items TempItem4=new CnP_IaaS.PaaS_Class.Items();
TempItem4.ItemName='Water Bottle';
TempItem4.UnitPrice=8;
Items.add(TempItem4);

CnP_IaaS.PaaS_Class.Items TempItem5=new CnP_IaaS.PaaS_Class.Items();
TempItem5.ItemID=123;
TempItem5.UnitPrice=10.0;
Items.add(TempItem5);


cnpxmlstring=new CnP_IaaS.PaaS_Class();
Operation=new CnP_IaaS.PaaS_Class.Operation();
Order=new CnP_IaaS.PaaS_Class.Order();
Authentication=new CnP_IaaS.PaaS_Class.Authentication();
BillingInfo=new CnP_IaaS.PaaS_Class.BillingInformation();
BillingAddress=new CnP_IaaS.PaaS_Class.BillingAddress();


PaymentMethod=new CnP_IaaS.PaaS_Class.PaymentMethod();
Receipt=new CnP_IaaS.PaaS_Class.Receipt();

cnpTransaction=new CnP_IaaS.PaaS_Class.cnpTransaction();
string dd=datetime.now().format('MM/dd/yyyy');
string mon=dd.substring(0,2);
string year=dd.substring(7,10);
PaymentMethod.ExpirationMonth=mon;
PaymentMethod.ExpirationYear=year;
}

public list<SelectOption> getAmounts(){

List<SelectOption> Options = new List<SelectOption>();
                    Options.add(new SelectOption('10.0','$10'));
                    Options.add(new SelectOption('20.0','$20'));
                    Options.add(new SelectOption('30.0','$30'));
                    Options.add(new SelectOption('50.0','$50'));
                    Options.add(new SelectOption('0.0','Other'));
return Options;
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


cnpxmlstring.getOperation_node(Operation);
cnpxmlstring.getOrder_node(Order);
cnpxmlstring.getAuthentication_node(Authentication);
cnpxmlstring.getBillingInformation_node(BillingInfo);
cnpxmlstring.getBillingAddress_node(BillingAddress);
cnpxmlstring.getItemslist_node(items);
cnpxmlstring.getTransactionDetails_node(cnpTransaction);
cnpxmlstring.getPaymentMethod_node(PaymentMethod);
cnpxmlstring.getreceipt_node(Receipt);
cnpxmlstring.getgeneratexml(cnpxmlstring);

 if(cnpxmlstring.Verifyxmlfile==false){
  cnpxmlstring.Send_Transaction_api(cnpxmlstring.xmlfile);
  }
 
}
}