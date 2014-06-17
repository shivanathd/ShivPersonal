public with sharing class cntHouseKeeping {
	
	public List<HouseKeepingWrapper> lstWrapperHouseKeeping{get;set;}
	public string houseKeepingStatus{get;set;}
	public House_Keeping__c objHouseFilter{get;set;}
	
	public cntHouseKeeping(ApexPages.StandardController st){
		objHouseFilter=new House_Keeping__c();
	 	 DisplayData(null,null);
	}
	 
	 public Pagereference searchHouseKeeping(){
	 	DisplayData(houseKeepingStatus,objHouseFilter);
	 	return null;
	 }
	 public List<SelectOption> getServiceList() 
	    {
	        List<SelectOption> options = new List<SelectOption>();
	        options.add(new SelectOption('None','--None--'));
	        Schema.DescribeFieldResult fieldResult = House_Keeping__c.Service__c.getDescribe();
	        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
	        for(Schema.PicklistEntry p : ple)
	        	options.add(new SelectOption(p.getValue(), p.getValue()));        
	        return options;
	    }
    
	 private void DisplayData(string houseKeepingStatus,House_Keeping__c obj1){
	 		//get Room Status and Code from Custom settings
	 	Map<string,string> mapStatusColorCode=new Map<string,string>();
	 	for(Room_Cleaning_Status_Code__c roomStatus: Room_Cleaning_Status_Code__c.getall().values()){
	 		mapStatusColorCode.put(roomStatus.Name,	roomStatus.Status_Color_Code__c);
	 	}
	 	lstWrapperHouseKeeping=new List<HouseKeepingWrapper>();
	 	
	 	//get All Room and Room Type
	 	string roomQuery='select id,Name,Room_Type__c,Room_Type__r.Name	from Room__c where Name!=null ';
	 	if(objHouseFilter.Temp_Room__c!=null){
	 		roomQuery=roomQuery +' and  Id=\'' + objHouseFilter.Temp_Room__c + '\'';
	 	}
	 	roomQuery=roomQuery + 'order by Name ASC limit 50000';
	 	List<Room__c> lstRoom=Database.query(roomQuery);
	 	
	 	//get All Existing House Keeping record
	 	Map<id,House_Keeping__c> objHouseMap=new Map<Id,House_Keeping__c>();
	 	string qry='select Service__c,Temp_Employee__c ,Temp_Room__c,Id,Name,Description__c,Employee__c, Room__c from House_Keeping__c where Name!=null';
	 	if(houseKeepingStatus!=null  && houseKeepingStatus!='None'){
	 		qry=qry+' and Service__c=\'' + houseKeepingStatus + '\'';
	 	}
	 	if(objHouseFilter.Temp_Room__c!=null){
	 		qry=qry+' and  Room__c=\'' + objHouseFilter.Temp_Room__c + '\'';
	 	}
	 	if(objHouseFilter.Temp_Employee__c!=null){
	 		qry=qry+' and  Employee__c=\'' + objHouseFilter.Temp_Employee__c + '\'';
	 	}
	 	
	 	qry=qry+' limit 50000';
	 	
	 	system.debug('qry-------------->' + qry);
	 	
	 	List<House_Keeping__c> lstHouseKeeping=Database.query(qry);
	 	
	 	for(House_Keeping__c objHouse:lstHouseKeeping){
	 		objHouseMap.put(objHouse.Room__c,objHouse);
	 	}
	 	
	 	//Check condition whether you have clicked on search or not
	 	boolean isSearch=false;
	 	if((houseKeepingStatus!=null  && houseKeepingStatus!='None') ||  objHouseFilter.Temp_Employee__c!=null){
 			isSearch=true;
 		}
	 	//Bind Wrapper with House keeping Object
	 	for(Room__c objRoom:lstRoom){
	 		//Check House Keeping Entry
	 		House_Keeping__c objHouse=objHouseMap.get(objRoom.Id);
	 		if(objHouse==null && isSearch==false){
	 			objHouse= new House_Keeping__c();
	 			objHouse.Room__c=objRoom.Id;
	 		}
	 		if(objHouse!=null){
		 		HouseKeepingWrapper hs=new HouseKeepingWrapper(objHouse);
		 		hs.colorCode='#FFFFFF';
		 		hs.isChecked=false;
		 		if(objHouse.Id!=null){
		 			hs.colorCode=mapStatusColorCode.get(objHouse.Service__c);
		 			hs.isChecked=true;
		 		}
		 		hs.roomType=objRoom.Room_Type__r.Name;
		 		hs.roomName=objRoom.Name;
		 		lstWrapperHouseKeeping.add(hs);
	 		}
	 	}
	 }
	 
	 public Pagereference SaveData(){
	 	if(lstWrapperHouseKeeping!=null && lstWrapperHouseKeeping.size()>0){
	 		boolean isSelected=false;
	 		boolean isBlankEmployee=false;
	 		boolean blnServiceStatus=false;
	 		List<House_Keeping__c> lstHouseInsert=new List<House_Keeping__c>();
	 		for(HouseKeepingWrapper house:lstWrapperHouseKeeping){
	 			if(house.isChecked==true){
	 				isSelected=true;
	 				if(house.objHouse.Service__c==null){
	 					blnServiceStatus=true;
	 					break;
	 				}
	 				if(house.objHouse.Temp_Employee__c==null){
	 					isBlankEmployee=true;
	 					break;
	 				}
	 				house.objHouse.Employee__c=house.objHouse.Temp_Employee__c;
	 				lstHouseInsert.add(house.objHouse);
	 				
	 			}
	 		}
	 		if(isSelected==false){
	 			 ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Please select room'));
                return null;
	 		}
	 		if(blnServiceStatus==true){
	 			ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Please select service'));
                return null;
	 		}
	 		 if(isBlankEmployee==true){
	 			ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Please assign employee'));
                return null;
	 		}
	 		if(lstHouseInsert!=null && lstHouseInsert.size()>0){
	 			upsert lstHouseInsert;
	 		}
	 	}
		Pagereference pg=new Pagereference('/apex/HouseKeeping');
		pg.setRedirect(true);
	 	return pg;
	 }
	 
	 public class HouseKeepingWrapper{
	 	public House_Keeping__c objHouse{get;set;}
	 	public string colorCode{get;set;}
	 	public string roomType{get;set;}
	 	public string roomName{get;set;}
	 	public boolean isChecked{get;set;}
	 	
	 	public HouseKeepingWrapper(House_Keeping__c obj1){
	 		objHouse=new House_Keeping__c();
	 		objHouse=obj1;
	 	}
	 }
}