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
private class DCT_HeaderPendingProcess_tst {

	public static String VaRtAccountCorpo = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Plan Cliente Telcel Corporativo').getRecordTypeId();
	public static String VaRtAccountEmpre = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Plan Cliente Telcel Empresarial').getRecordTypeId();  
	public static String VaRtAccountPyme = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Plan Cliente Telcel PyME').getRecordTypeId();

	@isTest(seeAllData = true)
    static void DCT_HeaderPendingProcess_ChangeToApprove_OK() {

		Test.startTest();

			List<ID> lIdProcess = new List<ID>();
		    ProcessInstanceWorkitem procesoActual;			
			String sNomPerfUsrJEC = 'JEC';
			String sNomPerfUsrGV = 'GV';
			String sNomPerfUsrCOOR = 'CoordinacionAdministrativa';
			String sNomPerfUsrAdmin = 'Administrador del sistema';			

			List<User > lUserAdmin = DCT_CreaObjetosTest_tst.CreaUsuario(1, sNomPerfUsrAdmin);															
			List<User > lUserJEC = DCT_CreaObjetosTest_tst.CreaUsuario(1, sNomPerfUsrJEC);															
			List<User > lUserGV = DCT_CreaObjetosTest_tst.CreaUsuario(1, sNomPerfUsrGV);
			List<User > lUserCOOR = DCT_CreaObjetosTest_tst.CreaUsuario(1, sNomPerfUsrCOOR);
			
			//Crea una clase para los objetos
			List<Account> lCliente = DCT_CreaObjetosTest_tst.CreaClienteC(1, VaRtAccountCorpo, lUserGV.get(0).id);			
			List<Contact > lContacto = DCT_CreaObjetosTest_tst.CreaContacto(1, lCliente.get(0).id);
			List<Cliente__c> lDirCom = DCT_CreaObjetosTest_tst.CreaDirCom(1, lUserAdmin.get(0).id, lCliente.get(0));			
			List<DCTAssignment__c> lAssignment = DCT_CreaObjetosTest_tst.CreaAssignment(1);
			System.debug('EN DCT_ApprovalProcessReassign_tst.DCT_ApprovalProcessReassignOK lAssignment: ' + lAssignment);
								
			//Toma al usuario JEC y has las pruebas con ese
			System.runAs(lUserAdmin.get(0)){
				
				Approval.ProcessSubmitRequest procSubmReq = new Approval.ProcessSubmitRequest();
				procSubmReq.setComments('VoBo: Aprobación de la investigación');
				procSubmReq.setObjectId(lDirCom.get(0).id);
				procSubmReq.setProcessDefinitionNameOrId('DCTResearchResults1a2');
				procSubmReq.setSkipEntryCriteria(true);
				try{
					System.debug('EN DCT_ApprovalProcessReassign_tst.DCT_ApprovalProcessReassignOK procSubmReq: ' + procSubmReq);
					Approval.ProcessResult result = Approval.process(procSubmReq, true);
					System.debug('EN DCT_ApprovalProcessReassign_tst.DCT_ApprovalProcessReassignOK result: ' + result);					
					if (result.isSuccess()){
						lIdProcess = result.getNewWorkitemIds();
						System.debug('EN DCT_ApprovalProcessReassign_tst.DCT_ApprovalProcessReassignOK lIdProcess: ' + lIdProcess);						
						//Toma el id del reg que se mando al proceso de aprobación y mandaselo el controlador
						procesoActual = new ProcessInstanceWorkitem(id = lIdProcess.get(0));
						System.debug('EN DCT_ApprovalProcessReassign_tst.DCT_ApprovalProcessReassignOK procesoActual: ' + procesoActual);						
					}//Fin si result.isSuccess()
				}catch(Exception gE){ gE.getMessage();}       

				//Utiliza la pagina de DCT_AccountOwnerAssignment_pag
				PageReference pageRef = Page.DCT_HeaderPendingProcess_pag;
				//Unos parametros para que entre por el controlador estandar
				//pageRef.getParameters().put('toToggleUserId', lUserGV.get(0).id);
				Test.setCurrentPage(pageRef);

		        // Instantiate a standard controller class with our contact
        		DCT_HeaderPendingProcess_ctr stdCon = new DCT_HeaderPendingProcess_ctr(new ApexPages.StandardController(procesoActual));
				stdCon.validaDatos(null);
				stdCon.validaDatos('12adc');
				stdCon.validaDatos('0');
				stdCon.changeStatusToApprove();
				stdCon.sNoLinAuto = '10';
				stdCon.changeToApprove();
				stdCon.regresar();
				
			}//Fin si System.runAs(lUserGV.get(0))
			
			//Ve si no se creo el proceso de aprobación
    	    System.assertEquals(procesoActual.id, lIdProcess.get(0));
		
		Test.stopTest();
		
    }

