global class DCT_ProcesaCompetidores_sch implements Schedulable {

	global String sIdReg {get;set;}
			
    global void execute(SchedulableContext ctx){
		System.debug('EN DCT_ProcesaCompetidores_sch.execute...');

		String sQuery;
		set<String> setPlataformas = new set<String>();
		Map<Id, CatalogoServiciosTradicionales__c> mapServTradPadres = new Map<Id, CatalogoServiciosTradicionales__c>();
		Set<String> setIdCompPlat = new Set<String>();
		
		//Ya no esta relacionado al catalogo de CatalogoServiciosTradicionales__c toma todo lo que tiene CatalogoServiciosTradicionales__c y que esta activo	
		mapServTradPadres = new Map<Id, CatalogoServiciosTradicionales__c>([Select Id, Name, PlataformaServiciosTradicionales__c, Activo__c From CatalogoServiciosTradicionales__c Where Activo__c = true]);
		System.debug('mapServTradPadres: ' + mapServTradPadres);
		
		//CompetidoresPlataformas__c
		for(CatalogoServiciosTradicionales__c cst : mapServTradPadres.Values()){
			if (cst.PlataformaServiciosTradicionales__c != null) 
				setPlataformas.add(cst.PlataformaServiciosTradicionales__c); 
		}
		//El enunciado para la consulta
		sQuery = 'Select Id,Name,Plataforma__c From ServiciosTradicionales__c Where Plataforma__c IN (\''+String.join(new List<String>(setPlataformas),'\',\'')+'\') ';

		//No es una prueba
		//if (!Test.isRunningTest())
		//	sQuery += ' LIMIT 100';
		//Si es una prueba
		if (Test.isRunningTest())
			sQuery += ' LIMIT 1';

		System.debug('EN DCT_ProcesaCompetidores_sch.execute sQuery: ' + sQuery);
		
		//Crea el objeto de  DCT_AdminCartera_bch   	
        DCT_ProcesaCompetidores_bch objProcComBch = new DCT_ProcesaCompetidores_bch(sQuery, sIdReg, mapServTradPadres);
        //No es una prueba entonces procesa de 1 en 1
       	Id batchInstanceId = Database.executeBatch(objProcComBch, 100);
			    	 
    }

}