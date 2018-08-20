@isTest
public class DCT_CreaObjetosTest_tst {

	public static DateTime dFechaPruebaPrueba = DateTime.now();
	public static String sNamePrueba = 'UserPrueba' + dFechaPruebaPrueba;
	public static String sLastNamePrueba = 'ApellidoPrueba' + dFechaPruebaPrueba.millisecondGmt();
	
    //Genera los objetos para User 
    public static List<User > CreaUsuario(Integer noUser, String sNomPerf){
    	System.debug('EN DCT_CreaObjetosTest_tst.CreaUsuario CreaUsuario: ' + noUser + ' sNomPerf: ' + sNomPerf);
    	
        //La lista para los User 
        List<User > lUser = new List<User>();
        
        //Busca al un usuario con el perfil seleccionado
		for (User usrDatos : [Select u.UserRole.Name, u.UserRoleId, u.Profile.Name, u.ProfileId, ManagerId 
			From User u where Profile.Name =: sNomPerf And ManagerId != null And isActive = true Limit 1]){
			lUser.add(usrDatos);
		}
                        
    	System.debug('EN DCT_CreaObjetosTest_tst.CreaUsuario lUser: ' + lUser);                        
        //Regresa la lista de Tarea
        return lUser;
    }
      	    
    //Genera los objetos para Account 
    public static List<Account> CreaClienteC(Integer noCliente, String strRT, String sIdUsrOwner){      

        //La lista para los Cliente 
        List<Account> lCliente = new List<Account>();
                
        //Crea los Account 
        for (Integer cnt=0; cnt < noCliente; cnt++){
        	
            String sClaveDistPaso = String.valueOf(Math.random());
            String sClaveDist = sClaveDistPaso.substring(10);
            String sNumeroCte = sClaveDistPaso.substring(10);

            Account Cliente = new Account();
            Cliente.AccountNumber = sNumeroCte;
            Cliente.RecordTypeId = strRT;
			Cliente.Name = sNamePrueba + ' ' + sLastNamePrueba;
			Cliente.DTC_LegalEntity__c = 'Física';
			Cliente.RFC__c = 'ABCD123456EFI';
			Cliente.DCTLastName__c = 'Pruebas';
			Cliente.DCTMotherLastName__c = 'Ejemplo';
			Cliente.DCTName__c = 'Test';
			Cliente.Segmento__c = 'Corporativo';
			Cliente.DCT_TypeOfProcedure__c = 'Lineas Nuevas';
			Cliente.Sector__c = 'Financiero';
			Cliente.Subsector__c = 'Afores';
			Cliente.OwnerId = sIdUsrOwner;
			Cliente.DCTDateLastassignment__c = Date.today();
			Cliente.DCTFolio__c = sNumeroCte;
			
            //Insertalo en Cliente
            lCliente.add(Cliente);
        }
        
        //Inserta los registros 
        insert lCliente;

        //Regresa la lista de lCliente  
        return lCliente;            
        
    }

    //Genera los objetos para Task 
    public static List<Task > CreaTarea(Integer noTarea, String sIdObj, String sSubject){
        //La lista para los Task 
        List<Task > lTarea = new List<Task>();
                
        //Crea los Task 
        for (Integer cnt=0; cnt < noTarea; cnt++){
            Task Tarea = new Task();            
            Tarea.Description = 'Call';
            Tarea.Priority = 'Normal';
            Tarea.Status = 'No Iniciado';
            Tarea.Subject = sSubject;
            Tarea.IsReminderSet = false;
            Tarea.WhatId = sIdObj;
              
            //Insertalo en lTarea
            lTarea.add(Tarea);
        }//Fin del for para los noTarea
        
        //Inserta los registros 
        insert lTarea;
        
        //Regresa la lista de Tarea
        return lTarea;
    }

    //Genera los objetos para Event 
    public static List<Event > CreaEvento(Integer noEvento, String sIdObj, String sIdContLead){
        //La lista para los Event 
        List<Event > lEvento = new List<Event>();
                
        //Crea los Event 
        for (Integer cnt=0; cnt < noEvento; cnt++){
            Event Evento = new Event();
                        
            Evento.WhoId = sIdContLead;
            Evento.WhatId = sIdObj;
            Evento.Type = 'PCT';
            Evento.ActivityDateTime = DateTime.now();
            Evento.ActivityDate = Date.today();
            Evento.DurationInMinutes = 15;
              
            //Insertalo en lEvento
            lEvento.add(Evento);
        }//Fin del for para los noEvento
        
        //Inserta los registros 
        insert lEvento;
        
        //Regresa la lista de Evento
        return lEvento;
    }

