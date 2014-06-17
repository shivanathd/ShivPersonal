public with sharing class cntRateController {
	public static Map<String,Integer> mapDays{set;get;}
	public static List<String> lstDays;
	public List<RoomTypeWrapper> lstRoomTypeWrappers{set;get;}
	public List<SelectOption> lstPackages{set; get;}
	public String selectedPackage{set; get;}
	String rackRatePackageId;
		
	static{
		mapDays = new Map<String,Integer>();
		mapDays.put('MON',0);
		mapDays.put('TUE',1);
		mapDays.put('WED',2);
		mapDays.put('THU',3);
		mapDays.put('FRI',4);
		mapDays.put('SAT',5);
		mapDays.put('SUN',6);
		
		lstDays= new List<String>();
		lstDays.add('MON');
		lstDays.add('TUE');
		lstDays.add('WED');
		lstDays.add('THU');
		lstDays.add('FRI');
		lstDays.add('SAT');
		lstDays.add('SUN');
	}
	
	public cntRateController(){
		initPackageList();
		initData();
	}
	
	public void initPackageList(){
		lstPackages = new List<SelectOption>();
		lstPackages.add(new SelectOption('','- All Packages -'));
		selectedPackage='';
		for(Packages__c pkg: [SELECT Id, Name, Room_Type__c, Room_Type__r.Name
											FROM Packages__c ]){
			if(pkg.Name!='Rack Rate'){
				lstPackages.add(new SelectOption(pkg.Id,pkg.Name));
			}else{
				rackRatePackageId=pkg.Id;
			}
		}
		
	}
	
	public void initData(){
		Map<String, List<Rate__c>> mapPackageRates = new Map<String, List<Rate__c>>();
		Map<String,List<String>> mapPackageAddOns = new Map<String,List<String>>();
		Map<String,Set<String>> mapRoomTypePackage = new Map<String,set<String>>();
		Map<String,PackageWrapper> mapPackageWithWrapper = new Map<String,PackageWrapper>();
		Map<String,String> mapRoomTypeNameId = new Map<String,String>();
		
		lstRoomTypeWrappers = new List<RoomTypeWrapper>();
		 
		//Varify that the room type id is valid id
		List<Rate__c> lstRates;
		lstRates = databAse.query('SELECT Id, Agent__c, Corporate__c, Extra_Bed__c, Higher_Per_Person__c, Packages__c, Packages__r.Name, Rack_Rate__c, Room_Type__c, Room_Type__r.Name, Standard_Occupancy__c, Web__c, Week_Days__c FROM Rate__c '+
									(selectedPackage!=null && selectedPackage!='' ? ' where Packages__c=:selectedPackage ' : '') +
									(rackRatePackageId!=null ? (selectedPackage!='' && selectedPackage!=null  ? ' OR Packages__c=:rackRatePackageId ' : '') : '') +
									' Order By Room_Type__r.Name, Packages__c');
		
		List<Packages__c> lstPackages = database.query('SELECT Id, Name, Room_Type__c, Room_Type__r.Name, Package_Price__c, '+ 
											' (SELECT Id, Add_ons__r.Name FROM Package_Addons__r) '+
											' FROM Packages__c WHERE Room_Type__c!=null ' + (selectedPackage!='' && selectedPackage!=null ? ' AND Id=:selectedPackage ' : ''));
		for(Packages__c pkg: lstPackages){
			List<String> lstaddons = new List<String>();
			for(Package_Addon__c pkgAddOn : pkg.Package_Addons__r){
				lstAddons.add(pkgAddOn.Add_ons__r.Name);
			}
			mapPackageAddOns.put(pkg.Id,lstAddOns);
		}
		
		for(Rate__c rate : lstRates){
			if(mapRoomTypePackage.containsKey(rate.Room_Type__r.Name)){
				mapRoomTypePackage.get(rate.Room_Type__r.Name).add(rate.Packages__c);
			}else{
				mapRoomTypePackage.put(rate.Room_Type__r.Name, new Set<String>{rate.Packages__c});
				mapRoomTypeNameId.put(rate.Room_Type__r.Name, rate.Room_Type__c);
			}
			
			if(mapPackageRates.containsKey(rate.Room_Type__c+':'+rate.Packages__c)){
				mapPackageRates.get(rate.Room_Type__c+':'+rate.Packages__c).add(rate);
			}else{
				mapPackageRates.put(rate.Room_Type__c+':'+rate.Packages__c,new List<Rate__c>{rate});
			}
		}
		//Process Existing Records
		for(String k : mapPackageRates.keySet()){
			String pkgId = k.subString(k.indexOf(':')+1,k.length());
			mapPackageWithWrapper.put( k , new PackageWrapper(pkgId, mapPackageRates.get(k)[0].Packages__r.Name, sortRatesByDays(mapPackageRates.get(k)), mapPackageAddOns.get(pkgId)));
		}
		
		//Process new Packages
		
		for(Packages__c pkg : lstPackages){
			if(!mapPackageRates.containsKey(pkg.Room_Type__c+':'+pkg.Id)){
				if(mapRoomTypePackage.containsKey(pkg.Room_Type__r.Name)){
					mapRoomTypePackage.get(pkg.Room_Type__r.Name).add(pkg.Id);
				}else{
					mapRoomTypePackage.put(pkg.Room_Type__r.Name, new Set<String>{pkg.Id});
					mapRoomTypeNameId.put(pkg.Room_Type__r.Name, pkg.Room_Type__c);
				}
				List<Rate__c> lstTempRates = new List<Rate__c>();
				for(String dayName : lstDays){
					lstTempRates.add(new Rate__c(Packages__c=pkg.Id, Room_Type__c=pkg.Room_Type__c, Standard_Occupancy__c=pkg.Package_Price__c, Week_Days__c=dayName));
				}
				mapPackageWithWrapper.put( pkg.Room_Type__c+':'+ pkg.Id,  new PackageWrapper(pkg.Id, pkg.Name, lstTempRates, mapPackageAddOns.get(pkg.Id)));
			}
		}
		
		
		Packages__c pkgRackRate;
		//If Rack Rate not added, add Rack Rate package in wrapper
		List<Packages__c> lstPkg = [SELECT Id, Name, Room_Type__c, Package_Price__c, 
										(SELECT Id, Add_ons__r.Name FROM Package_Addons__r) 
										FROM Packages__c WHERE Name=:'Rack Rate'];
		if(lstPkg.size()>0){
			pkgRackRate=lstPkg[0];
		}
		
		System.debug('@@@@@Room Type Names: '+mapRoomTypePackage);
		//Now create the list of RoomType Wrappers
		for(String k : mapRoomTypePackage.keySet()){
			Set<String> pkglist = mapRoomTypePackage.get(k);
			Boolean isRackRateAdded=false;
			List<PackageWrapper> lstpkgs = new List<PackageWrapper>();
			for(String strK : pkglist){
				lstpkgs.add(mapPackageWithWrapper.get(mapRoomTypeNameId.get(k)+':'+strk));
				if(isRackRateAdded==false && mapPackageWithWrapper.get(mapRoomTypeNameId.get(k)+':'+strk)!=null && mapPackageWithWrapper.get(mapRoomTypeNameId.get(k)+':'+strk).packageName=='Rack Rate'){
					isRackRateAdded=true;
				}
			}
			if(isRackRateAdded==false &&  pkgRackRate!=null){
				List<Rate__c> lstTempRates = new List<Rate__c>();
				for(String dayName : lstDays){
					lstTempRates.add(new Rate__c(Packages__c=pkgRackRate.Id, Room_Type__c=mapRoomTypeNameId.get(k), Standard_Occupancy__c=pkgRackRate.Package_Price__c, Week_Days__c=dayName));
				}
				lstpkgs.add( new PackageWrapper(pkgRackRate.Id, pkgRackRate.Name, lstTempRates, mapPackageAddOns.get(pkgRackRate.Id))) ;
			}
			//If Package size is more then 1 (1 for rack rate) only then add Room TYpe
			if(lstpkgs.size()>1){
				lstRoomTypeWrappers.add(new RoomTypeWrapper(k, lstpkgs));
			}
		}
		
	}
	
	public PageReference saveRates(){
		List<Rate__c> newRates = new List<Rate__c>();
		for(RoomTypeWrapper rtw : lstRoomTypeWrappers){
			for(PackageWrapper pw : rtw.lstPackageWrapper){
				newRates.add(pw.rates[0]);
				for(integer i=1;i<7; i++){
					pw.rates[i].Agent__c = pw.rates[0].Agent__c;
					pw.rates[i].Corporate__c = pw.rates[0].Corporate__c;
					pw.rates[i].Web__c = pw.rates[0].Web__c;
					newRates.add(pw.rates[i]);
				}
			}
		}
		if(newRates.size()>0){
			upsert newRates;
		}
		return null;
	}
	
	public Static List<Rate__c> sortRatesByDays(List<Rate__c> lstRates){
		Map<Integer,Rate__c> mapDayRate = new Map<Integer,Rate__c>();
		for(Rate__c rt: lstRates){
			mapDayRate.put(mapDays.get(rt.Week_Days__c),rt);
		}
		List<Rate__c> lstNewRates = new List<Rate__c>();
		for(Integer indx: mapDayRate.keySet()){
			lstNewRates.add(mapDayRate.get(indx));
		}
		return lstNewRates;
	}
	
	public class RoomTypeWrapper{
		public String roomTypeName{set; get;}
		public List<PackageWrapper> lstPackageWrapper{set; get;}
		 
		public RoomTypeWrapper(String rTypeName, List<PackageWrapper> lstpgW){
			roomTypeName = rTypeName;
			lstPackageWrapper = lstpgW!=null?lstpgW:new List<PackageWrapper>();
		}
	}
		
	public class PackageWrapper{
		public String packageId{set;get;}
		public String packageName{set;get;}
		public List<Rate__c> rates{set;get;}
		public List<String> addOns{set;get;}
		
		public PackageWrapper(String pkgId, String pkgName, List<Rate__c> lstRates, List<String>lstK){
			packageId = pkgId;
			rates = lstRates;
			packageName = pkgName;
			addOns=(lstK!=null) ? lstK : new List<String>();
		}
	}
}