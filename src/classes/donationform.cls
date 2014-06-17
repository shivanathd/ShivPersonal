public class donationform {
public CnP_IaaS.PaaS_Class cnpxmlstring{get;set;}
public CnP_IaaS.PaaS_Class.Operation Operation{get;set;}
public CnP_IaaS.PaaS_Class.Order Order{get;set;}
public CnP_IaaS.PaaS_Class.Authentication Authentication{get;set;}
public CnP_IaaS.PaaS_Class.BillingInformation BillingInfo{get;set;}
public CnP_IaaS.PaaS_Class.BillingAddress BillingAddress{get;set;}
public CnP_IaaS.PaaS_Class.PaymentMethod PaymentMethod{get;set;}
public CnP_IaaS.PaaS_Class.Receipt Receipt{get;set;}
public CnP_IaaS.PaaS_Class.cnpTransaction cnpTransaction{get;set;}
public list<CnP_IaaS.PaaS_Class.Items> Itemlist{get;set;}
public boolean error{set;get;}
public string id{get;set;}
public String questiontextval{get;set;}
public string dedicationresult{get;set;}
public string Acknowledgement{get;set;}

/************ Constructor Starts **************/
public donationform(){

list<CnPAccountSetting__c> SettingsList=[select C_P_AccountGUID__c,C_P_Account_Number__c,WID__c from CnPAccountSetting__c limit 1]; //Getting Values form C&P Settings Object
/****** Showing a warning message when C&P Account Information is empty ****/
if(SettingsList.isempty())
  {
   error = true;
  ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.warning,'Please enter C&P Account details at C&P Account Information Tab and process');    
      ApexPages.addMessage(myMsg);
}

//Initializing the related methods
cnpxmlstring=new CnP_IaaS.PaaS_Class();
Itemlist=new list<CnP_IaaS.PaaS_Class.Items>();
CnP_IaaS.PaaS_Class.Items It=new CnP_IaaS.PaaS_Class.Items();
It.UnitPrice=25.0;
Itemlist.add(It);
Operation=new CnP_IaaS.PaaS_Class.Operation();
Order=new CnP_IaaS.PaaS_Class.Order();
Authentication=new CnP_IaaS.PaaS_Class.Authentication();
BillingInfo=new CnP_IaaS.PaaS_Class.BillingInformation();
BillingAddress=new CnP_IaaS.PaaS_Class.BillingAddress();
PaymentMethod=new CnP_IaaS.PaaS_Class.PaymentMethod();
Receipt=new CnP_IaaS.PaaS_Class.Receipt();
cnpTransaction=new CnP_IaaS.PaaS_Class.cnpTransaction();
//changing the Format for date
string dd=datetime.now().format('MM/dd/yyyy');
string mon=dd.substring(0,2);
string year=dd.substring(7,10);
PaymentMethod.ExpirationMonth=mon;
PaymentMethod.ExpirationYear=year;
}
/************* Constructor ends ***********/


/******** Passing values dynmacillay into the Amount field ***********/
public list<SelectOption> getAmounts(){
List<SelectOption> Options = new List<SelectOption>();
                    Options.add(new SelectOption('25.0','$25'));
                    Options.add(new SelectOption('50.0','$50'));
                    Options.add(new SelectOption('100.0','$100'));
                    Options.add(new SelectOption('250.0','$250'));
                    Options.add(new SelectOption('500.0','$500'));
                    Options.add(new SelectOption('1000.0','$1000'));
                    Options.add(new SelectOption('0.0','Other'));
return Options;
}


/******** Passing values dynmacillay into the customfield(Question 1) ***********/
string dedicationval = 'Not Dedication';
public void setdedicationval(string S){this.dedicationval = S;}
public string getdedicationval(){return dedicationval;}

public list<SelectOption> getdedvalues(){
List<SelectOption> Options = new List<SelectOption>();

                    Options.add(new SelectOption('Not Dedication','Not Dedication'));
                    Options.add(new SelectOption('in honor of','in honor of'));
                    Options.add(new SelectOption('on behalf of','on behalf of'));
                    Options.add(new SelectOption('in memory of','in memory of'));
                    return Options;                 
}

/******** Passing values dynmacillay into the customfield(Question 2) ***********/
string conradio = 'Provide my full contact information';
public void setconradio(string S){this.conradio = S;}
public string getconradio(){return conradio;}

public list<SelectOption> getconvalues(){
List<SelectOption> Options = new List<SelectOption>();

                    Options.add(new SelectOption('Provide my full contact information','Provide my full contact information '));
                    Options.add(new SelectOption('Provide my contact name and email address only','Provide my contact name and email address only'));
                    Options.add(new SelectOption('Provide none of my personal information(anonymous)','Provide none of my personal information(anonymous)'));
                    return Options;                 
}


