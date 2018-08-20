/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an organization are executed whenever Apex code is deployed
 * to a production organization to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production organization. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the organization size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
private class DCT_AssignmentMethods_tst {

	public static String VaRtAccountCorpo = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Plan Cliente Telcel Corporativo').getRecordTypeId();
	public static String VaRtAccountEmpre = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Plan Cliente Telcel Empresarial').getRecordTypeId();  
	public static String VaRtAccountPyme = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Plan Cliente Telcel PyME').getRecordTypeId();
	public static String sRtPlan = Schema.SObjectType.DCTAuthorizedLines__c.getRecordTypeInfosByName().get('Plan').getRecordTypeId();
    public static String sRecdType = Schema.SObjectType.DCTAuthorizedLines__c.getRecordTypeInfosByName().get('Lineas Autorizadas').getRecordTypeId();
    public static String sRecdTypeEmbudoCO = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Corporativo Oportunidad').getRecordTypeId();

    public static String sRecdTypeMapaClienteCorp = Schema.SObjectType.MapaCliente__c.getRecordTypeInfosByName().get('Corporativo').getRecordTypeId();
    public static String sRecdTypeMapaClienteEmpr = Schema.SObjectType.MapaCliente__c.getRecordTypeInfosByName().get('Empresarial').getRecordTypeId();    
    public static String sRecdTypeMapaClientePyme = Schema.SObjectType.MapaCliente__c.getRecordTypeInfosByName().get('PyME').getRecordTypeId();    

    public static String sRecdTypeSegOppCorp = Schema.SObjectType.SeguimientoOportunidades__c.getRecordTypeInfosByName().get('Corporativo').getRecordTypeId();
    public static String sRecdTypeSegOppEmpr = Schema.SObjectType.SeguimientoOportunidades__c.getRecordTypeInfosByName().get('Empresarial').getRecordTypeId();    
    public static String sRecdTypeSegOppPyme = Schema.SObjectType.SeguimientoOportunidades__c.getRecordTypeInfosByName().get('PyME').getRecordTypeId();    

	public static String VaRtAccountProd = Schema.SObjectType.Product2.getRecordTypeInfosByName().get('Productos').getRecordTypeId();
	public static String VaRtAccountServTelCloudEmpre = Schema.SObjectType.Product2.getRecordTypeInfosByName().get('Servicios Telcel Cloud').getRecordTypeId();  
	public static String VaRtAccountSolCobro = Schema.SObjectType.Product2.getRecordTypeInfosByName().get('Soluciones de cobro').getRecordTypeId();
    
	@isTest(seeAllData = true)
    static void DCT_AssignmentMethods_AccountObjRel_OK() {

		Test.startTest();

			List<ID> lIdProcess = new List<ID>();
		    ProcessInstanceWorkitem procesoActual;			
			String sNomPerfUsrJEC = 'JEC';
			String sNomPerfUsrGV = 'GV';
			String sNomPerfUsrCOOR = 'CoordinacionAdministrativa';
			String sNomPerfUsrAdmin = 'Administrador del sistema';			
															
			List<User > lUserAdmin = DCT_CreaObjetosTest_tst.CreaUsuario(1, sNomPerfUsrAdmin);																		
			List<User > lUserGV = DCT_CreaObjetosTest_tst.CreaUsuario(1, sNomPerfUsrGV);

			String sClaveDistPaso = String.valueOf(Math.random());
			String sClaveDist = sClaveDistPaso.substring(12);
			System.debug('EN DCT_ReporteCamposModifDirComercial_tst.DCT_ReporteCamposModifDirComercialBchOK sClaveDist: ' + sClaveDist);
							
			//Crea una clase para los objetos
			List<Account> lCliente = DCT_CreaObjetosTest_tst.CreaClienteC(1, VaRtAccountCorpo, lUserAdmin.get(0).id);
			List<Task > lTarea = DCT_CreaObjetosTest_tst.CreaTarea(1, lCliente.get(0).id, 'Llamada');
			String sIdContLead;
			List<Event > lEvento = DCT_CreaObjetosTest_tst.CreaEvento(1, lCliente.get(0).id, sIdContLead);
			List<ControlAlarmas__c > lControlAlarmas = DCT_CreaObjetosTest_tst.CreaControlAlarmas(1, lCliente.get(0).id);
			List<Opportunity > lEmbudos = DCT_CreaObjetosTest_tst.CreaEmbudos(1, lCliente.get(0).id, 
				'Oportunidad', lCliente.get(0).OwnerId, sRecdTypeEmbudoCO);				
			List<Contact > lContacto = DCT_CreaObjetosTest_tst.CreaContacto(1, lCliente.get(0).id);
			List<Cliente__c> lDirCom = DCT_CreaObjetosTest_tst.CreaDirCom(1, lUserAdmin.get(0).id, lCliente.get(0));
			lDirCom.get(0).Cliente__c = lCliente.get(0).id;
			update lDirCom.get(0);
			List<MapaCliente__c> lMapaCliente = DCT_CreaObjetosTest_tst.CreaMapaCliente(1, 
				lCliente.get(0).id, sRecdTypeMapaClienteCorp);
			List<SeguimientoOportunidades__c> lSegOpp = DCT_CreaObjetosTest_tst.CreaSegOpp(1, 
				lCliente.get(0).id, lMapaCliente.get(0).id, lEmbudos.get(0).id, sRecdTypeSegOppCorp);
						
			//Toma al usuario JEC y has las pruebas con ese
			System.runAs(lUserAdmin.get(0)){
								
				//La el usuario propietario mas la cuenta mas un ;
				String sIdAccIdOwner = lUserAdmin.get(0).id + ':';
				sIdAccIdOwner += lCliente.get(0).id + ',';
				sIdAccIdOwner += ';';
				//La cuenta y el segmento a la que corresponde
				String sIdAccNomSegm = lCliente.get(0).id + ':' + 'Corporativo,'; 
				
				//Llama al metodo ActualizaOwnerAccountObjRel
				DCT_AssignmentMethods_cls.ActualizaOwnerAccountObjRel(sIdAccIdOwner, sIdAccNomSegm);
				
				//Ve si se crearon los objetos para hacer el llamado
    		    System.assertNotEquals(lCliente, null);
    		    System.assertNotEquals(lTarea, null);
    		    System.assertNotEquals(lEvento, null);
    		    System.assertNotEquals(lControlAlarmas, null);    		    
    		    System.assertNotEquals(lEmbudos, null);
    		    System.assertNotEquals(lContacto, null);    		    
    		    System.assertNotEquals(lDirCom, null);
    		    System.assertNotEquals(lMapaCliente, null);    		    
    		    System.assertNotEquals(lSegOpp, null);    		    

			}//Fin si System.runAs(lUserAdmin.get(0))
					
		Test.stopTest();
        
    }

