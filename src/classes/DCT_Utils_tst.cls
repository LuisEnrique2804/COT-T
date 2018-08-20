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
private class DCT_Utils_tst {
	
	public static String VaRtAccountCorpo = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Plan Cliente Telcel Corporativo').getRecordTypeId();
	public static String VaRtAccountEmpre = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Plan Cliente Telcel Empresarial').getRecordTypeId();  
	public static String VaRtAccountPyme = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Plan Cliente Telcel PyME').getRecordTypeId();
    public static String sRecdTypeEmbudoCO = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Corporativo Oportunidad').getRecordTypeId();
    
	@isTest(seeAllData = true)
    static void DCT_Utils_OK() {

		Test.startTest();

			List<ID> lIdProcess = new List<ID>();
		    ProcessInstanceWorkitem procesoActual;			
			String sNomPerfUsrJEC = 'JEC';
			String sNomPerfUsrGV = 'GV';
			String sNomPerfUsrCOOR = 'CoordinacionAdministrativa';
			String sNomPerfUsrAdmin = 'Administrador del sistema';			
															
			List<User > lUserAdmin = DCT_CreaObjetosTest_tst.CreaUsuario(1, sNomPerfUsrAdmin);																		
											
			//Toma al usuario JEC y has las pruebas con ese
			System.runAs(lUserAdmin.get(0)){
				System.debug('EN DCT_CatalogoClavesVPN_tst.DCT_CatalogoClavesVPNOK ENTRO A GENERAR LOS OBJETOS...');
				
				DCT_Utils_cls objDctUtils = new DCT_Utils_cls();
				
				DCT_Utils_cls.respuestaTelcel  objRespuestaTelcel = new DCT_Utils_cls.respuestaTelcel();
				objRespuestaTelcel.referenciaWSRap = new DCT_Utils_cls.referenciaWSRap();
				
				DCT_Utils_cls.referenciaWSRap objReferenciaWSRap = new DCT_Utils_cls.referenciaWSRap();
				objReferenciaWSRap.idEstatus = 1;
				objReferenciaWSRap.nombreCliente = 'nombreCliente';
				objReferenciaWSRap.referencia = 'referencia';
				objReferenciaWSRap.rfc = 'rfc';
				objReferenciaWSRap.Message = 'Message';
				objReferenciaWSRap.MessageDetail = 'MessageDetail';
				objReferenciaWSRap.descEstatus = 'descEstatus';

				DCT_Utils_cls.DtRespuestaTelcel objDtRespuestaTelcel = new DCT_Utils_cls.DtRespuestaTelcel();
				objDtRespuestaTelcel.access_token = 'access_token';
				objDtRespuestaTelcel.token_type = 'token_type';
				objDtRespuestaTelcel.expires_in = 60;
				objDtRespuestaTelcel.error = 'error';
				objDtRespuestaTelcel.error_description = 'error_description';
				
				//Inicializa mapEndpointSettingMdt
				DCT_Utils_cls.mapEndpointSettingMdt = DCT_Utils_cls.getEndpointSettingMdt();
				
				//Llama la función de login
				DCT_Utils_cls.LoginTelcel(); 

				//Crea una clase para los objetos
				List<Account> lCliente = DCT_CreaObjetosTest_tst.CreaClienteC(1, VaRtAccountCorpo, lUserAdmin.get(0).id);
				List<Cliente__c> lDirCom = DCT_CreaObjetosTest_tst.CreaDirCom(1, lUserAdmin.get(0).id, lCliente.get(0));
				lDirCom.get(0).DTC_LegalEntity__c = 'Física';
				lDirCom.get(0).DCTFolio__c = null;
				lDirCom.get(0).DCTRapReference__c = null;				
				update lDirCom.get(0);
				
				//Actaliza el objeto del tipo DCT_FolioSAP_ws.respSalesforce objRespSalesforce
				DCT_FolioSAP_ws.respSalesforce objRespSalesforcePaso = new DCT_FolioSAP_ws.respSalesforce();
				objRespSalesforcePaso.error = false;
				objRespSalesforcePaso.mensaje = 'mensaje';
				objRespSalesforcePaso.folio = 'folio';
				
				//Inicializa DCT_Utils_cls.objRespSalesforce
				DCT_Utils_cls.objRespSalesforce = objRespSalesforcePaso;

				//Toma la opp que se acaba de crear y mandala a la funcion de ActualizaFolioSAPDirCom
				String sOppNva = lDirCom.get(0).id + ',';				
				//Llama a la función ActualizaFolioSAPDirCom para Fisica
				DCT_Utils_cls.ActualizaFolioSAPDirCom(sOppNva);

				//Actualiza los datos de lDirCom para moral
				lDirCom.get(0).DTC_LegalEntity__c = 'Moral';
				lDirCom.get(0).DCTFolio__c = null;
				lDirCom.get(0).DCTRapReference__c = null;
				DCT_TriggerExecutionControl_cls.setAlreadyBeenExecuted('DCT_ComercialDirectory_tgr');								
				update lDirCom.get(0);

				//Toma la opp que se acaba de crear y mandala a la funcion de ActualizaFolioSAPDirCom
				sOppNva = lDirCom.get(0).id + ',';
				//Llama a la función ActualizaFolioSAPDirCom para Moral
				DCT_Utils_cls.ActualizaFolioSAPDirCom(sOppNva);

				//Llama el metodo ActualizaReferenciaRAPDirCom
				DCT_Utils_cls.ActualizaReferenciaRAPDirCom(sOppNva);
				
				//Llama el metodo
				DCT_Utils_cls.buscaComentariosProceso(lDirCom.get(0).id);
				
				String sIdCliente = lDirCom.get(0).id + ',';
				//Llama a los procesos 
				DCT_Utils_cls.ActualizaInvestigacionesEsc5VI(sIdCliente, true);
				
				//Actualiza los datos de lDirCom para moral
				lDirCom.get(0).DTC_LegalEntity__c = 'Moral';
				lDirCom.get(0).DCTFolio__c = null;
				lDirCom.get(0).DCTRapReference__c = null;				
				lDirCom.get(0).DCTResultVerificationEsp__c = 'NEGATIVA';
				lDirCom.get(0).DCTResultVerification__c = 'NEGATIVA';
				DCT_TriggerExecutionControl_cls.setAlreadyBeenExecuted('DCT_ComercialDirectory_tgr');				
				update lDirCom.get(0);
				//Llama a los procesos				
				DCT_Utils_cls.ActualizaInvestigacionesEsc12Pos(sIdCliente, true);

				//Llama a los procesos				
				DCT_Utils_cls.ActualizaInvestigacionesEsc1PosSI(sIdCliente, true);

				//Actualiza los datos de lDirCom para moral
				lDirCom.get(0).DTC_LegalEntity__c = 'Moral';
				lDirCom.get(0).DCTFolio__c = null;
				lDirCom.get(0).DCTRapReference__c = null;
				lDirCom.get(0).DCTResultVerification__c = 'NEGATIVA';
				DCT_TriggerExecutionControl_cls.setAlreadyBeenExecuted('DCT_ComercialDirectory_tgr');				
				update lDirCom.get(0);
				//Llama a los procesos
				DCT_Utils_cls.ActualizaInvestigacionesEsc2NegCAprob(sIdCliente);
				//Llama a los procesos
				DCT_Utils_cls.ActualizaInvestigacionesEsc3SinInvestiga(sIdCliente);
				//Llama a los procesos				
				DCT_Utils_cls.ActualizaInvestigacionesEsc4IT(sIdCliente);

				lDirCom.get(0).DTC_LegalEntity__c = 'Moral';
				lDirCom.get(0).DCTFolio__c = null;
				lDirCom.get(0).DCTRapReference__c = null;
				lDirCom.get(0).DCTResultVerification__c = 'POSITIVA';
				DCT_TriggerExecutionControl_cls.setAlreadyBeenExecuted('DCT_ComercialDirectory_tgr');				
				update lDirCom.get(0);				
				//Llama a los procesos				
				DCT_Utils_cls.ActualizaInvestigacionesEsc1Pos(sIdCliente, true);
				
				//Ve si se crearon los objetos para hacer el llamado
    		    System.assertNotEquals(objRespuestaTelcel, null);
    		    System.assertNotEquals(objReferenciaWSRap, null);
    		    System.assertNotEquals(objDtRespuestaTelcel, null);
				
			}//Fin si System.runAs(lUserAdmin.get(0))
			
		Test.stopTest();
		
    }
    
}