/******** Process button Action goes here *********/
Public void Submit(){

list<CnPAccountSetting__c> SettingsList=[select C_P_AccountGUID__c,C_P_Account_Number__c,WID__c from CnPAccountSetting__c limit 1]; //getting values from C&P Account information
Authentication.AccountGuid=SettingsList[0].C_P_AccountGUID__c; //inserting value of Account no getting from C & P Account
Authentication.AccountID=SettingsList[0].C_P_Account_Number__c;  //inserting value of Account GUID getting from C & P Account
Order.OrderMode='Test'; //Passing Order as Test 
PaymentMethod.Nameoncard = BillingInfo.BillingFirstName + ' ' + BillingInfo.BillingLastName ; //Concataning First name & Last name and passing value into "Name on card"

for(CnP_IaaS.Paas_Class.Items i : Itemlist){
i.ItemName='Donation'; //Passing the Item name statically as Donation
}
cnptransaction.RecurringMethod = 'Subscription'; //Passing the Recurring Method as Subscription 
cnptransaction.Installment = '999';//Passing No. of installments as 999 by default
 
list<CnP_IaaS.PaaS_Class.Customfields> XmlCustomfieldlist_list = new list<CnP_IaaS.PaaS_Class.Customfields>(); //Taking a list component for Custom Questions

   if(dedicationval != 'Not Dedication'){
         dedicationresult = dedicationval+' '+questiontextval;
    }else{
            dedicationresult = dedicationval;
        }
        
// Adding name,value for customfield(Question 1) Dedication
 CnP_IaaS.PaaS_Class.Customfields XmlCustomfieldlist = new CnP_IaaS.PaaS_Class.Customfields(); //initilazing the Customfield
 XmlCustomfieldlist.Fieldname = 'Dedication'; //Passing the Field name value as dedication by default
 XmlCustomfieldlist.FieldValue = dedicationresult;  //Passing the Field value which we obtain from dedication result
 XmlCustomfieldlist_list.add(XmlCustomfieldlist); //adding Fieldname,Fieldvalue to the list


 if(Acknowledgement == 'true'){
         Acknowledgement = 'Yes';
    }
    else{
        Acknowledgement = 'No';
    }
    
// Adding name,value for customfield Acknowledgment
CnP_IaaS.PaaS_Class.Customfields XmlCustomfieldlist2 = new CnP_IaaS.PaaS_Class.Customfields(); //initilazing the Customfield Question2
  XmlCustomfieldlist2.Fieldname = 'Send Dedication acknowledgement'; //Passing the Field name value as Send Acknowledgement by default
  XmlCustomfieldlist2.FieldValue = Acknowledgement; //Passing the Field value which we obtain from Acknowledgment
  XmlCustomfieldlist_list.add(XmlCustomfieldlist2); //adding Fieldname,Fieldvalue to the list 
  
// Adding name,value for customfield Contact Info 
CnP_IaaS.PaaS_Class.Customfields XmlCustomfieldlist3 = new CnP_IaaS.PaaS_Class.Customfields(); //initilazing the Customfield Question3
  XmlCustomfieldlist3.Fieldname = 'Contact Preferences'; //Passing the Field name value as Contact preferences by default
  XmlCustomfieldlist3.FieldValue = conradio; //Passing the Field value which we obtain from conradio
  XmlCustomfieldlist_list.add(XmlCustomfieldlist3); //adding Fieldname,Fieldvalue to the list

/******* Getting the Signatures of related fields ********/
cnpxmlstring.getOperation_node(Operation); // getting the values of operation node
cnpxmlstring.getOrder_node(Order); //getting the values of Order node
cnpxmlstring.getAuthentication_node(Authentication);  //getting the values of Authentication node
cnpxmlstring.getBillingInformation_node(BillingInfo); //getting the values of Billing Information 
cnpxmlstring.getBillingAddress_node(BillingAddress); //getting the values of Billing Address node
cnpxmlstring.getItemslist_node(Itemlist); 
cnpxmlstring.getTransactionDetails_node(cnpTransaction); //getting the values of Authentication node
cnpxmlstring.setfieldslist(XmlCustomfieldlist_list); //setting the values of Customfield list
cnpxmlstring.getCustomFieldList_node(cnpxmlstring); //getting the values of Customfield list
cnpxmlstring.getPaymentMethod_node(PaymentMethod); //getting the values of payment node
cnpxmlstring.getreceipt_node(Receipt); //getting the values of Receipt node
cnpxmlstring.getgeneratexml(cnpxmlstring); // generating the Xml file
cnpxmlstring.Send_Transaction_api(cnpxmlstring.xmlfile); //sending it to the C&P data
 
}
}