	@isTest(seeAllData = true)
    static void DCT_AssignmentMethods_MapaClienteObjRel_OK() {

		Test.startTest();

			List<ID> lIdProcess = new List<ID>();
		    ProcessInstanceWorkitem procesoActual;			
			String sNomPerfUsrJEC = 'JEC';
			String sNomPerfUsrGV = 'GV';
			String sNomPerfUsrCOOR = 'CoordinacionAdministrativa';
			String sNomPerfUsrAdmin = 'Administrador del sistema';			
															
			List<User > lUserAdmin = DCT_CreaObjetosTest_tst.CreaUsuario(1, sNomPerfUsrAdmin);																		
			List<User > lUserGV = DCT_CreaObjetosTest_tst.CreaUsuario(1, sNomPerfUsrGV);

			String sClaveDistPaso = String.valueOf(Math.random());
			String sClaveDist = sClaveDistPaso.substring(12);
			System.debug('EN DCT_ReporteCamposModifDirComercial_tst.DCT_ReporteCamposModifDirComercialBchOK sClaveDist: ' + sClaveDist);
							
			//Crea una clase para los objetos
			List<Account> lCliente = DCT_CreaObjetosTest_tst.CreaClienteC(1, VaRtAccountCorpo, lUserAdmin.get(0).id);
			List<MapaCliente__c> lMapaCliente = DCT_CreaObjetosTest_tst.CreaMapaCliente(1, 
				lCliente.get(0).id, sRecdTypeMapaClienteCorp);
			
			List<Task > lTarea = DCT_CreaObjetosTest_tst.CreaTarea(1, lMapaCliente.get(0).id, 'Llamada');
			String sIdContLead;
			List<Event > lEvento = DCT_CreaObjetosTest_tst.CreaEvento(1, lMapaCliente.get(0).id, sIdContLead);
			
			List<ControlAlarmas__c > lControlAlarmas = DCT_CreaObjetosTest_tst.CreaControlAlarmas(1, lCliente.get(0).id);
			lControlAlarmas.get(0).MapaCliente__c = lMapaCliente.get(0).id;
			update lControlAlarmas.get(0);
			
			List<Opportunity > lEmbudos = DCT_CreaObjetosTest_tst.CreaEmbudos(1, lCliente.get(0).id, 
				'Oportunidad', lCliente.get(0).OwnerId, sRecdTypeEmbudoCO);
			lEmbudos.get(0).MapaCliente__c = lMapaCliente.get(0).id;				
			update 	lEmbudos.get(0);
			
			List<Contact > lContacto = DCT_CreaObjetosTest_tst.CreaContacto(1, lCliente.get(0).id);
			lContacto.get(0).MapaCliente__c = lMapaCliente.get(0).id;				
			update 	lContacto.get(0);
			
			//Toma al usuario JEC y has las pruebas con ese
			System.runAs(lUserAdmin.get(0)){
				
				//La el usuario propietario mas la cuenta mas un ;
				String sIdAccIdOwner = lUserAdmin.get(0).id + ':';
				sIdAccIdOwner += lCliente.get(0).id + ',';
				sIdAccIdOwner += ';';
				//La cuenta y el segmento a la que corresponde
				String sIdAccNomSegm = lCliente.get(0).id + ':' + 'Corporativo,'; 
				
				//Llama al metodo ActualizaOwnerMapaClienteObjRel				
				DCT_AssignmentMethods_cls.ActualizaOwnerMapaClienteObjRel(sIdAccIdOwner, sIdAccNomSegm);
				
				//Ve si se crearon los objetos para hacer el llamado
    		    System.assertNotEquals(lCliente, null);
    		    System.assertNotEquals(lTarea, null);
    		    System.assertNotEquals(lEvento, null);
    		    System.assertNotEquals(lControlAlarmas, null);    		    
    		    System.assertNotEquals(lEmbudos, null);
    		    System.assertNotEquals(lContacto, null);    		    
    		    System.assertNotEquals(lMapaCliente, null);

			}//Fin si System.runAs(lUserAdmin.get(0))
					
		Test.stopTest();
        
    }