    //Genera los objetos para ControlAlarmas__c 
    public static List<ControlAlarmas__c > CreaControlAlarmas(Integer noControlAlarmas, String sIdObj){
    		
        //La lista para los ControlAlarmas__c 
        List<ControlAlarmas__c > lControlAlarmas = new List<ControlAlarmas__c>();
                
        //Crea los ControlAlarmas__c 
        for (Integer cnt=0; cnt < noControlAlarmas; cnt++){
            ControlAlarmas__c ControlAlarmas = new ControlAlarmas__c();
                                    
            ControlAlarmas.Estatus__c = 'Activa';
            ControlAlarmas.Motivo__c = 'Facturación';
            ControlAlarmas.tipoalarma__c = 'Alarma de Campo';
            ControlAlarmas.objeto__c = 'PCT';
            ControlAlarmas.Posicion__c = '1';
            ControlAlarmas.Descripcion__c = 'Se prende por la ausencia de información en el campo.';
            ControlAlarmas.Cuenta__c = sIdObj;
              
            //Insertalo en lControlAlarmas
            lControlAlarmas.add(ControlAlarmas);
        }//Fin del for para los noControlAlarmas
        
        //Inserta los registros 
        insert lControlAlarmas;
        
        //Regresa la lista de ControlAlarmas
        return lControlAlarmas;
    }

    //Genera los objetos para Opportunity 
    public static List<Opportunity > CreaEmbudos(Integer noEmbudos, String sIdObj, String sEtapa,
    	String sOwnerId, String sIdRt){
    		
        //La lista para los Opportunity 
        List<Opportunity > lEmbudos = new List<Opportunity>();
                
        //Crea los Opportunity 
        for (Integer cnt=0; cnt < noEmbudos; cnt++){
            Opportunity Embudo = new Opportunity();
                                    
            Embudo.closeDate = Date.today();
            Embudo.AccountId = sIdObj;
            Embudo.stageName = sEtapa;
            Embudo.Name = 'OP GLOBAL - ' + cnt;
            Embudo.TipoPlataforma__c = 'Datos';
            Embudo.Plataforma__c = 'Comunicación';
            Embudo.Description = 'Description';
            Embudo.OwnerId = sOwnerId;
            Embudo.embudoGlobal__c = true;
            Embudo.RecordTypeId = sIdRt;
              
            //Insertalo en lEmbudos
            lEmbudos.add(Embudo);
        }//Fin del for para los noEmbudos
        
        //Inserta los registros 
        insert lEmbudos;
        
        //Regresa la lista de Embudos
        return lEmbudos;
    }

    //Genera los objetos para Contact 
    public static List<Contact > CreaContacto(Integer noContacto, String sIdAccount){

		String sClaveDistPaso = String.valueOf(Math.random());
		String sClaveDist = sClaveDistPaso.substring(10);
		String sNumeroFactura = sClaveDistPaso.substring(10);
    	
        //La lista para los Contact 
        List<Contact > lContacto = new List<Contact>();
                
        //Crea los Contact 
        for (Integer cnt=0; cnt < noContacto; cnt++){
            Contact Contacto = new Contact();
                           
            Contacto.PCT_IdExterno__c = sNumeroFactura;            
	    	Contacto.FirstName = sNamePrueba;
	    	Contacto.LastName = sLastNamePrueba;
            Contacto.AccountId = sIdAccount;                      
            Contacto.Posicion__c = 'GERENTE';
            Contacto.Phone = '1234567890';
            Contacto.Nivel__c = 'CONTACTO 1';
            Contacto.MobilePhone = '1234567890';
            Contacto.Email = 'prueba' + sClaveDist + '@hotmail.com';            
            Contacto.DCT_ContactoDirectorio__c = true;
            Contacto.DCTTypeContact__c = 'PRINCIPAL';            
            Contacto.DCTReceiveInformation__c = false;            
            Contacto.DCTNIP__c = sNumeroFactura;            
            Contacto.DCTExtension__c = '12345';
 
            //Insertalo en lContacto
            lContacto.add(Contacto);
        }//Fin del for para los noContacto
        
        //Inserta los registros 
        upsert lContacto PCT_IdExterno__c;
        
        //Regresa la lista de Contacto
        return lContacto;
    }

    //Genera los objetos para Cliente__c 
    public static List<Cliente__c> CreaDirCom(Integer noDirCom, String sIdUsrOwner, Account PCT){
    	
        //La lista para los Cliente__c 
        List<Cliente__c> lDirCom = new List<Cliente__c>();
                
        //Crea los Cliente__c 
        for (Integer cnt=0; cnt < noDirCom; cnt++){
            Cliente__c DirCom = new Cliente__c();
            
			DirCom.Name = sNamePrueba;
			DirCom.OwnerId = sIdUsrOwner;
			//Se agrega el RFc a la creacion de directorio comercial
			DirCom.RFC1__c = PCT.RFC__c;
			DirCom.OwnerId = PCT.OwnerId;
			DirCom.DCTFolio__c = PCT.DCTFolio__c;
            DirCom.DCTCustomerFrom__c = Date.today().addDays(-50);
			DirCom.Cliente__c = PCT != NULL ? PCT.Id : NULL;
						                       
            //Insertalo en lDirCom
            lDirCom.add(DirCom);
        }//Fin del for para los noDirCom
        
        //Inserta los registros 
        insert lDirCom;
        
        //Regresa la lista de DirCom
        return lDirCom;
    }

