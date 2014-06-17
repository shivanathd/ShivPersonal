Trigger EventUpdate on Event (before insert,before update)
{
  set<id> AccSet = new set<id>();
   
   for(Event ev: Trigger.new)
   {
  
     // Only Accounts that do not have valid meeting title
      if(String.ValueOf(ev.WhatId).startsWith('001')&& string.isblank(ev.location))
         AccSet.add(ev.WhatId);
   }

   Map<id,Account> AccMap = new Map<id,Account>([select id,name from account where id IN:AccSet]);
   
    for(Event ev: Trigger.new)
   {
    if(String.ValueOf(ev.WhatId).startsWith('001')&&AccMap.get(ev.WhatId)!=null)
         ev.Location = String.valueof(system.today())+' ' + AccMap.get(ev.WhatId).Name;
   }

   
}