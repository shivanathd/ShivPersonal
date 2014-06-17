trigger CampaignMemberInsert on CampaignMember (before insert) {

  Map<id,List<id>> CampaignMemberMap = new Map<id,List<id>>();

   // Loop through CampaignMembers
  for(CampaignMember CM: Trigger.new)
  {
      if(CM.ContactID != null)
      {
      if(CampaignMemberMap.get(CM.CampaignId)==null)
        CampaignMemberMap.put(CM.CampaignId,new List<id>());

        CampaignMemberMap.get(CM.CampaignId).add(cm.contactID);
      }

      if(CM.Lead != null)
      {
      if(CampaignMemberMap.get(CM.CampaignId)==null)
        CampaignMemberMap.put(CM.CampaignId,new List<id>());

        CampaignMemberMap.get(CM.CampaignId).add(cm.LeadID);
      }

   }


   Map<id,Campaign> CampaignMap = new Map<id,Campaign>();
   for(campaign cm :  [select id, event__c from Campaign where id in : CampaignMemberMap.keyset()])
   {
     CampaignMap.put(cm.id,cm);
   }
 
   map<id,event> CampEvtList = new map<id,event>();
   List<campaign> cmpToUpdate = new List<campaign>();
   List<eventRelation> evtRelList = new List<eventRelation>();

    for(id cmpID : CampaignMap.keyset())
    {
      if(CampaignMap.get(cmpId).Event__c == Null)
      {
        Event evt = new Event();
        // Add values to all required fields
        CampEvtList.put(cmpID,evt);

      }
     }


   if(CampEvtList.Values().size()>0)
    insert CampEvtList.Values();




   for(id cmpID : CampaignMap.keyset())
   {
  
     for(id attndID : CampaignMemberMap.get(cmpID))
     {
      EventRelation evtRel = new EventRelation();
      evtRel.RelationId = attndID;
      if((CampaignMap.get(cmpId).Event__c == Null))
      {
        evtRel.EventId = CampEvtList.get(cmpId).id;
        cmpToUpdate.add(new Campaign(id=cmpID,Event__c =CampEvtList.get(cmpId).id));

      }
      else
      {

        evtRel.EventId = CampaignMap.get(cmpId).Event__c;
      }
   
      evtRelList.add(evtRel);
     }

   }

    if(cmpToUpdate.size()>0)
     update cmpToUpdate;

    if(evtRelList.size()>0)
    insert EvtRelList;


}