    //Genera los objetos para MapaCliente__c 
    public static List<MapaCliente__c> CreaMapaCliente(Integer noMapaCliente, String sIdPlanCte, 
    	String sIdRtg){
    	
        //La lista para los MapaCliente__c 
        List<MapaCliente__c> lMapaCliente = new List<MapaCliente__c>();
                
        //Crea los MapaCliente__c 
        for (Integer cnt=0; cnt < noMapaCliente; cnt++){
            MapaCliente__c MapaCliente = new MapaCliente__c();
            
			MapaCliente.PlanCliente__c = sIdPlanCte;
			MapaCliente.RecordTypeId = sIdRtg;
            						                        
            //Insertalo en lMapaCliente
            lMapaCliente.add(MapaCliente);
        }//Fin del for para los noMapaCliente
        
        //Inserta los registros 
        insert lMapaCliente;
        
        //Regresa la lista de MapaCliente
        return lMapaCliente;
    }

    //Genera los objetos para SeguimientoOportunidades__c 
    public static List<SeguimientoOportunidades__c> CreaSegOpp(Integer noSegOpp, String sIdCliente, 
    	String sIdMapaCte, String sIdEmbudo, String sIdRtg){
    	
        //La lista para los SeguimientoOportunidades__c 
        List<SeguimientoOportunidades__c> lSegOpp = new List<SeguimientoOportunidades__c>();
                
        //Crea los SeguimientoOportunidades__c 
        for (Integer cnt=0; cnt < noSegOpp; cnt++){
            SeguimientoOportunidades__c SegOpp = new SeguimientoOportunidades__c();
            
			SegOpp.PlanCliente__c = sIdCliente;
			SegOpp.MapaCliente__c = sIdMapaCte;
			SegOpp.RecordTypeId = sIdRtg;
			SegOpp.Name = sNamePrueba;
            SegOpp.Embudo__c = sIdEmbudo;
            						                        
            //Insertalo en lSegOpp
            lSegOpp.add(SegOpp);
        }//Fin del for para los noSegOpp
        
        //Inserta los registros 
        insert lSegOpp;
        
        //Regresa la lista de SegOpp
        return lSegOpp;
    }

    //Genera los objetos para DCTDedicatedLinks__c 
    public static List<DCTDedicatedLinks__c> CreaDCTDedicatedLinks(Integer noDCTDedicatedLinks,
    	String sIdDirCom){
    	
        //La lista para los DCTDedicatedLinks__c 
        List<DCTDedicatedLinks__c> lDCTDedicatedLinks = new List<DCTDedicatedLinks__c>();
                
        //Crea los DCTDedicatedLinks__c 
        for (Integer cnt=0; cnt < noDCTDedicatedLinks; cnt++){
        	
            String sClaveDistPaso = String.valueOf(Math.random());
            String sClaveDist = sClaveDistPaso.substring(10);
        	
            DCTDedicatedLinks__c DCTDedicatedLinks = new DCTDedicatedLinks__c();
            
			DCTDedicatedLinks.Name = sNamePrueba;							
			DCTDedicatedLinks.KeyCode__c = sClaveDist;
			DCTDedicatedLinks.DCTRegistrerDate__c = Date.today();
			DCTDedicatedLinks.ClientName__c = sIdDirCom;

            //Insertalo en lDCTDedicatedLinks
            lDCTDedicatedLinks.add(DCTDedicatedLinks);
        }//Fin del for para los noDCTDedicatedLinks
        
        //Inserta los registros 
        insert lDCTDedicatedLinks;
        
        //Regresa la lista de DCTDedicatedLinks
        return lDCTDedicatedLinks;
    }

    //Genera los objetos para HistoryMovement__c 
    public static List<HistoryMovement__c> CreaHistoryMovement(Integer noHistoryMovement,
    	String sIdDirCom){
    	
        //La lista para los HistoryMovement__c 
        List<HistoryMovement__c> lHistoryMovement = new List<HistoryMovement__c>();
                
        //Crea los HistoryMovement__c 
        for (Integer cnt=0; cnt < noHistoryMovement; cnt++){
            HistoryMovement__c HistoryMovement = new HistoryMovement__c();
            
			HistoryMovement.Name = sNamePrueba;
			HistoryMovement.Directorio_Comercial__c = sIdDirCom;

            //Insertalo en lHistoryMovement
            lHistoryMovement.add(HistoryMovement);
        }//Fin del for para los noHistoryMovement
        
        //Inserta los registros 
        insert lHistoryMovement;
        
        //Regresa la lista de HistoryMovement
        return lHistoryMovement;
    }

