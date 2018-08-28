public class COT_Quoting_ctr {
	@AuraEnabled
	public static Id getRecordTypeByName(String recordTypeName, COT_PerfilesCotizacion__c profile) {
		String searchRecordTypeByName = recordTypeName;
		Id idRecordType;
        Id idRecordProfile;
		Map<String,Map<String,RecordType>> mapRTsByDevName = TLCL_Utils_cls.getRecordTypes('Name');
        system.debug('*** searchRecordTypeByName: '+searchRecordTypeByName);
        system.debug('*** mapRTsByDevName: '+ mapRTsByDevName.get('COT_PerfilesCotizacion__c'));
        idRecordType = mapRTsByDevName.get('COT_PerfilesCotizacion__c').get(searchRecordTypeByName).Id;
        system.debug('*** idRecordType: '+ idRecordType);
        if (idRecordType != null ){
            profile.RecordTypeId = idRecordType;
        }
        Database.SaveResult sr = dataBase.insert(profile, true);
        if(sr.isSuccess()){
            idRecordProfile = sr.getId();
        } else{
            system.debug('*** sr.errors: '+ sr.errors);
        }
                
		return idRecordProfile;
	}
}