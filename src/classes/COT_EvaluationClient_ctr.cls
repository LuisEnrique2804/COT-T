public class COT_EvaluationClient_ctr {
	@AuraEnabled
	public static List<DCTGruop__c> getComDir(String searchGroup) {
		String searchKeyGroup = searchGroup + '%';
		List<DCTGruop__c> lstDirComercial = new List<DCTGruop__c>();
		lstDirComercial = [
			SELECT 
				Id, 
				Name
				//Grupo__c  
			FROM DCTGruop__c 
			WHERE Name LIKE:searchKeyGroup
		];
		System.debug(loggingLevel.Error, '*** lstDirComercial: ' + lstDirComercial);
		return lstDirComercial;
	}

	@AuraEnabled
	public static List<DCTRegion__c> getRegion() {
		List<DCTRegion__c> lstRegion = new List<DCTRegion__c>();
		lstRegion = [SELECT Id, Name, FatherAccount__c, NationalAccount__c FROM DCTRegion__c Order By Name];
		System.debug(loggingLevel.Error, '*** lstRegion: ' + lstRegion);
		return lstRegion;
	}
}