    //Genera los objetos para Competencia__c 
    public static List<Competencia__c> CreaCompetencia(Integer noCompetencia, String sIdCliente,
    	String sIdContact){
    	
        //La lista para los Competencia__c 
        List<Competencia__c> lCompetencia = new List<Competencia__c>();
                
        //Crea los Competencia__c 
        for (Integer cnt=0; cnt < noCompetencia; cnt++){
            Competencia__c Competencia = new Competencia__c();
            
			Competencia.Name = sNamePrueba;							
			Competencia.PlanCliente__c = sIdCliente;
			Competencia.ApoyoenCliente__c = sIdContact;			
			Competencia.Estatus__c = 'Activo';

			//elect c.VentajaCompetitiva__c, c., c., c., c.Debilidad__c, c.Crear__c, c., c.ApoyoCliente__c From Competencia__c c

            //Insertalo en lCompetencia
            lCompetencia.add(Competencia);
        }//Fin del for para los noCompetencia
        
        //Inserta los registros 
        insert lCompetencia;
        
        //Regresa la lista de Competencia
        return lCompetencia;
    }
    
    //Genera los objetos para ServiciosTradicionales__c 
    public static List<ServiciosTradicionales__c> CreaServTradic(Integer noServTradic, String sIdMapaCte){
    	
        //La lista para los ServiciosTradicionales__c 
        List<ServiciosTradicionales__c> lServTradic = new List<ServiciosTradicionales__c>();
                
        //Crea los ServiciosTradicionales__c 
        for (Integer cnt=0; cnt < noServTradic; cnt++){
            ServiciosTradicionales__c ServTradic = new ServiciosTradicionales__c();
            
            ServTradic.Plataforma__c = 'Voz/Datos';
			ServTradic.MapaCliente__c = sIdMapaCte;
			
            //Insertalo en lServTradic
            lServTradic.add(ServTradic);
        }//Fin del for para los noServTradic
        
        //Inserta los registros 
        insert lServTradic;
        
        //Regresa la lista de ServTradic
        return lServTradic;
    }    

    //Genera los objetos para CompetidoresPlataformas__c 
    public static List<CompetidoresPlataformas__c> CreaCompPlataf(Integer noCompPlataf, String sIdCliente,
    	String sIdServTrad){
    	
        //La lista para los CompetidoresPlataformas__c 
        List<CompetidoresPlataformas__c> lCompPlataf = new List<CompetidoresPlataformas__c>();
                
        //Crea los CompetidoresPlataformas__c 
        for (Integer cnt=0; cnt < noCompPlataf; cnt++){
            CompetidoresPlataformas__c CompPlataf = new CompetidoresPlataformas__c();
            
            CompPlataf.Name = sNamePrueba;
			CompPlataf.LineasCompetidor__c = 5;
			CompPlataf.ServiciosTradicionales__c = sIdServTrad;
			CompPlataf.PCTCompetidores__c = sIdCliente;
			
            //Insertalo en lCompPlataf
            lCompPlataf.add(CompPlataf);
        }//Fin del for para los noCompPlataf
        
        //Inserta los registros 
        insert lCompPlataf;
        
        //Regresa la lista de CompPlataf
        return lCompPlataf;
    }    

    //Genera los objetos para AnalisisRelaciones__c 
    public static List<AnalisisRelaciones__c> CreaAnalisisRelaciones(Integer noAnalisisRelaciones, String sIdCliente,
    	String sIdMapaCte){
    	
        //La lista para los AnalisisRelaciones__c 
        List<AnalisisRelaciones__c> lAnalisisRelaciones = new List<AnalisisRelaciones__c>();
                
        //Crea los AnalisisRelaciones__c 
        for (Integer cnt=0; cnt < noAnalisisRelaciones; cnt++){

			String sClaveDistPaso = String.valueOf(Math.random());
			String sClaveDist = sClaveDistPaso.substring(10);
        	
            AnalisisRelaciones__c AnalisisRelaciones = new AnalisisRelaciones__c();
                        
            AnalisisRelaciones.PlanCliente__c = sIdCliente;
            AnalisisRelaciones.MapaCliente__c = sIdMapaCte;
			AnalisisRelaciones.AnalisisRelacionesLlave__c = sClaveDist;
			
            //Insertalo en lAnalisisRelaciones
            lAnalisisRelaciones.add(AnalisisRelaciones);
        }//Fin del for para los noAnalisisRelaciones
        
        //Inserta los registros 
        insert lAnalisisRelaciones;
        
        //Regresa la lista de AnalisisRelaciones
        return lAnalisisRelaciones;
    }

