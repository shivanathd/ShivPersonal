@isTest
private class TestClass_CnP_Class_Library_Examples{

public static testMethod void testExample_Basic() {
Example_Basic e=new Example_Basic();
CnP_IaaS.Paas_Class TempString=new CnP_IaaS.Paas_Class();

e.cnpxmlstring =TempString;
CnP_IaaS.PaaS_Class.Operation Op= new CnP_IaaS.PaaS_Class.Operation();
e.Operation=Op;
list<CnP_IaaS.Paas_Class.Items> TempList=new list<CnP_IaaS.Paas_Class.Items>();
CnP_IaaS.Paas_Class.Items tempitem=new CnP_IaaS.Paas_Class.Items();
tempitem.ItemName='Test';
TempList.add(tempitem);
e.cnpxmlstring.ItemsList=TempList;
CnPAccountSetting__c rec=new CnPAccountSetting__c();
rec.C_P_AccountGUID__c='Test';
rec.C_P_Account_Number__c='Test';
insert rec;
e.process();
}
public static testMethod void testExample_Basic_eCheck() {
Example_Basic_eCheck e=new Example_Basic_eCheck();

CnP_IaaS.PaaS_Class.Operation Op= new CnP_IaaS.PaaS_Class.Operation();
e.Operation=Op;
list<CnP_IaaS.Paas_Class.Items> TempList=new list<CnP_IaaS.Paas_Class.Items>();
CnP_IaaS.Paas_Class.Items tempitem=new CnP_IaaS.Paas_Class.Items();
tempitem.ItemName='Test';
TempList.add(tempitem);
e.cnpxmlstring.ItemsList=TempList;
CnPAccountSetting__c rec=new CnPAccountSetting__c();
rec.C_P_AccountGUID__c='Test';
rec.C_P_Account_Number__c='Test';
insert rec;
e.process();
}
public static testMethod void testExample_eCheck_SelectName() {
Example_eCheck_SelectName e=new Example_eCheck_SelectName();
e.getFundNames();
CnP_IaaS.PaaS_Class.Operation Op= new CnP_IaaS.PaaS_Class.Operation();
e.Operation=Op;
list<CnP_IaaS.Paas_Class.Items> TempList=new list<CnP_IaaS.Paas_Class.Items>();
CnP_IaaS.Paas_Class.Items tempitem=new CnP_IaaS.Paas_Class.Items();
tempitem.ItemName='Test';
TempList.add(tempitem);
e.cnpxmlstring.ItemsList=TempList;
CnPAccountSetting__c rec=new CnPAccountSetting__c();
rec.C_P_AccountGUID__c='Test';
rec.C_P_Account_Number__c='Test';
insert rec;
e.process();

}

public static testMethod void testExample_Min_Fields() {
Example_Min_Fields e=new Example_Min_Fields();

CnP_IaaS.PaaS_Class.Operation Op= new CnP_IaaS.PaaS_Class.Operation();
e.Operation=Op;
list<CnP_IaaS.Paas_Class.Items> TempList=new list<CnP_IaaS.Paas_Class.Items>();
CnP_IaaS.Paas_Class.Items tempitem=new CnP_IaaS.Paas_Class.Items();
tempitem.ItemName='Test';
TempList.add(tempitem);
e.cnpxmlstring.ItemsList=TempList;
CnPAccountSetting__c rec=new CnPAccountSetting__c();
rec.C_P_AccountGUID__c='Test';
rec.C_P_Account_Number__c='Test';
insert rec;
e.process();

}
public static testMethod void testExample_Multiple_Radio_buttons() {
Example_Multiple_Radio_buttons e=new Example_Multiple_Radio_buttons();
CnP_IaaS.PaaS_Class.Operation Op= new CnP_IaaS.PaaS_Class.Operation();
e.Operation=Op;
list<CnP_IaaS.Paas_Class.Items> TempList=new list<CnP_IaaS.Paas_Class.Items>();
CnP_IaaS.Paas_Class.Items tempitem=new CnP_IaaS.Paas_Class.Items();
tempitem.ItemName='Test';
TempList.add(tempitem);
e.cnpxmlstring.ItemsList=TempList;
CnPAccountSetting__c rec=new CnPAccountSetting__c();
rec.C_P_AccountGUID__c='Test';
rec.C_P_Account_Number__c='Test';
insert rec;
e.process();
e.getAmounts();
}

public static testMethod void testExample_Radio_Button() {
Example_Radio_Button e=new Example_Radio_Button();
e.getAmounts();
CnP_IaaS.PaaS_Class.Operation Op= new CnP_IaaS.PaaS_Class.Operation();
e.Operation=Op;
list<CnP_IaaS.Paas_Class.Items> TempList=new list<CnP_IaaS.Paas_Class.Items>();
CnP_IaaS.Paas_Class.Items tempitem=new CnP_IaaS.Paas_Class.Items();
tempitem.ItemName='Test';
TempList.add(tempitem);
e.cnpxmlstring.ItemsList=TempList;
CnPAccountSetting__c rec=new CnPAccountSetting__c();
rec.C_P_AccountGUID__c='Test';
rec.C_P_Account_Number__c='Test';
insert rec;
e.process();

}

public static testMethod void testExample_Radio_Button_Recurring() {
Example_Radio_Button_Recurring e=new Example_Radio_Button_Recurring();
e.getAmounts();
e.getFundNames();
CnP_IaaS.PaaS_Class.Operation Op= new CnP_IaaS.PaaS_Class.Operation();
e.Operation=Op;
list<CnP_IaaS.Paas_Class.Items> TempList=new list<CnP_IaaS.Paas_Class.Items>();
CnP_IaaS.Paas_Class.Items tempitem=new CnP_IaaS.Paas_Class.Items();
tempitem.ItemName='Test';
TempList.add(tempitem);
e.cnpxmlstring.ItemsList=TempList;
CnPAccountSetting__c rec=new CnPAccountSetting__c();
rec.C_P_AccountGUID__c='Test';
rec.C_P_Account_Number__c='Test';
insert rec;
e.process();
}

public static testMethod void testExample_Radio_SelectName() {
Example_Radio_SelectName e=new Example_Radio_SelectName();
e.getAmounts();
e.getFundNames();
CnP_IaaS.PaaS_Class.Operation Op= new CnP_IaaS.PaaS_Class.Operation();
e.Operation=Op;
list<CnP_IaaS.Paas_Class.Items> TempList=new list<CnP_IaaS.Paas_Class.Items>();
CnP_IaaS.Paas_Class.Items tempitem=new CnP_IaaS.Paas_Class.Items();
tempitem.ItemName='Test';
TempList.add(tempitem);
e.cnpxmlstring.ItemsList=TempList;
CnPAccountSetting__c rec=new CnPAccountSetting__c();
rec.C_P_AccountGUID__c='Test';
rec.C_P_Account_Number__c='Test';
insert rec;
e.process();
}
public static testMethod void testExample_Selling_Items() {
Example_Selling_Items e=new Example_Selling_Items();
e.getAmounts();
e.getFundNames();
CnP_IaaS.PaaS_Class.Operation Op= new CnP_IaaS.PaaS_Class.Operation();
e.Operation=Op;
list<CnP_IaaS.Paas_Class.Items> TempList=new list<CnP_IaaS.Paas_Class.Items>();
CnP_IaaS.Paas_Class.Items tempitem=new CnP_IaaS.Paas_Class.Items();
tempitem.ItemName='Test';
TempList.add(tempitem);
e.cnpxmlstring.ItemsList=TempList;
CnPAccountSetting__c rec=new CnPAccountSetting__c();
rec.C_P_AccountGUID__c='Test';
rec.C_P_Account_Number__c='Test';
insert rec;
e.process();
}

public static testMethod void testPaaS_Class() 
                    {
                     CnP_Iaas.PaaS_Class d=new CnP_Iaas.PaaS_Class();
                     CnP_Iaas.PaaS_Class.Operation Op= new CnP_Iaas.PaaS_Class.Operation();
                     string Operation='';
                     boolean TempValue=true;
                     op.getOperationType();                     
                     op.setOperationType(Operation);
                     op.getIPAddress();
                     op.setIPAddress(Operation);
                     Boolean value=true;
                     op.getDeclineFraud();
                     op.setDeclineFraud(value);
                     op.getEnableRestriction();
                     op.setEnableRestriction(value);
                     op.getUrlReferrer();
                     op.setUrlReferrer(Operation);                     
                     d.getBooleanValues();
                     d.getOperation_node(Op);
                     System.assertEquals(Operation, '');
                     CnP_Iaas.PaaS_Class.Authentication Auth= new CnP_Iaas.PaaS_Class.Authentication();
                     Auth.getAccountID();
                     Auth.setAccountID(Operation);
                     Auth.getAccountGuid();
                     Auth.setAccountGuid(Operation);
                     d.getAuthentication_node(Auth);
                     
                     CnP_Iaas.PaaS_Class.Order Ord= new CnP_Iaas.PaaS_Class.Order();
                     Ord.getOrderMode();
                     Ord.setOrderMode(Operation);
                     Ord.getTracker();
                     Ord.setTracker(Operation);
                     Ord.getCampaign();
                     Ord.setCampaign(Operation);
                     Ord.getIntegratedPartner();
                     Ord.setIntegratedPartner(Operation);
                     d.getOrder_node(Ord);
                     d.getOrderModeTypes();
                     
                     CnP_Iaas.PaaS_Class.BillingInformation BI= new CnP_Iaas.PaaS_Class.BillingInformation();
                     BI.getBillingFirstName();
                     BI.setBillingFirstName(Operation);
                     BI.getBillingMI();
                     BI.setBillingMI(Operation);
                     BI.getBillingLastName();
                     BI.setBillingLastName(Operation);
                     BI.getBillingEmail();
                     BI.setBillingEmail(Operation);
                     BI.getBillingPhone();
                     BI.setBillingPhone(Operation);
                     d.getBillingInformation_node(BI);
                     d.getCountryCodes();
                     d.getCountrycodeValues();
                     d.getUSStates();
                     
                     CnP_Iaas.PaaS_Class.BillingAddress BA= new CnP_Iaas.PaaS_Class.BillingAddress();
                     BA.getBillingAddress1();
                     BA.setBillingAddress1(Operation);
                     BA.getBillingAddress2();
                     BA.setBillingAddress2(Operation);
                     BA.getBillingAddress3();
                     BA.setBillingAddress3(Operation);
                     BA.getBillingCity();
                     BA.setBillingCity(Operation);
                     BA.getBillingStateProvince();
                     BA.setBillingStateProvince(Operation);
                     BA.getBillingPostalCode();
                     BA.setBillingPostalCode(Operation);
                     BA.getBillingCountryCode();
                     BA.setBillingCountryCode(Operation);
                     BA.getBillingPhone();
                     BA.setBillingPhone(Operation);
                     d.getBillingAddress_node(BA);
                     
                     
                     CnP_Iaas.PaaS_Class.ShippingInformation SI= new CnP_Iaas.PaaS_Class.ShippingInformation();
                     SI.getShippingFirstName();
                     SI.setShippingFirstName(Operation);
                     SI.getShippingMI();
                     SI.setShippingMI(Operation);
                     SI.getShippingLastName();
                     SI.setShippingLastName(Operation);
                     SI.getShippingEmail();
                     SI.setShippingEmail(Operation);
                     SI.getShippingPhone();
                     SI.setShippingPhone(Operation);
                     SI.getShippingAddress1();
                     SI.setShippingAddress1(Operation);
                     SI.getShippingAddress2();
                     SI.setShippingAddress2(Operation);
                     SI.getShippingAddress3();
                     SI.setShippingAddress3(Operation);
                     SI.getShippingCity();
                     SI.setShippingCity(Operation);
                     SI.getShippingStateProvince();
                     SI.setShippingStateProvince(Operation);
                     SI.getShippingPostalCode();
                     SI.setShippingPostalCode(Operation);
                     SI.getShippingCountryCode();
                     SI.setShippingCountryCode(Operation);
                     
                     d.getShippingInformation_node(SI);
                     
                     
                     CnP_Iaas.PaaS_Class.customfields CF= new CnP_Iaas.PaaS_Class.customfields();
                     CF.getFieldname();
                     CF.setFieldname(Operation);
                     CF.getFieldvalue();
                     CF.setFieldvalue(Operation);
                     d.getfieldslist();
                     d.addcustomfield();
                     d.getCustomFieldList_node(d);
                     
                     CnP_Iaas.PaaS_Class.PaymentMethod cc= new CnP_Iaas.PaaS_Class.PaymentMethod();
                     cc.getNameOnCard();
                     cc.setNameOnCard(Operation);
                     cc.getCardNumber();
                     cc.setCardNumber(Operation);
                     cc.getCvv2();
                     cc.setCvv2(Operation);
                     cc.getExpirationMonth();
                     cc.setExpirationMonth(Operation);
                     cc.getExpirationYear();
                     cc.setExpirationYear(Operation);
                     cc.getOrderNumber();
                     cc.setOrderNumber(Operation);
                     cc.getVaultGUID();
                     cc.setVaultGUID(Operation);
                     cc.getAccountNumber();
                     cc.setAccountNumber(Operation);
                     cc.getAccountType();
                     cc.setAccountType(Operation);
                     cc.getRoutingNumber();
                     cc.setRoutingNumber(Operation);
                     cc.getCheckNumber();
                     cc.setCheckNumber(Operation);
                     cc.getCheckType();
                     cc.setCheckType(Operation);
                     cc.getNameOnAccount();
                     cc.setNameOnAccount(Operation);
                     cc.getIdType();
                     cc.setIdType(Operation);
                     cc.getIdNumber();
                     cc.setIdNumber(Operation);
                     cc.getIdStateCode();
                     cc.setIdStateCode(Operation);
                     cc.getPurchaseOrderNumber();
                     cc.setPurchaseOrderNumber(Operation);
                     cc.getInvoiceCheckNumber();
                     cc.setInvoiceCheckNumber(Operation);
                     cc.getCustomPaymentName();
                     cc.setCustomPaymentName(Operation);
                     cc.getCustomPaymentNumber();
                     cc.setCustomPaymentNumber(Operation);
                     //cc.getNameOnCard();
                     //cc.setNameOnCard(Operation);
                     
                     d.getPaymentTypes();
                     d.getAccountTypes();
                     d.getCheckTypes();
                     d.getIdTypes();
                     d.getExpireMonth();
                     d.getExpireYear();
                     
                     cc.getPaymentType();
                     cc.setPaymentType('CreditCard');
                     
                     d.getPaymentMethod_node(cc);
                     
                     cc.setPaymentType('ReferenceTransaction');
                     d.getPaymentMethod_node(cc);
                     
                     cc.setPaymentType('Check');
                     d.getPaymentMethod_node(cc);
                     
                     cc.setPaymentType('PurchaseOrder');
                     d.getPaymentMethod_node(cc);
                     
                     cc.setPaymentType('Invoice');
                     d.getPaymentMethod_node(cc);
                     
                     CnP_Iaas.PaaS_Class.SocialNetworks sn=new CnP_Iaas.PaaS_Class.SocialNetworks();
                     d.getsupportedSocialNetworks();
                     d.getnetworks();
                     d.addnetwork();
                     d.getsocialnetworks_node(d);
                     
                     CnP_Iaas.PaaS_Class.enewsletterProvider Enl=new CnP_Iaas.PaaS_Class.enewsletterProvider();
                     d.getsupportedEnewsLetters();
                     d.getnewsletter();
                     d.addnewsletter();
                     d.getenewsletters_node(d);
                     
                     CnP_Iaas.PaaS_Class.CRMProvider crm=new CnP_Iaas.PaaS_Class.CRMProvider();
                     d.getsupportedCRMS();
                     d.getcrmsList();
                     d.addcrm();
                     d.getcrms_node(d);
                                                                                   
                     
                     CnP_Iaas.PaaS_Class.items IL= new CnP_Iaas.PaaS_Class.items();
                     d.getItemsList();
                     d.addItem();
                     list<CnP_Iaas.PaaS_Class.Items> TempList=new list<CnP_Iaas.PaaS_Class.Items>();
                     CnP_Iaas.PaaS_Class.Items tempitem=new CnP_Iaas.PaaS_Class.Items();
                     tempitem.ItemName='Test';
                     TempList.add(tempitem);                     
                     d.getItemslist_node(TempList);
                     d.ItemsList=TempList;
                     d.getItemsString_node(d); 
                      
                      
                      
                      
                     CnP_Iaas.PaaS_Class.Receipt Rp= new CnP_Iaas.PaaS_Class.Receipt();
                     Rp.getSendReceipt();
                     Rp.setSendReceipt(TempValue);
                     Rp.getOrganizationInformation();
                     Rp.setOrganizationInformation(Operation);
                     Rp.getThankYouMessage();
                     Rp.setThankYouMessage(Operation);
                     Rp.getTermsCondition();
                     Rp.setTermsCondition(Operation);
                     Rp.getDeductible();
                     Rp.setDeductible(TempValue);
                     Rp.getEmailNotificationList();
                     Rp.setEmailNotificationList(Operation);
                     d.getsupportedLanguages();
                     d.getreceipt_node(Rp);
                     
                     CnP_Iaas.PaaS_Class.cnpTransaction Tran= new CnP_Iaas.PaaS_Class.cnpTransaction();
                     Tran.getTransactionType();
                     Tran.setTransactionType(Operation);
                     Tran.getDynamicDescriptor();
                     Tran.setDynamicDescriptor(Operation);                     
                     Tran.getrecurring();
                     Tran.setrecurring(TempValue);
                     Tran.getInstallment();
                     Tran.setInstallment(Operation);
                     Tran.getEndDateYear();
                     Tran.setEndDateYear(Operation);
                     Tran.getEndDateMonth();
                     Tran.setEndDateMonth(Operation);
                     Tran.getEndDateDay();
                     Tran.setEndDateDay(Operation);
                     Tran.getPeriodicity();
                     Tran.setPeriodicity(Operation);
                     Tran.getRecurringMethod();
                     Tran.setRecurringMethod(Operation);
                     Tran.getCouponCode();
                     Tran.setCouponCode(Operation);
                     decimal TempValue1=0;
                     Tran.getTransactionDiscount();
                     Tran.setTransactionDiscount(TempValue1);
                     Tran.getTransactionTax();
                     Tran.setTransactionTax(TempValue1);
                     Tran.getTransactionConvenienceFee();
                     Tran.setTransactionConvenienceFee(TempValue1);
                     Tran.getChargeDate();
                     Tran.setChargeDate(Operation);
                     Tran.getGiftCardList();
                     Tran.setGiftCardList(Operation);
                     Tran.getOrderNumber();
                     Tran.setOrderNumber(Operation);
                     Tran.getVaultGUID();
                     Tran.setVaultGUID(Operation);
                     
                     
                     d.getTransactionType();
                     d.getPeriodicity();
                     d.getRecurringMethod();
                     d.getTransactionDetails_node(Tran);
                     
                       CnP_Iaas.PaaS_Class xmlstring=d;
                       d.VerifyXmlfile=false;
                       d.getgeneratexml(xmlstring);
                       d.Send_Transaction_api(d.xmlfile);
                       
                       d.getItemsList();
                       d.addItem();
                       
                       //list<CnP_Iaas.PaaS_Class.itemlist> items = IL.getItems();
                      // d.getItemlist(xmlstring);
                    }
                    