	@isTest(seeAllData = true)
    static void DCT_HeaderPendingProcess_ChangeToReject_OK() {

		Test.startTest();

			List<ID> lIdProcess = new List<ID>();
		    ProcessInstanceWorkitem procesoActual;			
			String sNomPerfUsrJEC = 'JEC';
			String sNomPerfUsrGV = 'GV';
			String sNomPerfUsrCOOR = 'CoordinacionAdministrativa';
			String sNomPerfUsrAdmin = 'Administrador del sistema';			

			List<User > lUserAdmin = DCT_CreaObjetosTest_tst.CreaUsuario(1, sNomPerfUsrAdmin);															
			List<User > lUserJEC = DCT_CreaObjetosTest_tst.CreaUsuario(1, sNomPerfUsrJEC);															
			List<User > lUserGV = DCT_CreaObjetosTest_tst.CreaUsuario(1, sNomPerfUsrGV);
			List<User > lUserCOOR = DCT_CreaObjetosTest_tst.CreaUsuario(1, sNomPerfUsrCOOR);
			
			//Crea una clase para los objetos
			List<Account> lCliente = DCT_CreaObjetosTest_tst.CreaClienteC(1, VaRtAccountCorpo, lUserGV.get(0).id);			
			List<Contact > lContacto = DCT_CreaObjetosTest_tst.CreaContacto(1, lCliente.get(0).id);
			List<Cliente__c> lDirCom = DCT_CreaObjetosTest_tst.CreaDirCom(1, lUserAdmin.get(0).id, lCliente.get(0));			
			List<DCTAssignment__c> lAssignment = DCT_CreaObjetosTest_tst.CreaAssignment(1);
			System.debug('EN DCT_ApprovalProcessReassign_tst.DCT_ApprovalProcessReassignOK lAssignment: ' + lAssignment);
								
			//Toma al usuario JEC y has las pruebas con ese
			System.runAs(lUserAdmin.get(0)){
				
				Approval.ProcessSubmitRequest procSubmReq = new Approval.ProcessSubmitRequest();
				procSubmReq.setComments('VoBo: Aprobación de la investigación');
				procSubmReq.setObjectId(lDirCom.get(0).id);
				procSubmReq.setProcessDefinitionNameOrId('DCTResearchResults1a2');
				procSubmReq.setSkipEntryCriteria(true);
				try{
					System.debug('EN DCT_ApprovalProcessReassign_tst.DCT_ApprovalProcessReassignOK procSubmReq: ' + procSubmReq);
					Approval.ProcessResult result = Approval.process(procSubmReq, true);
					System.debug('EN DCT_ApprovalProcessReassign_tst.DCT_ApprovalProcessReassignOK result: ' + result);					
					if (result.isSuccess()){
						lIdProcess = result.getNewWorkitemIds();
						System.debug('EN DCT_ApprovalProcessReassign_tst.DCT_ApprovalProcessReassignOK lIdProcess: ' + lIdProcess);						
						//Toma el id del reg que se mando al proceso de aprobación y mandaselo el controlador
						procesoActual = new ProcessInstanceWorkitem(id = lIdProcess.get(0));
						System.debug('EN DCT_ApprovalProcessReassign_tst.DCT_ApprovalProcessReassignOK procesoActual: ' + procesoActual);						
					}//Fin si result.isSuccess()
				}catch(Exception gE){ gE.getMessage();}       

				//Utiliza la pagina de DCT_AccountOwnerAssignment_pag
				PageReference pageRef = Page.DCT_HeaderPendingProcess_pag;
				//Unos parametros para que entre por el controlador estandar
				//pageRef.getParameters().put('toToggleUserId', lUserGV.get(0).id);
				Test.setCurrentPage(pageRef);

		        // Instantiate a standard controller class with our contact
        		DCT_HeaderPendingProcess_ctr stdCon = new DCT_HeaderPendingProcess_ctr(new ApexPages.StandardController(procesoActual));
				stdCon.sNoLinAuto = '10';
				stdCon.changeStatusToReject();
				stdCon.changeToReject();
				stdCon.regresar();
				
			}//Fin si System.runAs(lUserGV.get(0))
			
			//Ve si no se creo el proceso de aprobación
    	    System.assertEquals(procesoActual.id, lIdProcess.get(0));
		
		Test.stopTest();
		
    }
        
}