    //Genera los objetos para ConocimientoMercado__c 
    public static List<ConocimientoMercado__c> CreaConocimientoMercado(Integer noConocimientoMercado, 
    	String sIdCliente){
    	
        //La lista para los ConocimientoMercado__c 
        List<ConocimientoMercado__c> lConocimientoMercado = new List<ConocimientoMercado__c>();
                
        //Crea los ConocimientoMercado__c 
        for (Integer cnt=0; cnt < noConocimientoMercado; cnt++){

			String sClaveDistPaso = String.valueOf(Math.random());
			String sClaveDist = sClaveDistPaso.substring(10);
        	
            ConocimientoMercado__c ConocimientoMercado = new ConocimientoMercado__c();
                        
            ConocimientoMercado.Name = sNamePrueba;
            ConocimientoMercado.PlanCliente__c = sIdCliente;
			ConocimientoMercado.Presencia__c = 'Presencia';
			ConocimientoMercado.Cuota__c = 10;
			
            //Insertalo en lConocimientoMercado
            lConocimientoMercado.add(ConocimientoMercado);
        }//Fin del for para los noConocimientoMercado
        
        //Inserta los registros 
        insert lConocimientoMercado;
        
        //Regresa la lista de ConocimientoMercado
        return lConocimientoMercado;
    }

    //Genera los objetos para DCTAssignment__c 
    public static List<DCTAssignment__c> CreaAssignment(Integer noAssignment){
    	
        //La lista para los DCTAssignment__c 
        List<DCTAssignment__c> lAssignment = new List<DCTAssignment__c>();
                
        //Crea los DCTAssignment__c 
        for (Integer cnt=0; cnt < noAssignment; cnt++){
            DCTAssignment__c Assignment = new DCTAssignment__c();
            
			Assignment.Status__c = 'Pendiente';							
			Assignment.TypeAssignment__c = 'Gerencia';
			Assignment.PreviousManagement__c = UserInfo.getUserId();
			Assignment.Aprobador__c = UserInfo.getUserId();
			Assignment.Segment__c = 'Corporativo';

            //Insertalo en lAssignment
            lAssignment.add(Assignment);
        }//Fin del for para los noAssignment
        
        //Inserta los registros 
        insert lAssignment;
        
        //Regresa la lista de Assignment
        return lAssignment;
    }

    //Genera los objetos para DCTClientsProspectstoAssigned__c 
    public static List<DCTClientsProspectstoAssigned__c> CreaDCTClientsProspectstoAssigned(Integer noDCTClientsProspectstoAssigned,
    	String sIdCtaReasig, String sIdDctAssign, String sEstatus, String sIdUsrRecep, String sIdUsrEmisor){
    	
        //La lista para los DCTClientsProspectstoAssigned__c 
        List<DCTClientsProspectstoAssigned__c> lDCTClientsProspectstoAssigned = new List<DCTClientsProspectstoAssigned__c>();
                
        //Crea los DCTClientsProspectstoAssigned__c 
        for (Integer cnt=0; cnt < noDCTClientsProspectstoAssigned; cnt++){
            DCTClientsProspectstoAssigned__c DCTClientsProspectstoAssigned = new DCTClientsProspectstoAssigned__c();
            
			DCTClientsProspectstoAssigned.AccountName__c = sIdCtaReasig;           
			DCTClientsProspectstoAssigned.AssignmentNumber__c = sIdDctAssign;           
			DCTClientsProspectstoAssigned.Name = 'Cuenta para reasignacion-' + cnt;							
			DCTClientsProspectstoAssigned.Status__c = sEstatus;
			DCTClientsProspectstoAssigned.UserReceiver__c = sIdUsrRecep;
			DCTClientsProspectstoAssigned.IssuingUser__c = sIdUsrEmisor;
			DCTClientsProspectstoAssigned.Segmento__c = 'Corporativo';			

            //Insertalo en lDCTClientsProspectstoAssigned
            lDCTClientsProspectstoAssigned.add(DCTClientsProspectstoAssigned);
        }//Fin del for para los noDCTClientsProspectstoAssigned
        
        //Inserta los registros 
        insert lDCTClientsProspectstoAssigned;
        
        //Regresa la lista de DCTClientsProspectstoAssigned
        return lDCTClientsProspectstoAssigned;
    }

    //Genera los objetos para Case 
    public static List<Case> CreaOppVta(Integer noOppVta, String iIdCte){
        //La lista para los Case 
        List<Case> lOppVta = new List<Case>();
                
        //Crea los Case 
        for (Integer cnt=0; cnt < noOppVta; cnt++){
            Case OppVta = new Case();
            
            OppVta.Status = 'New';
            OppVta.Origin = 'Phone'; 
            OppVta.Priority = 'Medium';
            OppVta.AccountId = iIdCte != null ? iIdCte : null;
            
            //Insertalo en lOppVta
            lOppVta.add(OppVta);
        }//Fin del for para los noOppVta
        
        //Inserta los registros 
        insert lOppVta;
        
        //Regresa la lista de OppVta
        return lOppVta;
    }

