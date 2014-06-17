public with sharing class BookingController {
	public list<Room_Type__c> lstRoomTypes{set; get;}
	public List<RoomWrapper> lstRooms{set; get;}
	public Date selectedDate{set; get;}
	public List<SelectOption> lstSORoomTypes{set; get;}
	public List<SelectOption> lstSOShowDays{set; get;}
	public String selectedRoomType{set; get;}
	public String selectedDays{set; get;}
	public List<Date> selectedDates{set; get;}
	public Map<String,String> mapColors{set; get;}
	
	
	public BookingController(){
		selectedDate = System.today();
		
		initData();
	}
	
	public void initData(){
		lstRoomTypes = [SELECT Id, Name, Description__c, Total_Rooms__c FROM Room_Type__c];
		lstSORoomTypes = new List<SelectOption>();
		selectedRoomType='';
		selectedDays='';
		lstSORoomTypes.add(new SelectOption('', '- None -'));
		for(Room_Type__c roomType : lstRoomTypes){
			lstSORoomTypes.add(new SelectOption(roomType.Id, roomType.Name));
		}
		//Init Days
		lstSOShowDays = new List<SelectOption>();
		selectedDays='Month';
		lstSOShowDays.add(new SelectOption('Month','Month') );
		lstSOShowDays.add(new SelectOption('1','1 Days') );
		lstSOShowDays.add(new SelectOption('2','2 Days') );
		lstSOShowDays.add(new SelectOption('3','3 Days') );
		lstSOShowDays.add(new SelectOption('7','Week') );
		lstSOShowDays.add(new SelectOption('15','15 Days') );
		
		mapColors = new Map<String, String>();
		mapColors.put('Clean',Room_Cleaning_Status_Code__c.getInstance('Clean').Status_Color_Code__c);
		mapColors.put('Dirty',Room_Cleaning_Status_Code__c.getInstance('Dirty').Status_Color_Code__c);
		mapColors.put('DNR',Room_Cleaning_Status_Code__c.getInstance('DNR').Status_Color_Code__c);
		mapColors.put('Inspect',Room_Cleaning_Status_Code__c.getInstance('Inspect').Status_Color_Code__c);
		mapColors.put('Repair',Room_Cleaning_Status_Code__c.getInstance('Repair').Status_Color_Code__c);
		mapColors.put('TouchUp',Room_Cleaning_Status_Code__c.getInstance('TouchUp').Status_Color_Code__c);
	}
	
	public void getRooms(){
		lstRooms = new List<RoomWrapper>();
		for(Room__c rm: [Select Id, Name, Block__c, Comment__c, Facilities__c, Floor__c, Room_Type__c,
									(Select Description__c, Employee__c, Room__c, Service__c, Temp_Employee__c, Temp_Room__c FROM Housekeeping__r)
									 from Room__c where Room_Type__c=:selectedRoomType]){
			lstRooms.add(new RoomWrapper(rm, (rm.Housekeeping__r!=null && rm.Housekeeping__r.size()>0 && rm.Housekeeping__r[0].Service__c!=null && mapColors.containsKey(rm.Housekeeping__r[0].Service__c)) ?mapColors.get(rm.Housekeeping__r[0].Service__c) :'Transparent' ));							 	
		}
		setSelectedDates(); 
	}
	
	public void setSelectedDates(){
		String dtString =ApexPages.currentPage().getParameters().get('selectedDate');
		System.debug('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@'+dtString);
		if(dtString !=null && dtString !=''){
			selectedDate = Date.parse(dtString);
		}
		selectedDates = new List<Date>();
		if(selectedDays=='Month'){
			integer i=0;
			while(selectedDate.addDays(i)<=selectedDate.addMonths(1)){
				selectedDates.add(selectedDate.addDays(i++));
			}
		}else if(selectedDays!=null){
			for(integer i=0; i< Integer.valueOf(selectedDays) ;i++){
				selectedDates.add(selectedDate.addDays(i));
			}
		}
	}
	
	public class RoomWrapper{
		public Room__c room{set; get;}
		public string color{set; get;}
		public RoomWrapper(Room__c rm, String cl){
			room=rm;
			color=cl;
		}
	}
	
}