	@isTest(seeAllData = true)
    static void DCT_AssignmentMethods_ClienteObjRel_OK() {

		Test.startTest();

			List<ID> lIdProcess = new List<ID>();
		    ProcessInstanceWorkitem procesoActual;			
			String sNomPerfUsrJEC = 'JEC';
			String sNomPerfUsrGV = 'GV';
			String sNomPerfUsrCOOR = 'CoordinacionAdministrativa';
			String sNomPerfUsrAdmin = 'Administrador del sistema';			
															
			List<User > lUserAdmin = DCT_CreaObjetosTest_tst.CreaUsuario(1, sNomPerfUsrAdmin);																		
			List<User > lUserGV = DCT_CreaObjetosTest_tst.CreaUsuario(1, sNomPerfUsrGV);

			String sClaveDistPaso = String.valueOf(Math.random());
			String sClaveDist = sClaveDistPaso.substring(12);
			System.debug('EN DCT_ReporteCamposModifDirComercial_tst.DCT_ReporteCamposModifDirComercialBchOK sClaveDist: ' + sClaveDist);
							
			//Crea una clase para los objetos
			List<Account> lCliente = DCT_CreaObjetosTest_tst.CreaClienteC(1, VaRtAccountCorpo, lUserAdmin.get(0).id);
			List<Cliente__c> lDirCom = DCT_CreaObjetosTest_tst.CreaDirCom(1, lUserAdmin.get(0).id, lCliente.get(0));

			List<Task > lTarea = DCT_CreaObjetosTest_tst.CreaTarea(1, lDirCom.get(0).id, 'Llamada');
			System.debug('EN DCT_ReporteCamposModifDirComercial_tst.DCT_ReporteCamposModifDirComercialBchOK lTarea.WhatId: ' + lTarea.get(0).WhatId + ' lDirCom: ' + lDirCom.get(0).id);
						
			String sIdContLead;
			List<Event > lEvento = DCT_CreaObjetosTest_tst.CreaEvento(1, lDirCom.get(0).id, sIdContLead);

			List<Contact > lContacto = DCT_CreaObjetosTest_tst.CreaContacto(1, lCliente.get(0).id);
			lContacto.get(0).Directorio_Comercial__c = lDirCom.get(0).id;
			update lContacto.get(0);

			List<Opportunity > lEmbudos = DCT_CreaObjetosTest_tst.CreaEmbudos(1, lCliente.get(0).id, 
				'Oportunidad', lCliente.get(0).OwnerId, sRecdTypeEmbudoCO);				
			lEmbudos.get(0).Directorio_Comercial__c = lDirCom.get(0).id;
			update lEmbudos.get(0);
			
			List<DCTDedicatedLinks__c> lDCTDedicatedLinks = DCT_CreaObjetosTest_tst.CreaDCTDedicatedLinks(1, 
				lDirCom.get(0).id);

			List<Product2> lProducto = DCT_CreaObjetosTest_tst.CreaProducto(1, VaRtAccountProd);
			List<DCTDirectoryProductRelationship__c> lDCTDirectoryProductRel = DCT_CreaObjetosTest_tst.CreaDCTDirectoryProductRel(1, 
				lProducto.get(0).id, lDirCom.get(0).id);

			List<HistoryMovement__c> lHistoryMovement = DCT_CreaObjetosTest_tst.CreaHistoryMovement(1, 
				lDirCom.get(0).id);
								
			//Toma al usuario JEC y has las pruebas con ese
			System.runAs(lUserAdmin.get(0)){
								
				//La el usuario propietario mas la cuenta mas un ;
				String sIdAccIdOwner = lUserAdmin.get(0).id + ':';
				sIdAccIdOwner += lCliente.get(0).id + ',';
				sIdAccIdOwner += ';';
				//La cuenta y el segmento a la que corresponde
				String sIdAccNomSegm = lCliente.get(0).id + ':' + 'Corporativo,'; 
				
				//Llama al metodo ActualizaOwnerAccountObjRel
				DCT_AssignmentMethods_cls.ActualizaClienteObjRel(sIdAccIdOwner, sIdAccNomSegm);
				
				//Ve si se crearon los objetos para hacer el llamado
    		    System.assertNotEquals(lCliente, null);
    		    System.assertNotEquals(lTarea, null);
    		    System.assertNotEquals(lEvento, null);    		    
    		    System.assertNotEquals(lEmbudos, null);
    		    System.assertNotEquals(lContacto, null);    		    
    		    System.assertNotEquals(lDirCom, null);

			}//Fin si System.runAs(lUserAdmin.get(0))
					
		Test.stopTest();
        
    }