    //Genera los objetos para DCTAuthorizedLines__c 
    public static List<DCTAuthorizedLines__c > CreaDCTAuthorizedLines(Integer noDCTAuthorizedLines, 
    	String sIdDirCom, String sRecordType, String sTermino, String sAprobador){

		String sClaveDistPaso = String.valueOf(Math.random());
		String sClaveDist = sClaveDistPaso.substring(10);
		String sNumeroFactura = sClaveDistPaso.substring(10);
    		
        //La lista para los DCTAuthorizedLines__c 
        List<DCTAuthorizedLines__c > lDCTAuthorizedLines = new List<DCTAuthorizedLines__c>();
                
        //Crea los DCTAuthorizedLines__c 
        for (Integer cnt=0; cnt < noDCTAuthorizedLines; cnt++){
            DCTAuthorizedLines__c DCTAuthorizedLines = new DCTAuthorizedLines__c();            

			DCTAuthorizedLines.Name = sNamePrueba;
			DCTAuthorizedLines.Clave__c = sClaveDist;            
	 		DCTAuthorizedLines.CommercialDirectory__c = sIdDirCom;
	 		DCTAuthorizedLines.RecordTypeId = sRecordType;
			DCTAuthorizedLines.DCTTerm__c = sTermino;
			DCTAuthorizedLines.Aprobador__c = sAprobador;
			DCTAuthorizedLines.Status__c = 'AUTORIZADO';
              
            //Insertalo en lDCTAuthorizedLines
            lDCTAuthorizedLines.add(DCTAuthorizedLines);
            
        }//Fin del for para los noDCTAuthorizedLines
        
        //Inserta los registros 
        insert lDCTAuthorizedLines;
        
        //Regresa la lista de DCTAuthorizedLines
        return lDCTAuthorizedLines;
    }

    public static List<DCTPlan__c > CreaPlanes(Integer noPlanes){
    		
        //La lista para los DCTPlan__c 
        List<DCTPlan__c > lPlanes = new List<DCTPlan__c>();
                
        //Crea los DCTPlan__c 
        for (Integer cnt=0; cnt < noPlanes; cnt++){
            DCTPlan__c Planes = new DCTPlan__c();            

			Planes.Name = sNamePrueba;			            
	        Planes.DCTCode__c = '12'; //Ve si contiene un - y entonces quita los meses nada mas
	        Planes.DCTTerm__c = '12 MESES';
	        Planes.TipoMercado__c = 'CORPORAT';
			Planes.ClaveMercado__c = '2';
	        Planes.ClaveGrupoPlan__c = '123';
	        Planes.DescripcionGrupoPlan__c = 'GRUPO PLAN';
	        Planes.ClavePlazo__c = '12';
	        Planes.DescripcionPlazo__c = '12 MESES';
	        Planes.ClavePlan__c = '123';
	        Planes.DescripcionPlan__c = 'PLAN';
	        Planes.ClaveTarifa__c = 'AAA'; 
              
            //Insertalo en lPlanes
            lPlanes.add(Planes);
            
        }//Fin del for para los noPlanes
        
        //Inserta los registros 
        insert lPlanes;
        
        //Regresa la lista de Planes
        return lPlanes;
    }

    //Genera los objetos para Product2 
    public static List<Product2> CreaProducto(Integer noProducto, String sRt){
    	
        //La lista para los Product2 
        List<Product2> lProducto = new List<Product2>();
                
        //Crea los Product2 
        for (Integer cnt=0; cnt < noProducto; cnt++){

			String sClaveDistPaso = String.valueOf(Math.random());
			String sClaveDist = sClaveDistPaso.substring(10);
        	
            Product2 Producto = new Product2();
            
            Producto.Name = sNamePrueba;
            Producto.RecordTypeId = sRt; 
            Producto.Family = 'Family';
            Producto.Description = 'Family';
            Producto.DCT_IsSpecialProduct__c = false;
            Producto.DCTKey__c = sClaveDist;
            Producto.IsActive = true;
            
            //Insertalo en lProducto
            lProducto.add(Producto);
        }//Fin del for para los noProducto
        
        //Inserta los registros 
        insert lProducto;
        
        //Regresa la lista de Producto
        return lProducto;
    }    