                    public static testmethod void TestClickandpledgepaymentprocess()
   {
       string name='naresh';
       System.assertEquals(name, 'naresh');
       CnP_IaaS.PaaS_Cloud.basicHttpEndpoint cnp = new CnP_IaaS.PaaS_Cloud.basicHttpEndpoint();
       CnP_IaaS.PaaS_Cloud.OperationBase64Encode_element cc = new CnP_IaaS.PaaS_Cloud.OperationBase64Encode_element();
       CnP_IaaS.PaaS_Cloud.EchoResponse_element cc1 = new CnP_IaaS.PaaS_Cloud.EchoResponse_element();
       CnP_IaaS.PaaS_Cloud.OperationBase64EncodeResponse_element cc2 = new CnP_IaaS.PaaS_Cloud.OperationBase64EncodeResponse_element();
       CnP_IaaS.PaaS_Cloud.Operation_element cc3 = new CnP_IaaS.PaaS_Cloud.Operation_element();
       CnP_IaaS.PaaS_Cloud.OperationResponse_element cc4 = new CnP_IaaS.PaaS_Cloud.OperationResponse_element();
      
   }
   
   public static testmethod void TestSchemaapi()
   
   {   
       string name='naresh'; 
       System.assertEquals(name, 'naresh');
       CnP_IaaS.PaaS_Cloud_Response.ccTransactionResult cct = new CnP_IaaS.PaaS_Cloud_Response.ccTransactionResult();
       CnP_IaaS.PaaS_Cloud_Response.echoData ecd = new CnP_IaaS.PaaS_Cloud_Response.echoData();
      
   } 
}