	@isTest(seeAllData = true)
    static void DCT_AssignmentMethods_EmbudoObjRel_OK() {

		Test.startTest();

			List<ID> lIdProcess = new List<ID>();
		    ProcessInstanceWorkitem procesoActual;			
			String sNomPerfUsrJEC = 'JEC';
			String sNomPerfUsrGV = 'GV';
			String sNomPerfUsrCOOR = 'CoordinacionAdministrativa';
			String sNomPerfUsrAdmin = 'Administrador del sistema';			
															
			List<User > lUserAdmin = DCT_CreaObjetosTest_tst.CreaUsuario(1, sNomPerfUsrAdmin);																		
			List<User > lUserGV = DCT_CreaObjetosTest_tst.CreaUsuario(1, sNomPerfUsrGV);

			String sClaveDistPaso = String.valueOf(Math.random());
			String sClaveDist = sClaveDistPaso.substring(12);
			System.debug('EN DCT_ReporteCamposModifDirComercial_tst.DCT_ReporteCamposModifDirComercialBchOK sClaveDist: ' + sClaveDist);
							
			//Crea una clase para los objetos
			List<Account> lCliente = DCT_CreaObjetosTest_tst.CreaClienteC(1, VaRtAccountCorpo, lUserAdmin.get(0).id);
			List<Opportunity > lEmbudos = DCT_CreaObjetosTest_tst.CreaEmbudos(1, lCliente.get(0).id, 
				'Oportunidad', lCliente.get(0).OwnerId, sRecdTypeEmbudoCO);
			
			List<Task > lTarea = DCT_CreaObjetosTest_tst.CreaTarea(1, lEmbudos.get(0).id, 'Llamada');
			String sIdContLead;
			List<Event > lEvento = DCT_CreaObjetosTest_tst.CreaEvento(1, lEmbudos.get(0).id, sIdContLead);
			
			List<ControlAlarmas__c > lControlAlarmas = DCT_CreaObjetosTest_tst.CreaControlAlarmas(1, lCliente.get(0).id);
			lControlAlarmas.get(0).Embudo__c = lEmbudos.get(0).id;
			update lControlAlarmas.get(0);
						
			List<Opportunity > lOppCte = DCT_CreaObjetosTest_tst.CreaEmbudos(1, lCliente.get(0).id, 
				'Oportunidad', lCliente.get(0).OwnerId, sRecdTypeEmbudoCO);
			lOppCte.get(0).OportunidadesCliente__c = lEmbudos.get(0).id;				
			update 	lOppCte.get(0);
			
			//Toma al usuario JEC y has las pruebas con ese
			System.runAs(lUserAdmin.get(0)){
				
				//La el usuario propietario mas la cuenta mas un ;
				String sIdAccIdOwner = lUserAdmin.get(0).id + ':';
				sIdAccIdOwner += lCliente.get(0).id + ',';
				sIdAccIdOwner += ';';
				//La cuenta y el segmento a la que corresponde
				String sIdAccNomSegm = lCliente.get(0).id + ':' + 'Corporativo,'; 
				
				//Llama al metodo ActualizaOwnerMapaClienteObjRel				
				DCT_AssignmentMethods_cls.ActualizaEmbudoObjRel(sIdAccIdOwner);
				
				//Ve si se crearon los objetos para hacer el llamado
    		    System.assertNotEquals(lCliente, null);
    		    System.assertNotEquals(lTarea, null);
    		    System.assertNotEquals(lEvento, null);
    		    System.assertNotEquals(lControlAlarmas, null);    		    
    		    System.assertNotEquals(lEmbudos, null);

			}//Fin si System.runAs(lUserAdmin.get(0))
					
		Test.stopTest();
        
    }

