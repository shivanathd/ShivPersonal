public with sharing class PriceMangerController {

   
// Public Members 
public List<Room_Type__c> RoomTypeList {get;set;}
public Map<id,List< Rate__c >> RoomRateMap {get;set;}

//----Controller------//
public PriceMangerController()
{
    Initialize();
}

public void Initialize()
{
  RoomTypeList = new List<Room_Type__c>();
  RoomRateMap = new Map<id,List< Rate__c >>();
  
  
  RoomTypeList = [select id,Name, Standard_Occupancy__c, Higher_Occupancy__c from Room_Type__c];
  
  for(Room_Type__c rt: RoomTypeList)
  {
      if(RoomRateMap.get(rt.id)==null)
       RoomRateMap.put(rt.id,new List< Rate__c >());
  }

  for(Rate__c rt: [select id,Name,Room_Type__c, Web__c,Agent__c,Corporate__c, Standard_Occupancy__c, Higher_Per_Person__c, Extra_Bed__c from Rate__c where Room_Type__c!=null])
  {
       RoomRateMap.get(rt.Room_type__c).add(rt);
  }
}

 public void saveRecord() {
 
    //List<Rate_Type__c>
      //  update RoomRateMap.values();
    }



}