    //Genera los objetos para DCTDirectoryProductRelationship__c 
    public static List<DCTDirectoryProductRelationship__c> CreaDCTDirectoryProductRel(Integer noDCTDirectoryProductRel, 
    	String sIdProd, String sIdDirCom){

		String sClaveDistPaso = String.valueOf(Math.random());
		String sClaveDist = sClaveDistPaso.substring(10);
		String sNumeroFactura = sClaveDistPaso.substring(10);
    	
        //La lista para los DCTDirectoryProductRelationship__c 
        List<DCTDirectoryProductRelationship__c> lDCTDirectoryProductRel = new List<DCTDirectoryProductRelationship__c>();
                
        //Crea los DCTDirectoryProductRelationship__c 
        for (Integer cnt=0; cnt < noDCTDirectoryProductRel; cnt++){
            DCTDirectoryProductRelationship__c DCTDirectoryProductRel = new DCTDirectoryProductRelationship__c();
            
            DCTDirectoryProductRel.DCTProduct__c = sIdProd; 
            DCTDirectoryProductRel.DCTCommercialDirectory__c = sIdDirCom;
            
            //Insertalo en lDCTDirectoryProductRel
            lDCTDirectoryProductRel.add(DCTDirectoryProductRel);
        }//Fin del for para los noDCTDirectoryProductRel
        
        //Inserta los registros 
        insert lDCTDirectoryProductRel;
        
        //Regresa la lista de DCTDirectoryProductRel
        return lDCTDirectoryProductRel;
    }

    //Genera los objetos para DirectorioProducosSeleccionados__c 
    public static List<DirectorioProducosSeleccionados__c> CreaDirectorioProducosSel(Integer noDirectorioProducosSel, 
    	String sIdProd, String sIdDirCom){
    	
        //La lista para los DirectorioProducosSeleccionados__c 
        List<DirectorioProducosSeleccionados__c> lDirectorioProducosSel = new List<DirectorioProducosSeleccionados__c>();
                
        //Crea los DirectorioProducosSeleccionados__c 
        for (Integer cnt=0; cnt < noDirectorioProducosSel; cnt++){
            DirectorioProducosSeleccionados__c DirectorioProducosSel = new DirectorioProducosSeleccionados__c();
            
            DirectorioProducosSel.Name = sNamePrueba;            
            DirectorioProducosSel.Producto__c = sIdProd; 
            DirectorioProducosSel.Prospecto__c = sIdDirCom;
            
            //Insertalo en lDirectorioProducosSel
            lDirectorioProducosSel.add(DirectorioProducosSel);
        }//Fin del for para los noDirectorioProducosSel
        
        //Inserta los registros 
        insert lDirectorioProducosSel;
        
        //Regresa la lista de DirectorioProducosSel
        return lDirectorioProducosSel;
    }

    //Genera los objetos para DCTSalesForceCatalog__c 
    public static List<DCTSalesForceCatalog__c> CreaDCTSalesForceCatalog(Integer noDCTSalesForceCatalog, 
    	String sNombre, String sClave, String sPrepId){
    	
        //La lista para los DCTSalesForceCatalog__c 
        List<DCTSalesForceCatalog__c> lDCTSalesForceCatalog = new List<DCTSalesForceCatalog__c>();
                
        //Crea los DCTSalesForceCatalog__c 
        for (Integer cnt=0; cnt < noDCTSalesForceCatalog; cnt++){
            DCTSalesForceCatalog__c DCTSalesForceCatalog = new DCTSalesForceCatalog__c();
            
            DCTSalesForceCatalog.Name = sClave;
            DCTSalesForceCatalog.DCT_RazonSocial__c = sNombre; 
            DCTSalesForceCatalog.DCT_PrepagoSiapID__c = sPrepId + '' + cnt;
            DCTSalesForceCatalog.DCT_EstatusID__c = '1';
            DCTSalesForceCatalog.DCTCode__c = sClave + '' + cnt;
            
            //Insertalo en lDCTSalesForceCatalog
            lDCTSalesForceCatalog.add(DCTSalesForceCatalog);
        }//Fin del for para los noDCTSalesForceCatalog
        
        //Inserta los registros 
        insert lDCTSalesForceCatalog;
        
        //Regresa la lista de DCTSalesForceCatalog
        return lDCTSalesForceCatalog;
    }    

    //Genera los objetos para DCTRegion__c 
    public static List<DCTRegion__c> CreaDCTRegion(Integer noDCTRegion, 
    	String sNombre, String sRFC){
    	System.debug('EN DCT_CreaObjetosTest_tst.CreaDCTRegion sNombre: ' + sNombre + ' sRFC: ' + sRFC);

        //La lista para los DCTRegion__c 
        List<DCTRegion__c> lDCTRegion = new List<DCTRegion__c>();
                
        //Crea los DCTRegion__c 
        for (Integer cnt=0; cnt < noDCTRegion; cnt++){
            DCTRegion__c DCTRegion = new DCTRegion__c();
            
            DCTRegion.Name = sNombre; //'ANTO SERVICIOS EMPRESARIALES SC';            
            DCTRegion.LegalEntity__c = sNombre; //'ANTO SERVICIOS EMPRESARIALES SC';
            DCTRegion.AccountType__c = 'MG'; 
            DCTRegion.AddressCorrespondence__c = 'CAM 3,A LA B,CA¥ADA CHICA ANTIGUA,ACTOPAN,42500,HGOMEX';
            DCTRegion.TaxResidence__c = 'CAM 3,A LA B,CA¥ADA CHICA ANTIGUA,ACTOPAN,42500,HGOMEX';
            DCTRegion.CreditClass__c = '3E';
            DCTRegion.DCTBillingCycle__c = '63';            
            DCTRegion.EstatusCobranza__c = 'BN';            
            DCTRegion.ExemptBail__c = false;
            DCTRegion.LegalRepresentative__c = 'RODRÍGUEZ CHÁVEZ JOSÉ LUIS';            
            DCTRegion.MethodOfPayment__c = 'EF';            
            DCTRegion.FatherAccount__c = '2867665';            
            DCTRegion.Region__c = 'R09';
            DCTRegion.RFC__c = sRFC; //'ASE1401167H8';
                        
            //Insertalo en lDCTRegion
            lDCTRegion.add(DCTRegion);
        }//Fin del for para los noDCTRegion
        
        //Inserta los registros 
        insert lDCTRegion;
        
        //Regresa la lista de DCTRegion
        return lDCTRegion;
    }    