	@isTest(seeAllData = true)
    static void DCT_AssignmentMethods_ContactoObjRel_OK() {

		Test.startTest();

			List<ID> lIdProcess = new List<ID>();
		    ProcessInstanceWorkitem procesoActual;			
			String sNomPerfUsrJEC = 'JEC';
			String sNomPerfUsrGV = 'GV';
			String sNomPerfUsrCOOR = 'CoordinacionAdministrativa';
			String sNomPerfUsrAdmin = 'Administrador del sistema';			
															
			List<User > lUserAdmin = DCT_CreaObjetosTest_tst.CreaUsuario(1, sNomPerfUsrAdmin);																		
			List<User > lUserGV = DCT_CreaObjetosTest_tst.CreaUsuario(1, sNomPerfUsrGV);

			String sClaveDistPaso = String.valueOf(Math.random());
			String sClaveDist = sClaveDistPaso.substring(12);
			System.debug('EN DCT_ReporteCamposModifDirComercial_tst.DCT_ReporteCamposModifDirComercialBchOK sClaveDist: ' + sClaveDist);
							
			//Crea una clase para los objetos
			List<Account> lCliente = DCT_CreaObjetosTest_tst.CreaClienteC(1, VaRtAccountCorpo, lUserAdmin.get(0).id);
			List<Contact > lContacto = DCT_CreaObjetosTest_tst.CreaContacto(1, lCliente.get(0).id);

			List<Task > lTarea = DCT_CreaObjetosTest_tst.CreaTarea(1, lCliente.get(0).id, 'Llamada');
			lTarea.get(0).WhoId = lContacto.get(0).id;
			update lTarea.get(0);
			
			String sIdContLead;
			List<Event > lEvento = DCT_CreaObjetosTest_tst.CreaEvento(1, lCliente.get(0).id, sIdContLead);
			lEvento.get(0).WhoId = lContacto.get(0).id;
			update lEvento.get(0);

			//Toma al usuario JEC y has las pruebas con ese
			System.runAs(lUserAdmin.get(0)){
				
				//La el usuario propietario mas la cuenta mas un ;
				String sIdAccIdOwner = lUserAdmin.get(0).id + ':';
				sIdAccIdOwner += lCliente.get(0).id + ',';
				sIdAccIdOwner += ';';
				//La cuenta y el segmento a la que corresponde
				String sIdAccNomSegm = lCliente.get(0).id + ':' + 'Corporativo,'; 
				
				//Llama al metodo ActualizaOwnerMapaClienteObjRel				
				DCT_AssignmentMethods_cls.ActualizaContactoObjRel(sIdAccIdOwner);
				
				//Ve si se crearon los objetos para hacer el llamado
    		    System.assertNotEquals(lCliente, null);
    		    System.assertNotEquals(lTarea, null);
    		    System.assertNotEquals(lEvento, null);
    		    System.assertNotEquals(lContacto, null);

			}//Fin si System.runAs(lUserAdmin.get(0))
					
		Test.stopTest();
        
    }

	@isTest(seeAllData = true)
    static void DCT_AssignmentMethods_SeguimientoOportunidadesObjRel_OK() {

		Test.startTest();

			List<ID> lIdProcess = new List<ID>();
		    ProcessInstanceWorkitem procesoActual;			
			String sNomPerfUsrJEC = 'JEC';
			String sNomPerfUsrGV = 'GV';
			String sNomPerfUsrCOOR = 'CoordinacionAdministrativa';
			String sNomPerfUsrAdmin = 'Administrador del sistema';			
															
			List<User > lUserAdmin = DCT_CreaObjetosTest_tst.CreaUsuario(1, sNomPerfUsrAdmin);																		
			List<User > lUserGV = DCT_CreaObjetosTest_tst.CreaUsuario(1, sNomPerfUsrGV);

			String sClaveDistPaso = String.valueOf(Math.random());
			String sClaveDist = sClaveDistPaso.substring(12);
			System.debug('EN DCT_ReporteCamposModifDirComercial_tst.DCT_ReporteCamposModifDirComercialBchOK sClaveDist: ' + sClaveDist);
							
			//Crea una clase para los objetos
			List<Account> lCliente = DCT_CreaObjetosTest_tst.CreaClienteC(1, VaRtAccountCorpo, lUserAdmin.get(0).id);
			List<Opportunity > lEmbudos = DCT_CreaObjetosTest_tst.CreaEmbudos(1, lCliente.get(0).id, 
				'Oportunidad', lCliente.get(0).OwnerId, sRecdTypeEmbudoCO);
			List<MapaCliente__c> lMapaCliente = DCT_CreaObjetosTest_tst.CreaMapaCliente(1, 
				lCliente.get(0).id, sRecdTypeMapaClienteCorp);				
			List<SeguimientoOportunidades__c> lSegOpp = DCT_CreaObjetosTest_tst.CreaSegOpp(1, 
				lCliente.get(0).id, lMapaCliente.get(0).id, lEmbudos.get(0).id, sRecdTypeSegOppCorp);
			List<Task > lTarea = DCT_CreaObjetosTest_tst.CreaTarea(1, lSegOpp.get(0).id, 'Llamada');
			String sIdContLead;
			List<Event > lEvento = DCT_CreaObjetosTest_tst.CreaEvento(1, lSegOpp.get(0).id, sIdContLead);

			//Toma al usuario JEC y has las pruebas con ese
			System.runAs(lUserAdmin.get(0)){
				
				//La el usuario propietario mas la cuenta mas un ;
				String sIdAccIdOwner = lUserAdmin.get(0).id + ':';
				sIdAccIdOwner += lCliente.get(0).id + ',';
				sIdAccIdOwner += ';';
				//La cuenta y el segmento a la que corresponde
				String sIdAccNomSegm = lCliente.get(0).id + ':' + 'Corporativo,'; 
				
				//Llama al metodo ActualizaOwnerMapaClienteObjRel				
				DCT_AssignmentMethods_cls.ActualizaSeguimientoOportunidadesObjRel(sIdAccIdOwner);
				
				//Ve si se crearon los objetos para hacer el llamado
    		    System.assertNotEquals(lCliente, null);
    		    System.assertNotEquals(lTarea, null);
    		    System.assertNotEquals(lEvento, null);
    		    System.assertNotEquals(lEmbudos, null);
    		    System.assertNotEquals(lSegOpp, null);    		    

			}//Fin si System.runAs(lUserAdmin.get(0))
					
		Test.stopTest();
        
    }
    
