public class COT_EvaluationClient_ctr {
    public List<DCTRegion__c> lstRegion {get;set;}
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
	public static List<Cliente__c> getRFC(String searchRazonSocial) {
		String searchKeyRazonSocial = searchRazonSocial + '%';
        System.debug(loggingLevel.Error, '*** searchKeyRazonSocial: ' + searchKeyRazonSocial);
		List<Cliente__c> lstCliente = new List<Cliente__c>();
		lstCliente = [
            SELECT 
				Id, 
				Name,
				RFC__c  
			FROM Cliente__c 
			WHERE Name LIKE:searchKeyRazonSocial
            AND RFC__c != null
		];
		System.debug(loggingLevel.Error, '*** lstCliente: ' + lstCliente);
		return lstCliente;
	}

	@AuraEnabled
	public static List<DCTRegion__c> getNationalAcc(String searchNationalAcc, string strTypeAcc) {
        String searchKeyNationalAcc = searchNationalAcc + '%';
        //String searchKeyFatherAcc = searchFatherAcc + '%';
        System.debug(loggingLevel.Error, '*** searchKeyNationalAcc: ' + searchKeyNationalAcc);
        System.debug(loggingLevel.Error, '*** strTypeAcc: ' + strTypeAcc);
        string strType = strTypeAcc;
        System.debug(loggingLevel.Error, '*** strType: ' + strType);
		List<DCTRegion__c> lstRegion = new List<DCTRegion__c>();
		if(strType == 'Cuenta Nacional'){
        	lstRegion = [
            SELECT 
            	Id, 
            	NationalAccount__c,
            	FatherAccount__c 
            FROM DCTRegion__c 
            WHERE NationalAccount__c LIKE:searchKeyNationalAcc
            //OR FatherAccount__c LIKE: searchKeyFatherAcc
            Order By Name];
        }
        
        if(strType == 'Cuenta Padre'){
            System.debug(loggingLevel.Error, '*** Aqui Luis: ');
            lstRegion = [
            SELECT 
            	Id, 
            	NationalAccount__c,
            	FatherAccount__c 
            FROM DCTRegion__c 
            WHERE FatherAccount__c LIKE: searchKeyNationalAcc
            Order By Name];
        }
        
        
        /*lstRegion = [
            SELECT 
            	Id, 
            	NationalAccount__c,
            	FatherAccount__c 
            FROM DCTRegion__c 
            WHERE NationalAccount__c LIKE:searchKeyNationalAcc
            //OR FatherAccount__c LIKE: searchKeyFatherAcc
            Order By Name];*/
		System.debug(loggingLevel.Error, '*** lstRegion: ' + lstRegion);
		return lstRegion;
	}
}