public with sharing class cntOverBooking {
        public Over_Booking__c objOverFromBooking{get;set;}
        public Over_Booking__c objOverBooking{get;set;}
        public Over_Booking__c objOverToBooking{get;set;}
        public date toDate{get;set;}
        public integer dateDiff{get;set;}
        public list<RoomWrapper> lstRoomWrapper{get;set;}
        private List<String> days = new List<String>{'SUN','MON','TUE','WED','THU','FRI','SAT'};
        public list<DateNameWrapper> lstdateWrapper{get;set;}
        Map<integer, String> mapMonthName = new Map<integer, String>{1 => 'JAN',2 => 'FEB',
                3 => 'MAR',4 => 'APR',5 => 'MAY',6 => 'JUN',7 => 'JUL',8 => 'AUG',9 => 'SEP',
                10 => 'OCT',11 => 'NOV',12 => 'DEC'};
        
        public cntOverBooking(ApexPages.StandardController st){
                objOverFromBooking=new Over_Booking__c();
                objOverToBooking=new Over_Booking__c();
                objOverBooking=new Over_Booking__c();
                if(objOverFromBooking.Overbooking_Date__c==null){
                        objOverFromBooking.Overbooking_Date__c=Date.Today();
                }
                BindDate(objOverFromBooking.Overbooking_Date__c);
        }
        
        public void BindDate(Date dtFromDate){
                toDate=dtFromDate.addMonths(1);
                
                lstRoomWrapper=new List<RoomWrapper>();
                lstdateWrapper=new list<DateNameWrapper>();
                Map<Id, list<Over_Booking__c>> mapLstOverBooking=new Map<Id, list<Over_Booking__c>>();
                
                //Get All Room Type
                List<Room_Type__c> lstRoomType=[select Id,Name from Room_Type__c limit 5000];
                //get All Over Booking
                List<Over_Booking__c> lstOverBooking=[select Id, Overbooking_Date__c,
                        NO_of_Overbooking__c,Room_Type__c from Over_Booking__c where 
                        Overbooking_Date__c>=:dtFromDate and 
                        Overbooking_Date__c<=:toDate order by Overbooking_Date__c];
                
                //Create Map of Over Booking and Room Type      
                for(Over_Booking__c ovr: lstOverBooking){
                        if(mapLstOverBooking.containsKey(ovr.Room_Type__c)==true){
                                mapLstOverBooking.get(ovr.Room_Type__c).add(ovr);
                        }else{
                                mapLstOverBooking.put(ovr.Room_Type__c,new List<Over_Booking__c>{ovr});
                        }
                }
                dateDiff=dtFromDate.daysBetween(toDate);
                //Bind for Over Booking Wrapper
                for(Room_Type__c rt:lstRoomType){
                        RoomWrapper rp=new RoomWrapper();
                        rp.objRoomType=rt;
                        List<OverBookingDateWrapper> lstdate=new List<OverBookingDateWrapper>();
                        for(integer i=0;i<dateDiff;i++){
                                OverBookingDateWrapper dt=new OverBookingDateWrapper();
                                if(mapLstOverBooking.get(rt.Id)!=null && mapLstOverBooking.get(rt.Id).size()>0){
                                        for(Over_Booking__c ov:mapLstOverBooking.get(rt.Id)){
                                                if(ov.Overbooking_Date__c==dtFromDate.addDays(i)){
                                                        dt.objOverBooking=ov;
                                                }
                                        }
                                }
                                lstdate.add(dt);
                        }
                        rp.lstOverBookingWrapper=lstdate;
                        lstRoomWrapper.add(rp);
                }
                //Bind Date Name and date for Header
                for(integer i=0;i<dateDiff;i++){
                        DateNameWrapper dt=new DateNameWrapper();
                        dt.dateName=string.valueOf(dtFromDate.addDays(i).day()+''+mapMonthName.get(dtFromDate.addDays(i).Month()));
                        lstdateWrapper.add(dt);
                }
                objOverFromBooking.Overbooking_Date__c=dtFromDate;
        }
        public Pagereference searchOverBooking(){
                BindDate(objOverFromBooking.Overbooking_Date__c);
                return null;
        }
        public Pagereference next(){
                BindDate(toDate);
                return null;
        }
        public Pagereference previous(){
                BindDate(objOverFromBooking.Overbooking_Date__c.addMonths(-1));
                return null;
        }
        
        public Pagereference setOverBooking(){
                Set<Id> setRoomTypeId=new Set<Id>();
        for(RoomWrapper rw :lstRoomWrapper){
                if(rw.selectedHotel==true){
                        setRoomTypeId.add(rw.objRoomType.Id);
                }
        }
        if(setRoomTypeId.size()==0){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Please enter Room Type to set Overbooking'));
                        return null;
        }
                if(objOverBooking.Overbooking_Date__c==null){
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Please enter from date'));
                        return null;
        }
        if(objOverToBooking.Overbooking_Date__c==null){
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Please enter to date'));
                        return null;
        }
                if(objOverToBooking.Overbooking_Date__c<objOverBooking.Overbooking_Date__c){
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'To date will always be great or same than from date'));
                        return null;
        }
        toDate=objOverToBooking.Overbooking_Date__c;
        //Save data in Over Booking
        integer df=objOverBooking.Overbooking_Date__c.daysBetween(objOverToBooking.Overbooking_Date__c);
        if(objOverToBooking.NO_of_Overbooking__c==null){
                objOverToBooking.NO_of_Overbooking__c=0;
        }
        //Delet All OverBooking from past for particular days
        if(setRoomTypeId!=null && setRoomTypeId.size()>0){
                delete [select id from Over_Booking__c where Room_Type__c in :  setRoomTypeId and 
                        Overbooking_Date__c>=:objOverBooking.Overbooking_Date__c and 
                        Overbooking_Date__c<=:objOverToBooking.Overbooking_Date__c];
        }
                //Insert All Over booking       
        List<Over_Booking__c> lstInsert=new List<Over_Booking__c>();
        for(RoomWrapper rw :lstRoomWrapper){
                if(rw.selectedHotel==true){
                        for(integer i=0;i<=df;i++){
                                Over_Booking__c objOver=new Over_Booking__c();
                                objOver.Overbooking_Date__c=objOverBooking.Overbooking_Date__c.addDays(i);
                                objOver.Room_Type__c=rw.objRoomType.Id;
                                objOver.NO_of_Overbooking__c=objOverToBooking.NO_of_Overbooking__c;
                                lstInsert.add(objOver);
                        }
                }
        }
        if(lstInsert!=null && lstInsert.size()>0){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO,'Sucessfully Updated'));
                insert lstInsert;
        }
        
        //Serach Booking in the screen
        BindDate(objOverFromBooking.Overbooking_Date__c);               
                return null;
        }
        
        public class RoomWrapper{
                public Room_Type__c objRoomType{get;set;}
                public boolean selectedHotel{get;set;}
                public list<OverBookingDateWrapper> lstOverBookingWrapper{get;set;}
                public RoomWrapper(){
                        objRoomType=new Room_Type__c();
                        lstOverBookingWrapper=new List<OverBookingDateWrapper>();
                }
        }
        
        public class OverBookingDateWrapper{
                public Over_Booking__c objOverBooking{get;set;}
                public OverBookingDateWrapper(){
                        //objOverBooking=new Over_Booking__c();
                }
        }
        
        public class DateNameWrapper{
                public string dateName{get;set;}
                public DateNameWrapper(){
                        
                }
        }
        
}