	@isTest(seeAllData = true)
    static void DCT_AssignmentMethods_CompetenciaObjRel_OK() {

		Test.startTest();

			List<ID> lIdProcess = new List<ID>();
		    ProcessInstanceWorkitem procesoActual;			
			String sNomPerfUsrJEC = 'JEC';
			String sNomPerfUsrGV = 'GV';
			String sNomPerfUsrCOOR = 'CoordinacionAdministrativa';
			String sNomPerfUsrAdmin = 'Administrador del sistema';			
															
			List<User > lUserAdmin = DCT_CreaObjetosTest_tst.CreaUsuario(1, sNomPerfUsrAdmin);																		
			List<User > lUserGV = DCT_CreaObjetosTest_tst.CreaUsuario(1, sNomPerfUsrGV);

			String sClaveDistPaso = String.valueOf(Math.random());
			String sClaveDist = sClaveDistPaso.substring(12);
			System.debug('EN DCT_ReporteCamposModifDirComercial_tst.DCT_ReporteCamposModifDirComercialBchOK sClaveDist: ' + sClaveDist);
							
			//Crea una clase para los objetos
			List<Account> lCliente = DCT_CreaObjetosTest_tst.CreaClienteC(1, VaRtAccountCorpo, lUserAdmin.get(0).id);
			List<Contact > lContacto = DCT_CreaObjetosTest_tst.CreaContacto(1, lCliente.get(0).id);			
			List<Competencia__c> lCompetencia = DCT_CreaObjetosTest_tst.CreaCompetencia(1, lCliente.get(0).id, 
				lContacto.get(0).id);
			List<Task > lTarea = DCT_CreaObjetosTest_tst.CreaTarea(1, lCompetencia.get(0).id, 'Llamada');
			String sIdContLead;
			List<Event > lEvento = DCT_CreaObjetosTest_tst.CreaEvento(1, lCompetencia.get(0).id, sIdContLead);
			List<Opportunity > lEmbudos = DCT_CreaObjetosTest_tst.CreaEmbudos(1, lCliente.get(0).id,
				'Oportunidad', lCliente.get(0).OwnerId, sRecdTypeEmbudoCO);
			lEmbudos.get(0).Competidor__c = lCompetencia.get(0).id;
			update lEmbudos.get(0);

			//Toma al usuario JEC y has las pruebas con ese
			System.runAs(lUserAdmin.get(0)){
				
				//La el usuario propietario mas la cuenta mas un ;
				String sIdAccIdOwner = lUserAdmin.get(0).id + ':';
				sIdAccIdOwner += lCliente.get(0).id + ',';
				sIdAccIdOwner += ';';
				//La cuenta y el segmento a la que corresponde
				String sIdAccNomSegm = lCliente.get(0).id + ':' + 'Corporativo,'; 
				
				//Llama al metodo ActualizaOwnerMapaClienteObjRel				
				DCT_AssignmentMethods_cls.ActualizaCompetenciaObjRel(sIdAccIdOwner);
				
				//Ve si se crearon los objetos para hacer el llamado
    		    System.assertNotEquals(lCliente, null);
    		    System.assertNotEquals(lContacto, null);
    		    System.assertNotEquals(lTarea, null);
    		    System.assertNotEquals(lEvento, null);
    		    System.assertNotEquals(lCompetencia, null);    		    
    		    System.assertNotEquals(lEmbudos, null);

			}//Fin si System.runAs(lUserAdmin.get(0))
					
		Test.stopTest();
        
    }

