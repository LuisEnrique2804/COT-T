global class DCT_ProcesaCompetidores_bch implements Database.Batchable<sObject>, Database.Stateful {

    global string query;
    global string sIdComp;
	global Map<Id, CatalogoServiciosTradicionales__c> mapServTradPadres;
	        
    //Un constructor por default
    global DCT_ProcesaCompetidores_bch(String query, String sIdComp, Map<Id, CatalogoServiciosTradicionales__c> mapServTradPadresParam){
        this.query = query;
        this.sIdComp = sIdComp;
        this.mapServTradPadres = mapServTradPadresParam;
    }
    
    //Start
    global Database.querylocator start(Database.BatchableContext BC){
        System.debug('EN DCT_ProcesaCompetidores_bch.start query: ' + this.query);
        return Database.getQueryLocator(this.query);
    }
    
    //Execute
    global void execute(Database.BatchableContext BC, List<ServiciosTradicionales__c> scopeServTrad){
        System.debug('EN DCT_ProcesaCompetidores_bch this.sIdComp: ' + this.sIdComp);

		//Recorre la lista de reg del tipo DCTCompetitors__c
		for(DCTCompetitors__c newEntity : [Select Id, Name From DCTCompetitors__c Where id =: this.sIdComp]){
        	//System.debug('EN DCT_ProcesaCompetidores_bch newEntity: ' + newEntity);
        							
			//No hay relacion con el catalogo de CompetidoresPlataformas__c asi que recorre todos los reg de CatalogoServiciosTradicionales__c
			//objCST = mapServTradPadres.get(newEntity.CatalogoServiciosTradicionales__c);			
			for (CatalogoServiciosTradicionales__c objCST: this.mapServTradPadres.Values()){
        		//System.debug('EN DCT_ProcesaCompetidores_bch objCST: ' + objCST);
        		
				//Crea la lista del tipo  CompetidoresPlataformas__c
				List<CompetidoresPlataformas__c> lstCompPlat = new List<CompetidoresPlataformas__c>();
				
				//Recorre la lista de mapST
				for (ServiciosTradicionales__c st : scopeServTrad){
        			//System.debug('EN DCT_ProcesaCompetidores_bch PlataformaServiciosTradicionales__c: ' + objCST.PlataformaServiciosTradicionales__c + ' Plataforma__c: ' + st.Plataforma__c);					
					if(objCST.PlataformaServiciosTradicionales__c == st.Plataforma__c){						
						CompetidoresPlataformas__c objCP = new CompetidoresPlataformas__c();
						objCP.IdExterno__c = newEntity.Name + '-' + st.Id;  
						objCP.ServiciosTradicionales__c = st.Id;
						objCP.Name = newEntity.Name;
						objCP.DCTCompetitors__c = newEntity.id;
						lstCompPlat.add(objCP);
        				//System.debug('EN DCT_ProcesaCompetidores_bch objCP: ' + objCP);						
					}//Fin si objCST.PlataformaServiciosTradicionales__c == st.Plataforma__c
				}//Fin del for para mapST.Values()
				
				//Ve si tiene algo para agregar la lista de lstCompPlat
				System.debug('EN DCT_CompetitorsTriggerHandler.afterInsert lstCompPlat: ' + lstCompPlat);
				if (!lstCompPlat.isEmpty())
					List<Database.Upsertresult> lObjDtsv = Database.upsert(lstCompPlat, CompetidoresPlataformas__c.IdExterno__c, true);
					
			}//Fin del for para mapServTradPadres.Values()
			
		}//Fin del for para newList
        
    }

    //Finish
    global void finish(Database.BatchableContext BC){
        System.debug('EN DCT_ProcesaCompetidores_bch.finish Hora: ' + DateTime.now());      
    }

}