    //Genera los objetos para DCTRegionVal__c 
    public static List<DCTRegionVal__c> CreaDCTRegionVal(Integer noDCTRegionVal, 
    	String sNombre, String sRFC){
    	System.debug('EN DCT_CreaObjetosTest_tst.CreaDCTRegionVal sNombre: ' + sNombre + ' sRFC: ' + sRFC);

        //La lista para los DCTRegionVal__c 
        List<DCTRegionVal__c> lDCTRegionVal = new List<DCTRegionVal__c>();
                
        //Crea los DCTRegionVal__c 
        for (Integer cnt=0; cnt < noDCTRegionVal; cnt++){
            DCTRegionVal__c DCTRegionVal = new DCTRegionVal__c();
                        
            DCTRegionVal.LegalEntity__c = sNombre; //'ANTO SERVICIOS EMPRESARIALES SC';
            DCTRegionVal.AccountType__c = 'MG'; 
            DCTRegionVal.AddressCorrespondence__c = 'CAM 3,A LA B,CA¥ADA CHICA ANTIGUA,ACTOPAN,42500,HGOMEX';
            DCTRegionVal.TaxResidence__c = 'CAM 3,A LA B,CA¥ADA CHICA ANTIGUA,ACTOPAN,42500,HGOMEX';
            DCTRegionVal.CreditClass__c = '3E';
            DCTRegionVal.DCTBillingCycle__c = '63';            
            DCTRegionVal.EstatusCobranza__c = 'BN';            
            DCTRegionVal.ExemptBail__c = '0';
            DCTRegionVal.LegalRepresentative__c = 'RODRÍGUEZ CHÁVEZ JOSÉ LUIS';            
            DCTRegionVal.MethodOfPayment__c = 'EF';            
            DCTRegionVal.FatherAccount__c = '2867665';            
            DCTRegionVal.Region__c = 'R09';
            DCTRegionVal.RFC__c = sRFC; //'ASE1401167H8';
                        
            //Insertalo en lDCTRegionVal
            lDCTRegionVal.add(DCTRegionVal);
        }//Fin del for para los noDCTRegionVal
        
        //Inserta los registros 
        insert lDCTRegionVal;
        
        //Regresa la lista de DCTRegionVal
        return lDCTRegionVal;
    }

    //Genera los objetos para DCTClienteUnicoPaso__c 
    public static List<DCTClienteUnicoPaso__c> CreaDCTClienteUnicoPaso(Integer noDCTClienteUnicoPaso, 
    	String sNombre, String sRFC){
    	System.debug('EN DCT_CreaObjetosTest_tst.CreaDCTClienteUnicoPaso sNombre: ' + sNombre + ' sRFC: ' + sRFC);

        //La lista para los DCTClienteUnicoPaso__c 
        List<DCTClienteUnicoPaso__c> lDCTClienteUnicoPaso = new List<DCTClienteUnicoPaso__c>();
                
        //Crea los DCTClienteUnicoPaso__c 
        for (Integer cnt=0; cnt < noDCTClienteUnicoPaso; cnt++){
            DCTClienteUnicoPaso__c DCTClienteUnicoPaso = new DCTClienteUnicoPaso__c();
                        
            DCTClienteUnicoPaso.Name = sNombre; //'ANTO SERVICIOS EMPRESARIALES SC';
            DCTClienteUnicoPaso.DCT_RFC__c = sRFC; 
            DCTClienteUnicoPaso.DCT_FechaRegistro__c = Date.today();
                        
            //Insertalo en lDCTClienteUnicoPaso
            lDCTClienteUnicoPaso.add(DCTClienteUnicoPaso);
        }//Fin del for para los noDCTClienteUnicoPaso
        
        //Inserta los registros 
        insert lDCTClienteUnicoPaso;
        
        //Regresa la lista de DCTClienteUnicoPaso
        return lDCTClienteUnicoPaso;
    }

    
}