	@isTest(seeAllData = true)
    static void DCT_AssignmentMethods_CompetidoresPlataformasObjRel_OK() {

		Test.startTest();

			List<ID> lIdProcess = new List<ID>();
		    ProcessInstanceWorkitem procesoActual;			
			String sNomPerfUsrJEC = 'JEC';
			String sNomPerfUsrGV = 'GV';
			String sNomPerfUsrCOOR = 'CoordinacionAdministrativa';
			String sNomPerfUsrAdmin = 'Administrador del sistema';			
															
			List<User > lUserAdmin = DCT_CreaObjetosTest_tst.CreaUsuario(1, sNomPerfUsrAdmin);																		
			List<User > lUserGV = DCT_CreaObjetosTest_tst.CreaUsuario(1, sNomPerfUsrGV);

			String sClaveDistPaso = String.valueOf(Math.random());
			String sClaveDist = sClaveDistPaso.substring(12);
			System.debug('EN DCT_ReporteCamposModifDirComercial_tst.DCT_ReporteCamposModifDirComercialBchOK sClaveDist: ' + sClaveDist);
							
			//Crea una clase para los objetos
			List<Account> lCliente = DCT_CreaObjetosTest_tst.CreaClienteC(1, VaRtAccountCorpo, lUserAdmin.get(0).id);
			List<MapaCliente__c> lMapaCliente = DCT_CreaObjetosTest_tst.CreaMapaCliente(1, 
				lCliente.get(0).id, sRecdTypeMapaClienteCorp);							
			List<ServiciosTradicionales__c> lServTradic = DCT_CreaObjetosTest_tst.CreaServTradic(1, 
				lMapaCliente.get(0).id);
			List<CompetidoresPlataformas__c> lCompPlataf = DCT_CreaObjetosTest_tst.CreaCompPlataf(1, 
				lCliente.get(0).id, lServTradic.get(0).id);
			List<Task > lTarea = DCT_CreaObjetosTest_tst.CreaTarea(1, lCompPlataf.get(0).id, 'Llamada');
			String sIdContLead;
			List<Event > lEvento = DCT_CreaObjetosTest_tst.CreaEvento(1, lCompPlataf.get(0).id, sIdContLead);
				
			//Toma al usuario JEC y has las pruebas con ese
			System.runAs(lUserAdmin.get(0)){
				
				//La el usuario propietario mas la cuenta mas un ;
				String sIdAccIdOwner = lUserAdmin.get(0).id + ':';
				sIdAccIdOwner += lCliente.get(0).id + ',';
				sIdAccIdOwner += ';';
				//La cuenta y el segmento a la que corresponde
				String sIdAccNomSegm = lCliente.get(0).id + ':' + 'Corporativo,'; 
				
				//Llama al metodo ActualizaOwnerMapaClienteObjRel				
				DCT_AssignmentMethods_cls.ActualizaCompetidoresPlataformasObjRel(sIdAccIdOwner);
				
				//Ve si se crearon los objetos para hacer el llamado
    		    System.assertNotEquals(lCliente, null);
    		    System.assertNotEquals(lCompPlataf, null);
    		    System.assertNotEquals(lTarea, null);
    		    System.assertNotEquals(lEvento, null);

			}//Fin si System.runAs(lUserAdmin.get(0))
					
		Test.stopTest();
        
    }

	@isTest(seeAllData = true)
    static void DCT_AssignmentMethods_AnalisisRelacionesObjRel_OK() {

		Test.startTest();

			List<ID> lIdProcess = new List<ID>();
		    ProcessInstanceWorkitem procesoActual;			
			String sNomPerfUsrJEC = 'JEC';
			String sNomPerfUsrGV = 'GV';
			String sNomPerfUsrCOOR = 'CoordinacionAdministrativa';
			String sNomPerfUsrAdmin = 'Administrador del sistema';			
															
			List<User > lUserAdmin = DCT_CreaObjetosTest_tst.CreaUsuario(1, sNomPerfUsrAdmin);																		
			List<User > lUserGV = DCT_CreaObjetosTest_tst.CreaUsuario(1, sNomPerfUsrGV);

			String sClaveDistPaso = String.valueOf(Math.random());
			String sClaveDist = sClaveDistPaso.substring(12);
			System.debug('EN DCT_ReporteCamposModifDirComercial_tst.DCT_ReporteCamposModifDirComercialBchOK sClaveDist: ' + sClaveDist);
							
			//Crea una clase para los objetos
			List<Account> lCliente = DCT_CreaObjetosTest_tst.CreaClienteC(1, VaRtAccountCorpo, lUserAdmin.get(0).id);
			List<MapaCliente__c> lMapaCliente = DCT_CreaObjetosTest_tst.CreaMapaCliente(1, 
				lCliente.get(0).id, sRecdTypeMapaClienteCorp);
			List<AnalisisRelaciones__c> lAnalisisRelaciones = DCT_CreaObjetosTest_tst.CreaAnalisisRelaciones(1, 
				lCliente.get(0).id, lMapaCliente.get(0).id);
			List<Task > lTarea = DCT_CreaObjetosTest_tst.CreaTarea(1, lAnalisisRelaciones.get(0).id, 'Llamada');
			String sIdContLead;
			List<Event > lEvento = DCT_CreaObjetosTest_tst.CreaEvento(1, lAnalisisRelaciones.get(0).id, sIdContLead);

			//Toma al usuario JEC y has las pruebas con ese
			System.runAs(lUserAdmin.get(0)){
				
				//La el usuario propietario mas la cuenta mas un ;
				String sIdAccIdOwner = lUserAdmin.get(0).id + ':';
				sIdAccIdOwner += lCliente.get(0).id + ',';
				sIdAccIdOwner += ';';
				//La cuenta y el segmento a la que corresponde
				String sIdAccNomSegm = lCliente.get(0).id + ':' + 'Corporativo,'; 
				
				//Llama al metodo ActualizaOwnerMapaClienteObjRel				
				DCT_AssignmentMethods_cls.ActualizaAnalisisRelacionesObjRel(sIdAccIdOwner);
				
				//Ve si se crearon los objetos para hacer el llamado
    		    System.assertNotEquals(lCliente, null);
    		    System.assertNotEquals(lMapaCliente, null);
    		    System.assertNotEquals(lTarea, null);
    		    System.assertNotEquals(lEvento, null);
    		    System.assertNotEquals(lAnalisisRelaciones, null);

			}//Fin si System.runAs(lUserAdmin.get(0))
					
		Test.stopTest();
        
    }

	@isTest(seeAllData = true)
    static void DCT_AssignmentMethods_ConocimientoMercadoObjRel_OK() {

		Test.startTest();

			List<ID> lIdProcess = new List<ID>();
		    ProcessInstanceWorkitem procesoActual;			
			String sNomPerfUsrJEC = 'JEC';
			String sNomPerfUsrGV = 'GV';
			String sNomPerfUsrCOOR = 'CoordinacionAdministrativa';
			String sNomPerfUsrAdmin = 'Administrador del sistema';			
															
			List<User > lUserAdmin = DCT_CreaObjetosTest_tst.CreaUsuario(1, sNomPerfUsrAdmin);																		
			List<User > lUserGV = DCT_CreaObjetosTest_tst.CreaUsuario(1, sNomPerfUsrGV);

			String sClaveDistPaso = String.valueOf(Math.random());
			String sClaveDist = sClaveDistPaso.substring(12);
			System.debug('EN DCT_ReporteCamposModifDirComercial_tst.DCT_ReporteCamposModifDirComercialBchOK sClaveDist: ' + sClaveDist);
							
			//Crea una clase para los objetos
			List<Account> lCliente = DCT_CreaObjetosTest_tst.CreaClienteC(1, VaRtAccountCorpo, lUserAdmin.get(0).id);
			List<ConocimientoMercado__c> lConocimientoMercado = DCT_CreaObjetosTest_tst.CreaConocimientoMercado(1, 
				lCliente.get(0).id);
			List<Task > lTarea = DCT_CreaObjetosTest_tst.CreaTarea(1, lConocimientoMercado.get(0).id, 'Llamada');
			String sIdContLead;
			List<Event > lEvento = DCT_CreaObjetosTest_tst.CreaEvento(1, lConocimientoMercado.get(0).id, sIdContLead);

			//Toma al usuario JEC y has las pruebas con ese
			System.runAs(lUserAdmin.get(0)){
				
				//La el usuario propietario mas la cuenta mas un ;
				String sIdAccIdOwner = lUserAdmin.get(0).id + ':';
				sIdAccIdOwner += lCliente.get(0).id + ',';
				sIdAccIdOwner += ';';
				//La cuenta y el segmento a la que corresponde
				String sIdAccNomSegm = lCliente.get(0).id + ':' + 'Corporativo,'; 
				
				//Llama al metodo ActualizaOwnerMapaClienteObjRel				
				DCT_AssignmentMethods_cls.ActualizaConocimientoMercadoObjRel(sIdAccIdOwner);
				
				//Ve si se crearon los objetos para hacer el llamado
    		    System.assertNotEquals(lCliente, null);
    		    System.assertNotEquals(lConocimientoMercado, null);
    		    System.assertNotEquals(lTarea, null);
    		    System.assertNotEquals(lEvento, null);

			}//Fin si System.runAs(lUserAdmin.get(0))
					
		Test.stopTest();
        
    }
    
}