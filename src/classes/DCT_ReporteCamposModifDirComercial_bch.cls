global class DCT_ReporteCamposModifDirComercial_bch implements Database.Batchable<sObject>, Database.Stateful {

    global string query;
    
    //Un constructor por default
    global DCT_ReporteCamposModifDirComercial_bch(string query){
        this.query = query;
    }
    
    //Start
    global Database.querylocator start(Database.BatchableContext BC){
        System.debug('EN DCT_ReporteCamposModifDirComercial_bch.start query: ' + this.query);
        return Database.getQueryLocator(this.query);
    }
    
    //Execute
    global void execute(Database.BatchableContext BC, List<Cliente__c> scope){
        System.debug('EN DCT_ReporteCamposModifDirComercial_bch.');
		
		//Crea la lista para poder eliminar los reg de ClientesPaso__c
		Map<String, DCT_ReportCamModifDirCom__c> mapClientesPasoIns = new Map<String, DCT_ReportCamModifDirCom__c>();

		//IME030218UTA |ISBAN MEXICO SA DE CV|GRUPO NESTLE|Corporativo||Aseguradoras|10345677|CAM 3 A LA B CA¥ADA CHICA ANTIGUA ACTOPAN 42500 HGOMEX|CAM 3,A LA B,CA¥ADA CHICA ANTIGUA,ACTOPAN,42500,HGOMEX|Si|30|false|01-08-2010|8 Años 0 meses|Banco del Bajío|6B329762EA4649904|Cliente Cautivo|Activo|Moral|Protocolización|06-08-2018|true|true|VALADEZ MEJÍA CLAUDIA|SIN RENTA POR ADELANTADO|20-07-2018||true|61|3E|false|OK|TELCEL MAX SIN LIMITE EMPRESARIAL BB 4G,INTERNET TELCEL EMPRESA A TECHO BAJO,|BB,AADM,A|97,9,3|TELCEL MAX SIN LIMITE EMPRESARIAL 2000 BB 4G - 18 MESES,INTERNET TELCEL EMPRESA 1 MB A TB - 18 MESES,|18,18,12|Jorge Rodriguez Contreras,Jorge Rodriguez Contreras,Jorge Rodriguez Contreras|,,|true|,,|,|Activación VPN;Cambio de SIM;Renovación de Adendum,Para Voz - Datos;Promoción Venta Empleado|sergio guerrero,|5510101010,|234,|5510101010,|sergio.guerrero@celme.com,sergio.guerrero@celme.com|,|07-08-2010,06-08-2018|Procede Activación|Sin Investigacion||SI|si Se autorizan: 2 líneas.||03-08-2018|||Alfredo Martinez Ramirez|XON4481|JOSE ANTONIO GONZALEZ CRESPO,ERIK ALBERTO CAMPUZANO SANTO|GERENTE,DIRECTOR|Contacto 1,Principal|5512343211,5512343211|432433,5644324|joseagc@hotmail.com,erikacs@hotmail.com|Sí,No|

		//IME030218UTA 		|ISBAN MEXICO SA DE CV|GRUPO NESTLE		|Corporativo	|			|Aseguradoras	|10345677		|CAM 3 A LA B CA¥ADA CHICA ANTIGUA ACTOPAN 42500 HGOMEX
		/*RFC				Razon Social		Grupo de Empresa	Segmento		Sector		Subsector		Clave NISI		Domicilio Fiscal		
		RFC__c RFC1__c 		Name				Grupo__r.Name		Segmento__c		Sector__c	Subsector__c	DCTKeyNISI__c	DCTFiscalAddress__c		
		ABA970106H3A		BANAMEX SA DE CV	CITI				Corporativo		Privado		Bancario		10300176		Av. Juárez 104, Col. Centro, Del.Cuahutemos, 06040

		|CAM 3,A LA B,CA¥ADA 			|Si							|30				|true						|2010-08-01				|8 Años 0 meses		|Banco del Bajío	|6B329762EA4649904		|Cliente Cautivo	|Activo			|Moral										|								|											|true			|true			|VALADEZ MEJÍA CLAUDIA			|SIN RENTA POR ADELANTADO		|2018-07-20					|						|true					|61						|3E					|false				|OK					|TELCEL MAX SIN LIMITE EMPRESARIAL BB 4G,		|BB,AADM,A,						|97,9,3,						|TELCEL MAX SIN LIMITE EMPRESARIAL 2000 BB 4G - 18 MESES,				|2,2,1,						|Jorge Rodriguez Contreras,				|,,,									|true					|										|													|																							|sergio guerrero							|5510101010									|234						|5510101010										|sergio.guerrero@celme.com																								|Procede Activación			|Sin Investigacion				|						|SI						|si Se autorizan: 2 líneas.		|								|2018-08-03								|							|								|Alfredo Martinez Ramirez			|XON4481|							|JOSE ANTONIO GONZALEZ CRESPO						|GERENTE,					|Contacto 1					|5512343211,				|432433,			|joseagc@hotmail.com,										|Sí,|
																																																																																																																																																									INTERNET TELCEL EMPRESA A TECHO BAJO,,																			INTERNET TELCEL EMPRESA 1 MB A TB - 18 MESES,,														Jorge Rodriguez Contreras,																																																																																																																																																																																																																															,ERIK ALBERTO CAMPUZANO SANTO,						DIRECTOR,					,Principal,					5512343211,					5644324,			erikacs@hotmail.com,										No,
		CHICA ANTIGUA,ACTOPAN,42500,																																																																																																																																																																																																					Jorge Rodriguez Contreras,														
		HGOMEX		
		Domicilio de Correspondencia	Adendum Anticipado			Plazo en días	Bonifica Penalizacion		Cliente Telcel desde	Antigüedad			Banco				Referencia RAP			Tipo de Cliente		Estatus			Persona Jurídica							Razon Social Modificada por		Fecha de Protocolizacion/Adjudicación		Es VIP?			Tiene AVL?		Representante Legal				Beneficios						Fecha Registro				Fecha de Baja			Activar VPN				Ciclo de Facturación	Clase de Crédito	Exenta Fianza		Comentarios			Grupo o Categoría de Datos						Tarifa/Plan Autorizado			Clave del Plan					Nombre del Plan															Plazo						Gerente									Fecha de Autorización					Trato Compartido		Fuerza Venta								Nombre DAT											Servicios																					Nombre de Inplant							Telefono Inplant							Extensión Inplant			Celular Inplant									Correo Electrónico Inplant									Distribuidor Inplant			Fecha de Registro Inplant	Leyenda de Investigacion	Resultado de la Verificación	Motivo de Rechazo		Investigacion			Comentarios						Líneas Activas					Fecha de Autorización					Líneas Autorizadas			Total de Líneas Autorizadas		Nombre completo del Propietario		Usuario Universal del Propietario	Nombre de Contacto									Puesto						Tipo de Contacto			Teléfono Móvil				NIP					Correo electrónico											Autoriza recibir Información
		DCTCorrespondenceAddress__c		DCTAnticipatedAdendum__c	DCTTermDays__c	DCTBonusCustomization__c	DCTCustomerFrom__c		DCTAntiquity__c		DCTMethodOfPayment__c			DCTRapReference__c		Tipocliente__c		Estatus__c		DCT_LegalPerson__c, DTC_LegalEntity__c		DCTSocialReasonModified__c		DCTDateRegistrationAdjudication__c			DCTVIP__c		DCTAVL__c		DCTLegalRepresentative__c		DCTBenefits__c					DCTRegistrationDate__c		DCTLowDateAccuont__c	DCTVPNActivation__c		DCTBillingCycle__c		DCTCreditClass__c	DCTExemptBail__c	DCTComments__c		DescripcionGrupoPlan__c (DCTPlan__c)			ClaveTarifa__c (DCTPlan__c)		ClaveGrupoPlan__c (DCTPlan__c)	DescripcionPlan__c (DCTPlan__c)											DCTTerm__c (DCTPlan__c)		DCTSubdirector__r.Name (DCTPlan__c)		DCTAuthorizationDate__c	(DCTPlan__c)	DCTSharedTreatment__c	DCT_CatalogoFuerzaVenta__r.Name (DAT__c)	DCTDistribuidorPrincipal__c 						N/A																							DCTInplantName1__c, DCTInplantName2__c		DCTInplantPhone1__c, DCTInplantPhone2__c	DCTExt1__c, DCTExt2__c		DCTInplantmobile1__c, DCTInplantmobile2__c		DCTInplantEmail1__c, DCTInplantEmail2__c					DCT_CatalogoFuerzaVenta__r.Name	DCTInplantDate1__c			DCTResearchLegend__c		DCTResultVerification__c		DCTReasonRejection__c	DCTInvestigation__c		DCTCommentsInvestigation__c										DCTAuthorizationDateVoBoManagement__c	DCTTotLineasAutorInvest__c									Owner.Name							Owner.DCTXO__c						Contact.Name										Contact.Posicion__c			Contact.DCTTypeContact__c	Contact.MobilePhone			Contact.DCTNIP__c	Contact.Email												Contact.DCTReceiveInformation__c
																																																																																																																																																																																																																																								DCTCatalogoFuerzaVenta2__r.Name (DAT__c)	DCTDistribuidorSecundario__c 																																																																																					DCTCatalogoFuerzaVenta2__r.Name	DCTInplantDate2__c
		Av. Juárez 104, Col. Centro, 	SI							30				S							03/11/2013				2 años 5 meses		HSBC				34234234234234			Cautivo				Activo			Moral										Adjudicación					04/11/2013									true			true			Adriana Espinisa Robles			El comentario de beneficios		03/11/2013					05/11/2013				true					20						D3					EX					El comentario		PRO EMPRESA1000 BBCB, PRO EMPRESA 1000 DDCB		ADM, APT, AASR, AA				DH604, YF959, YG649				Telcel PRO 300, Telcel MAZ100, TELCEL MAS POR MENOS, TELCEL PRO 500		12, 18, 24, 12				Pablo Carlos García López				21/03/2015								true					DIGSHOP, CELME								DIGITAL SHOP SA DE CV, CENTRO CELULAR SA DE CV		Voz-Datos, Cambio de SIM, Promoción Venta Empleado, renovación de Adendum, Activacion VPN	Miriam Robles Rojas, Andrea Marínez Robles	5512345678, 57891234						1234, 56789					5512345678, 5566228833							miriam.robles@dominio.com, adriana.gonzales@dominio.com		DIGISHOP, CELME					20/09/2015, 23/09/2015		Procede Activación			Negativa												IN						Se autorizan 15 lineas			15								28/07/2015								2							18								Carlos Medina Espinoza				XOAAAAA								Andrea Martínez Robles, Leonel Castillo Martínez	Supervisor, Analista		VIP, Principal				5512345678, 5522334455		0001112, 0001122	andrea.martinez@dominio.com, leonel.castillo@dominio.com	true, false
		Del.Cuahutemos, 06040					

		this.sQuery +=' (Select Plan__r.DescripcionGrupoPlan__c, Plan__r.ClaveTarifa__c, Plan__r.ClaveGrupoPlan__c,   Plan__r.DescripcionPlan__c, Plan__r.DCTTerm__c, ';
		this.sQuery +=' DCTSubdirector__r.Name, DCTAuthorizationDate__c  From Lineas_Autorizadas__r),  ';
		this.sQuery +=' (Select Name, Posicion__c, DCTTypeContact__c, MobilePhone, DCTNIP__c, Email  From DirectorioComercial_Contactos__r)  ';
				
		*/
		Set<String> setIdOwner = new Set<String>();
		Map<String, User> mapDatosUsuario = new Map<String, User>();
        //Recorre la lista de los reg mod y toma el owneer para ver de quien se trata
        for (Cliente__c DirMod : scope){
        	String sOwnerIdPaso = DirMod.OwnerId;
        	if (sOwnerIdPaso.startsWith('005'))
				setIdOwner.add(sOwnerIdPaso);			        	
        }
		
		//Ve si tiene algo setIdOwner
		if (!setIdOwner.isEmpty()){
			for (User usuario : [Select id, Name, DCTXO__c, DCTVT__c, Manager.Name  
				From User Where Id IN: setIdOwner]){
				mapDatosUsuario.put(usuario.id, usuario);
			}
		}//Fin si !setIdOwner.isEmpty()
        System.debug('EN DCT_ReporteCamposModifDirComercial_bch mapDatosUsuario: ' + mapDatosUsuario);
        		
        //Recorre la lista de Casos para cerrarlos 
        for (Cliente__c DirMod : scope){
        	String sRegistroPaso = '';
        	String sIdExterno = '';
        	String sSpacios = ' ';
        	String sConSpacios = ' ';

	        //DATOS DEL DIRECTORIO COMERCIAL DTCCustomerID__c       	
	        //ID
        	sRegistroPaso += DirMod.DTCCustomerID__c != null ? DirMod.DTCCustomerID__c : DirMod.DTCCustomerID__c + '|'; 
	        System.debug('EN DCT_ReporteCamposModifDirComercial_bch DirMod.RFC__c: ' + DirMod.RFC__c);
        	//RFC
        	sRegistroPaso += (DirMod.RFC__c != null ? DirMod.RFC__c.rightPad(13, sSpacios) : sConSpacios.rightPad(13, sSpacios)) + '|'; 
	        System.debug('EN DCT_ReporteCamposModifDirComercial_bch DirMod.RFC__c: ' + DirMod.RFC__c);
	        //RAZON SOCIAL
        	sRegistroPaso += DirMod.Name != null ? DirMod.Name + '|' : '|';        	
	        System.debug('EN DCT_ReporteCamposModifDirComercial_bch DirMod.Name: ' + DirMod.Name);
	        //GRUPO DE EMPRESA
        	sRegistroPaso += DirMod.Grupo__r.Name != null ? DirMod.Grupo__r.Name + '|' : '|';        	
	        System.debug('EN DCT_ReporteCamposModifDirComercial_bch DirMod.Grupo__r.Name: ' + DirMod.Grupo__r.Name);
	        //SEGMENTO
        	sRegistroPaso += DirMod.Segmento__c != null ? DirMod.Segmento__c + '|' : '|';
	        System.debug('EN DCT_ReporteCamposModifDirComercial_bch DirMod.Segmento__c: ' + DirMod.Segmento__c);
	        //SECTOR
        	sRegistroPaso += DirMod.Sector__c != null ? DirMod.Sector__c + '|' : '|';
	        System.debug('EN DCT_ReporteCamposModifDirComercial_bch DirMod.Sector__c: ' + DirMod.Sector__c);
	        //SUBSECTOR
        	sRegistroPaso += DirMod.Subsector__c != null ? DirMod.Subsector__c + '|' : '|';
	        System.debug('EN DCT_ReporteCamposModifDirComercial_bch DirMod.Subsector__c: ' + DirMod.Subsector__c);
	        //CLAVE NISI
        	sRegistroPaso += DirMod.DCTKeyNISI__c != null ? DirMod.DCTKeyNISI__c + '|' : '|';
	        System.debug('EN DCT_ReporteCamposModifDirComercial_bch DirMod.DCTKeyNISI__c: ' + DirMod.DCTKeyNISI__c);
	        //NOMBRE COMERCIAL
        	sRegistroPaso += DirMod.DCT_NombreComercial__c != null ? DirMod.DCT_NombreComercial__c + '|' : '|';
	        System.debug('EN DCT_ReporteCamposModifDirComercial_bch DirMod.DCTKeyNISI__c: ' + DirMod.DCTKeyNISI__c);
	        //DOMICILIO FISCAL
        	sRegistroPaso += DirMod.DCTFiscalAddress__c != null ? DirMod.DCTFiscalAddress__c + '|' : '|';
	        System.debug('EN DCT_ReporteCamposModifDirComercial_bch DirMod.DCTFiscalAddress__c: ' + DirMod.DCTFiscalAddress__c);
	        //DOMICILIO DE CORRESPONDENCIA
        	sRegistroPaso += DirMod.DCTCorrespondenceAddress__c != null ? DirMod.DCTCorrespondenceAddress__c + '|' : '|';
	        System.debug('EN DCT_ReporteCamposModifDirComercial_bch DirMod.DCTCorrespondenceAddress__c: ' + DirMod.DCTCorrespondenceAddress__c);
			//ADENDUM ANTICIPADO
        	sRegistroPaso += DirMod.DCTAnticipatedAdendum__c != null ? DirMod.DCTAnticipatedAdendum__c + '|' : '|';
	        System.debug('EN DCT_ReporteCamposModifDirComercial_bch DirMod.DCTAnticipatedAdendum__c: ' + DirMod.DCTAnticipatedAdendum__c);
	        //PLAZO EN DIAS
        	sRegistroPaso += DirMod.DCTTermDays__c != null ? DirMod.DCTTermDays__c + '|' : '|';
	        System.debug('EN DCT_ReporteCamposModifDirComercial_bch DirMod.DCTTermDays__c: ' + DirMod.DCTTermDays__c);
	        //BONIFICA PENALIZACION
        	sRegistroPaso += DirMod.DCTBonusCustomization__c != null ? String.valueOf(DirMod.DCTBonusCustomization__c) + '|' : '|'; //VALIDAR
	        System.debug('EN DCT_ReporteCamposModifDirComercial_bch DirMod.DCTBonusCustomization__c: ' + DirMod.DCTBonusCustomization__c);
	        //CLIENTE TELCEL DESDE
        	sRegistroPaso += DirMod.DCTCustomerFrom__c != null ? formateaFecha(DirMod.DCTCustomerFrom__c) + '|' : '|';
	        System.debug('EN DCT_ReporteCamposModifDirComercial_bch DirMod.DCTCustomerFrom__c: ' + DirMod.DCTCustomerFrom__c);
			//ANTIGUEDAD
        	sRegistroPaso += DirMod.DCTAntiquity__c != null ? String.valueOf(DirMod.DCTAntiquity__c) + '|' : '|';
	        System.debug('EN DCT_ReporteCamposModifDirComercial_bch DirMod.DCTAntiquity__c: ' + DirMod.DCTAntiquity__c);
	        //FORMA DE PAGO
        	sRegistroPaso += DirMod.DCTMethodOfPayment__c != null ? String.valueOf(DirMod.DCTMethodOfPayment__c) + '|' : '|';
	        System.debug('EN DCT_ReporteCamposModifDirComercial_bch DirMod.DCTMethodOfPayment__c: ' + DirMod.DCTMethodOfPayment__c);
			//REFERENCIA RAP
        	sRegistroPaso += DirMod.DCTRapReference__c != null ? String.valueOf(DirMod.DCTRapReference__c) + '|' : '|';
	        System.debug('EN DCT_ReporteCamposModifDirComercial_bch DirMod.DCTRapReference__c: ' + DirMod.DCTRapReference__c);
	        //TIPO DE CLIENTE
        	sRegistroPaso += DirMod.Tipocliente__c != null ? String.valueOf(DirMod.Tipocliente__c) + '|' : '|';
	        System.debug('EN DCT_ReporteCamposModifDirComercial_bch DirMod.Tipocliente__c: ' + DirMod.Tipocliente__c);
	        //ESTATUS
        	sRegistroPaso += DirMod.Estatus__c != null ? String.valueOf(DirMod.Estatus__c) + '|' : '|';
	        System.debug('EN DCT_ReporteCamposModifDirComercial_bch DirMod.Estatus__c: ' + DirMod.Estatus__c);
	        //PERSONA JURIDICA
        	sRegistroPaso += DirMod.DCT_LegalPerson__c != null ? String.valueOf(DirMod.DCT_LegalPerson__c) + '|' : '|';
	        System.debug('EN DCT_ReporteCamposModifDirComercial_bch DirMod.DCT_LegalPerson__c: ' + DirMod.DCT_LegalPerson__c);
	        //RAZON SOCIAL MODIFICADA POR
        	sRegistroPaso += DirMod.DCTSocialReasonModified__c != null ? String.valueOf(DirMod.DCTSocialReasonModified__c) + '|' : '|'; //VALIDAR
	        System.debug('EN DCT_ReporteCamposModifDirComercial_bch DirMod.DCTSocialReasonModified__c: ' + DirMod.DCTSocialReasonModified__c);
	        //FECHA DE PROTOCOLIZACION/ADJUDICACION	        
        	sRegistroPaso += DirMod.DCTDateRegistrationAdjudication__c != null ? formateaFecha(DirMod.DCTDateRegistrationAdjudication__c) + '|' : '|';
	        System.debug('EN DCT_ReporteCamposModifDirComercial_bch DirMod.DCTDateRegistrationAdjudication__c: ' + DirMod.DCTDateRegistrationAdjudication__c);
	        //ESTA EN BURO
        	sRegistroPaso += DirMod.DCTCreditBureau__c != null ? String.valueOf(DirMod.DCTCreditBureau__c) + '|' : '|';
	        System.debug('EN DCT_ReporteCamposModifDirComercial_bch DirMod.DCTCreditBureau__c: ' + DirMod.DCTCreditBureau__c);
	        //ES VIP
        	sRegistroPaso += DirMod.DCTVIP__c != null ? String.valueOf(DirMod.DCTVIP__c) + '|' : '|';
	        System.debug('EN DCT_ReporteCamposModifDirComercial_bch DirMod.DCTVIP__c: ' + DirMod.DCTVIP__c);
	        //TIENE AVL
        	sRegistroPaso += DirMod.DCTAVL__c != null ? String.valueOf(DirMod.DCTAVL__c) + '|' : '|';
	        System.debug('EN DCT_ReporteCamposModifDirComercial_bch DirMod.DCTAVL__c: ' + DirMod.DCTAVL__c);
	        //REPRESENTANTE LEGAL
        	sRegistroPaso += DirMod.DCTLegalRepresentative__c != null ? String.valueOf(DirMod.DCTLegalRepresentative__c) + '|' : '|';
	        System.debug('EN DCT_ReporteCamposModifDirComercial_bch DirMod.DCTLegalRepresentative__c: ' + DirMod.DCTLegalRepresentative__c);
	        //BENEFICIOS
        	sRegistroPaso += DirMod.DCTBenefits__c != null ? String.valueOf(DirMod.DCTBenefits__c) + '|' : '|';
	        System.debug('EN DCT_ReporteCamposModifDirComercial_bch DirMod.DCTBenefits__c: ' + DirMod.DCTBenefits__c);
	        //FECHA REGISTRO
        	sRegistroPaso += DirMod.DCTRegistrationDate__c != null ? formateaFecha(DirMod.DCTRegistrationDate__c) + '|' : '|';
	        System.debug('EN DCT_ReporteCamposModifDirComercial_bch DirMod.DCTRegistrationDate__c: ' + DirMod.DCTRegistrationDate__c);
	        //Fecha Modificación LastModifiedDate
        	sRegistroPaso += DirMod.DCTLowDateAccuont__c != null ? formateaFechaHora(DirMod.LastModifiedDate) + '|' : '|';
	        System.debug('EN DCT_ReporteCamposModifDirComercial_bch DirMod.LastModifiedDate: ' + formateaFechaHora(DirMod.LastModifiedDate));	        
	        //ULTIMO USUARIO MODIFICO
        	sRegistroPaso += DirMod.LastModifiedBy.Name != null ? String.valueOf(DirMod.LastModifiedBy.Name) + '|' : '|';
	        System.debug('EN DCT_ReporteCamposModifDirComercial_bch DirMod.DCTVPNActivation__c: ' + DirMod.DCTVPNActivation__c);
	        //USUARIO UNIVERSAL ULTIMO USUARIO MODIFICO
        	sRegistroPaso += DirMod.LastModifiedBy.DCTXO__c != null ? String.valueOf(DirMod.LastModifiedBy.DCTXO__c) + '|' : '|';
	        System.debug('EN DCT_ReporteCamposModifDirComercial_bch DirMod.DCTVPNActivation__c: ' + DirMod.DCTVPNActivation__c);
	        //FECHA DE BAJA
        	sRegistroPaso += DirMod.DCTLowDateAccuont__c != null ? formateaFecha(DirMod.DCTLowDateAccuont__c) + '|' : '|';
	        System.debug('EN DCT_ReporteCamposModifDirComercial_bch DirMod.DCTLowDateAccuont__c: ' + DirMod.DCTLowDateAccuont__c);
	        //ACTIVAR VPN
        	sRegistroPaso += DirMod.DCTVPNActivation__c != null ? String.valueOf(DirMod.DCTVPNActivation__c) + '|' : '|';
	        System.debug('EN DCT_ReporteCamposModifDirComercial_bch DirMod.DCTVPNActivation__c: ' + DirMod.DCTVPNActivation__c);
	        //CICLO DE FACTURACION
        	sRegistroPaso += DirMod.DCTBillingCycle__c != null ? String.valueOf(DirMod.DCTBillingCycle__c) + '|' : '|';
	        System.debug('EN DCT_ReporteCamposModifDirComercial_bch DirMod.DCTBillingCycle__c: ' + DirMod.DCTBillingCycle__c);
	        //CLASE DE CREDITO
        	sRegistroPaso += DirMod.DCTCreditClass__c != null ? String.valueOf(DirMod.DCTCreditClass__c) + '|' : '|';
	        System.debug('EN DCT_ReporteCamposModifDirComercial_bch DirMod.DCTCreditClass__c: ' + DirMod.DCTCreditClass__c);
	        //TIPO DE CUENTA
        	sRegistroPaso += DirMod.DCTAccountType__c != null ? String.valueOf(DirMod.DCTAccountType__c) + '|' : '|';
	        System.debug('EN DCT_ReporteCamposModifDirComercial_bch DirMod.DCTAccountType__c: ' + DirMod.DCTAccountType__c);	        
	        //EXENTA FIANZA
        	sRegistroPaso += DirMod.DCTExemptBail__c != null ? String.valueOf(DirMod.DCTExemptBail__c) + '|' : '|';
	        System.debug('EN DCT_ReporteCamposModifDirComercial_bch DirMod.DCTExemptBail__c: ' + DirMod.DCTExemptBail__c);
	        //COMENTARIOS
        	sRegistroPaso += DirMod.DCTComments__c != null ? String.valueOf(DirMod.DCTComments__c) + '|' : '|';
	        System.debug('EN DCT_ReporteCamposModifDirComercial_bch DirMod.DCTComments__c: ' + DirMod.DCTComments__c);

	        //DATOS DE LOS PLANES
	        String sGrupoCategoria = '';
	        String sTarifa = '';	        
	        String sClavePlan = '';	        
	        String sNombrePlan = '';
	        String sPlazo = '';	        
	        String sGerente = '';
	        String sFechaAutoriza = '';	 
	        Integer iTotLineasActivas = 0;       
	        Integer iTotLineasAutoriz = 0;	        
	        //Aqui metemos los planes si es que tiene algo
	        if (!DirMod.Lineas_Autorizadas__r.isEmpty()){
	        	Integer iCntLineas = 0;
	        	for (DCTAuthorizedLines__c LineaAutoPlan : DirMod.Lineas_Autorizadas__r){
			        System.debug('EN DCT_ReporteCamposModifDirComercial_bch LineaAutoPlan.RecordType.Name: ' + LineaAutoPlan.RecordType.Name);	        		
		        	if (LineaAutoPlan.RecordType.Name == 'Plan'){
			        	System.debug('EN DCT_ReporteCamposModifDirComercial_bch DescripcionGrupoPlan__c: ' + LineaAutoPlan.Plan__r.DescripcionGrupoPlan__c);		        		
			        	sGrupoCategoria += LineaAutoPlan.Plan__r.DescripcionGrupoPlan__c != null ? String.valueOf(LineaAutoPlan.Plan__r.DescripcionGrupoPlan__c) + ',' : ',';
			        	sTarifa += LineaAutoPlan.Plan__r.ClaveTarifa__c != null ? String.valueOf(LineaAutoPlan.Plan__r.ClaveTarifa__c) + ',' : ',';
			        	sClavePlan += LineaAutoPlan.Plan__r.ClavePlan__c != null ? String.valueOf(LineaAutoPlan.Plan__r.ClavePlan__c) + ',' : ',';
			        	sNombrePlan += LineaAutoPlan.Plan__r.DescripcionPlan__c != null ? String.valueOf(LineaAutoPlan.Plan__r.DescripcionPlan__c) + ',' : ',';		        	
			        	sPlazo += LineaAutoPlan.Plan__r.DCTTerm__c != null ? String.valueOf(LineaAutoPlan.Plan__r.DCTTerm__c) + ',' : ',';
			        	if ( LineaAutoPlan.DCTAuthorizationDate__c != null){			        		
			        		sGerente += mapDatosUsuario.containsKey(DirMod.OwnerId) ? mapDatosUsuario.get(DirMod.OwnerId).Manager.Name + ',' : ',';
			        		System.debug('EN DCT_ReporteCamposModifDirComercial_bch mapDatosUsuario: ' + mapDatosUsuario);			        		
			        		System.debug('EN DCT_ReporteCamposModifDirComercial_bch DirMod.OwnerId: ' + DirMod.OwnerId + ' sGerente: ' + sGerente);			        					        	
			        	}else
			        		sGerente += ',';			        		
			        	//sGerente += LineaAutoPlan.DCTSubdirector__r.Name != null ? String.valueOf(LineaAutoPlan.DCTSubdirector__r.Name) + ',' : ',';
			        	sFechaAutoriza += LineaAutoPlan.DCTAuthorizationDate__c != null ? formateaFecha(LineaAutoPlan.DCTAuthorizationDate__c) + ',' : ',';		        	
		        	}//Fin si LineaAutoPlan.RecordType.Name == 'Plan'
		        	if (LineaAutoPlan.RecordType.Name == 'Lineas Autorizadas'){
		        		if (iCntLineas == 0){
				       		if (LineaAutoPlan.Status__c == 'AUTORIZADO'){
								iTotLineasActivas = (LineaAutoPlan.DCTActiveLines__c != null ? Integer.valueOf(LineaAutoPlan.DCTActiveLines__c) : 0) + (LineaAutoPlan.DCTAuthorizedLines__c != null ? Integer.valueOf(LineaAutoPlan.DCTAuthorizedLines__c) : 0);
								iTotLineasAutoriz += LineaAutoPlan.DCTAuthorizedLines__c != null ? Integer.valueOf(LineaAutoPlan.DCTAuthorizedLines__c) : 0;
				       		}//Fin si LineaAutoPlan.Status__c == 'AUTORIZADO'
				       		if (LineaAutoPlan.Status__c != 'AUTORIZADO')
								iTotLineasActivas = LineaAutoPlan.DCTActiveLines__c != null ? Integer.valueOf(LineaAutoPlan.DCTActiveLines__c) : 0;
		        		}//Fin si iCntLineas == 0
		        		if (iCntLineas > 0){
					        System.debug('EN DCT_ReporteCamposModifDirComercial_bch LineaAutoPlan.Status__c: ' + LineaAutoPlan.Status__c);		        		
				       		if (LineaAutoPlan.Status__c == 'AUTORIZADO'){
								iTotLineasActivas += (LineaAutoPlan.DCTActiveLines__c != null ? Integer.valueOf(LineaAutoPlan.DCTActiveLines__c) : 0) + (LineaAutoPlan.DCTAuthorizedLines__c != null ? Integer.valueOf(LineaAutoPlan.DCTAuthorizedLines__c) : 0);
								iTotLineasAutoriz += LineaAutoPlan.DCTAuthorizedLines__c != null ? Integer.valueOf(LineaAutoPlan.DCTAuthorizedLines__c) : 0;
				       		}//Fin si LineaAutoPlan.Status__c == 'AUTORIZADO'
		        		}//Fin si iCntLineas > 0
						iCntLineas++;	
		        	}//Fin si LineaAutoPlan.RecordType.Name == 'Lineas Autorizadas'
	        	}
		        System.debug('EN DCT_ReporteCamposModifDirComercial_bch sGrupoCategoria: ' + sGrupoCategoria);	        	
		        System.debug('EN DCT_ReporteCamposModifDirComercial_bch sTarifa: ' + sTarifa);		        
		        System.debug('EN DCT_ReporteCamposModifDirComercial_bch sClavePlan: ' + sClavePlan);		        
		        System.debug('EN DCT_ReporteCamposModifDirComercial_bch sNombrePlan: ' + sNombrePlan);		        
		        System.debug('EN DCT_ReporteCamposModifDirComercial_bch sPlazo: ' + sPlazo);		        
		        System.debug('EN DCT_ReporteCamposModifDirComercial_bch sGerente: ' + sGerente);		        
		        System.debug('EN DCT_ReporteCamposModifDirComercial_bch sFechaAutoriza: ' + sFechaAutoriza);		        
		        System.debug('EN DCT_ReporteCamposModifDirComercial_bch iTotLineasActivas: ' + iTotLineasActivas);
		        System.debug('EN DCT_ReporteCamposModifDirComercial_bch iTotLineasAutoriz: ' + iTotLineasAutoriz);
	        	//Quita la ultima coma de cada renglon
	        	sGrupoCategoria = sGrupoCategoria.substring(0, sGrupoCategoria.length()-1);
	        	sTarifa = sTarifa.substring(0, sTarifa.length()-1);	        	
	        	sClavePlan = sClavePlan.substring(0, sClavePlan.length()-1);	        	
	        	sNombrePlan = sNombrePlan.substring(0, sNombrePlan.length()-1);	        	
	        	sPlazo = sPlazo.substring(0, sPlazo.length()-1);
	        	sGerente = sGerente.substring(0, sGerente.length()-1);	        	
	        	sFechaAutoriza = sFechaAutoriza.substring(0, sFechaAutoriza.length()-1);
	        }//Fin si DirMod.Lineas_Autorizadas__r.isEmpty()
	        
	        //GRUPO O CATEGORIA DE DATOS
        	sRegistroPaso += sGrupoCategoria != null ? String.valueOf(sGrupoCategoria) + '|' : '|';
	        System.debug('EN DCT_ReporteCamposModifDirComercial_bch sGrupoCategoria: ' + sGrupoCategoria);
	        //TARIFA/PLAN AUTORIZADO
        	sRegistroPaso += sTarifa != null ? String.valueOf(sTarifa) + '|' : '|';
	        System.debug('EN DCT_ReporteCamposModifDirComercial_bch sTarifa: ' + sTarifa);
	        //CLAVE DEL PLAN
        	sRegistroPaso += sClavePlan != null ? String.valueOf(sClavePlan) + '|' : '|';
	        System.debug('EN DCT_ReporteCamposModifDirComercial_bch sClavePlan: ' + sClavePlan);
	        //NOMBRE DEL PLAN
        	sRegistroPaso += sNombrePlan != null ? String.valueOf(sNombrePlan) + '|' : '|';
	        System.debug('EN DCT_ReporteCamposModifDirComercial_bch sNombrePlan: ' + sNombrePlan);
	        //PLAZO
        	sRegistroPaso += sPlazo != null ? String.valueOf(sPlazo) + '|' : '|';
	        System.debug('EN DCT_ReporteCamposModifDirComercial_bch sPlazo: ' + sPlazo);
	        //GERENTE
        	sRegistroPaso += sGerente != null ? String.valueOf(sGerente) + '|' : '|';
	        System.debug('EN DCT_ReporteCamposModifDirComercial_bch sGerente: ' + sGerente);
	        //FECHA DE AUTORIZACION
        	sRegistroPaso += sFechaAutoriza != null ? String.valueOf(sFechaAutoriza) + '|' : '|';
	        System.debug('EN DCT_ReporteCamposModifDirComercial_bch sFechaAutoriza: ' + sFechaAutoriza);

	        //DATOS DE LA FUERZA DE VENTA
	        //TRATO COMPARTIDO
        	sRegistroPaso += DirMod.DCTSharedTreatment__c != null ? String.valueOf(DirMod.DCTSharedTreatment__c) + '|' : '|';
	        System.debug('EN DCT_ReporteCamposModifDirComercial_bch DirMod.DCTSharedTreatment__c: ' + DirMod.DCTSharedTreatment__c);

	        String sPrepagoFuerzaVentaPrinc = '';				       
	        String sClaveFuerzaVentaPrinc = '';	        
	        String sDescFuerzaVentaPrinc = '';
	        //Fuerza de venta Principal
	        if (DirMod.DCT_CatalogoFuerzaVenta__c != null){
				sPrepagoFuerzaVentaPrinc += DirMod.DCT_CatalogoFuerzaVenta__r.DCT_PrepagoSiapID__c != null ? String.valueOf(DirMod.DCT_CatalogoFuerzaVenta__r.DCT_PrepagoSiapID__c) + ',' : ',';
	        	sClaveFuerzaVentaPrinc += DirMod.DCT_CatalogoFuerzaVenta__r.Name != null ? String.valueOf(DirMod.DCT_CatalogoFuerzaVenta__r.Name) + ',' : ',';
	        	sDescFuerzaVentaPrinc += DirMod.DCTDistribuidorPrincipal__c != null ? String.valueOf(DirMod.DCTDistribuidorPrincipal__c) + ',' : ',';
	        }//Fin si DirMod.DCT_CatalogoFuerzaVenta__c != null
	        if (DirMod.DCT_CatalogoFuerzaVenta__c == null){
	        	sPrepagoFuerzaVentaPrinc += ','; 
	        	sClaveFuerzaVentaPrinc += ',';
	        	sDescFuerzaVentaPrinc += ',';
	        }
	        //Fuerza de venta Secundaria
	        if (DirMod.DCTCatalogoFuerzaVenta2__c != null){
				sPrepagoFuerzaVentaPrinc += DirMod.DCTCatalogoFuerzaVenta2__r.DCT_PrepagoSiapID__c != null ? String.valueOf(DirMod.DCTCatalogoFuerzaVenta2__r.DCT_PrepagoSiapID__c) + ',' : ',';
	        	sClaveFuerzaVentaPrinc += DirMod.DCTCatalogoFuerzaVenta2__r.Name != null ? String.valueOf(DirMod.DCTCatalogoFuerzaVenta2__r.Name) + ',' : ',';
	        	sDescFuerzaVentaPrinc += DirMod.DCTDistribuidorSecundario__c != null ? String.valueOf(DirMod.DCTDistribuidorSecundario__c) : ',';
	        }//Fin si DirMod.FuerzaVentaSecundario__c != null
	        if (DirMod.DCTCatalogoFuerzaVenta2__c == null){
				sPrepagoFuerzaVentaPrinc += ',';
	        	sClaveFuerzaVentaPrinc += ',';	        
	        	sDescFuerzaVentaPrinc += ',';
	        }
        	sPrepagoFuerzaVentaPrinc = sPrepagoFuerzaVentaPrinc.substring(0, sPrepagoFuerzaVentaPrinc.length()-1);	        	
        	sPrepagoFuerzaVentaPrinc = sPrepagoFuerzaVentaPrinc.substring(0, sPrepagoFuerzaVentaPrinc.length()-1);	        	
        	sPrepagoFuerzaVentaPrinc = sPrepagoFuerzaVentaPrinc.substring(0, sPrepagoFuerzaVentaPrinc.length()-1);
	        
	        //Prepago SIAP ID Prepago SIAP ID
        	sRegistroPaso += String.valueOf(sPrepagoFuerzaVentaPrinc) + '|';
	        System.debug('EN DCT_ReporteCamposModifDirComercial_bch sPrepagoFuerzaVentaPrinc: ' + sPrepagoFuerzaVentaPrinc);
	        //FUERZA VENTA
        	sRegistroPaso += String.valueOf(sClaveFuerzaVentaPrinc) + '|';
	        System.debug('EN DCT_ReporteCamposModifDirComercial_bch sClaveFuerzaVentaPrinc: ' + sClaveFuerzaVentaPrinc);
	        //NOMBRE DAT
        	sRegistroPaso += String.valueOf(sDescFuerzaVentaPrinc) + '|';
	        System.debug('EN DCT_ReporteCamposModifDirComercial_bch sDescFuerzaVentaPrinc: ' + sDescFuerzaVentaPrinc);

	        //DATOS DE IMPLANT			
	        //SERVICIOS
	        String sServiciosImplant = '';
	        sServiciosImplant += DirMod.DCTServices1__c != null ? String.valueOf(DirMod.DCTServices1__c) + ',' : ',';
	        sServiciosImplant += DirMod.DCTServices2__c != null ? String.valueOf(DirMod.DCTServices2__c) : '';
        	sRegistroPaso += sServiciosImplant + '|';	        
	        System.debug('EN DCT_ReporteCamposModifDirComercial_bch sServiciosImplant: ' + sServiciosImplant);
	        //NOMBRE DE INPLANT
	        String sNombreImplant = '';
	        sNombreImplant += DirMod.DCTInplantName1__c != null ? String.valueOf(DirMod.DCTInplantName1__c) + ',' : ',';
	        sNombreImplant += DirMod.DCTInplantName2__c != null ? String.valueOf(DirMod.DCTInplantName2__c) : '';
        	sRegistroPaso += sNombreImplant + '|';
	        System.debug('EN DCT_ReporteCamposModifDirComercial_bch sNombreImplant: ' + sNombreImplant);
			//TELEFONO INPLANT
	        String sTelefonoImplant = '';	        
        	sTelefonoImplant += DirMod.DCTInplantPhone1__c != null ? String.valueOf(DirMod.DCTInplantPhone1__c) + ',' : ',';
        	sTelefonoImplant += DirMod.DCTInplantPhone2__c != null ? String.valueOf(DirMod.DCTInplantPhone2__c) : '';
        	sRegistroPaso += sTelefonoImplant + '|';        	
	        System.debug('EN DCT_ReporteCamposModifDirComercial_bch sTelefonoImplant: ' + sTelefonoImplant);
	        //EXTENSION INPLANT
	        String sExtImplant = '';	        
        	sExtImplant += DirMod.DCTExt1__c != null ? String.valueOf(DirMod.DCTExt1__c) + ',' : ',';
        	sExtImplant += DirMod.DCTExt2__c != null ? String.valueOf(DirMod.DCTExt2__c) : '';        	
        	sRegistroPaso += sExtImplant + '|';        	
	        System.debug('EN DCT_ReporteCamposModifDirComercial_bch sExtImplant: ' + sExtImplant);
	        //CELULAR INPLANT
	        String sCelImplant = '';	        
        	sCelImplant += DirMod.DCTInplantmobile1__c != null ? String.valueOf(DirMod.DCTInplantmobile1__c) + ',' : ',';
        	sCelImplant += DirMod.DCTInplantmobile2__c != null ? String.valueOf(DirMod.DCTInplantmobile2__c) : '';
        	sRegistroPaso += sCelImplant + '|';        	
	        System.debug('EN DCT_ReporteCamposModifDirComercial_bch sCelImplant: ' + sCelImplant);
	        //CORREO ELECTRONICO INPLANT
	        String sEmailImplant = '';	        
        	sEmailImplant += DirMod.DCTInplantEmail1__c != null ? String.valueOf(DirMod.DCTInplantEmail1__c) + ',' : ',';
        	sEmailImplant += DirMod.DCTInplantEmail2__c != null ? String.valueOf(DirMod.DCTInplantEmail2__c) : '';        	
        	sRegistroPaso += sEmailImplant + '|';
	        System.debug('EN DCT_ReporteCamposModifDirComercial_bch sEmailImplant: ' + sEmailImplant);

			//Para la parte de Inplant
	        String sFzaVtaPrin = ''; 
	        //Fuerza de venta Principal
	        if (DirMod.DCT_CatalogoFuerzaVenta__c != null)
				sFzaVtaPrin += DirMod.DCT_CatalogoFuerzaVenta__r.Name != null ? String.valueOf(DirMod.DCT_CatalogoFuerzaVenta__r.Name) + ',' : ',';
	        if (DirMod.DCT_CatalogoFuerzaVenta__c == null)
	        	sFzaVtaPrin += ','; 
	        //Fuerza de venta Secundaria
	        if (DirMod.DCTCatalogoFuerzaVenta2__c != null)
				sFzaVtaPrin += DirMod.DCTCatalogoFuerzaVenta2__r.Name != null ? String.valueOf(DirMod.DCTCatalogoFuerzaVenta2__r.Name) : '';
	        if (DirMod.DCTCatalogoFuerzaVenta2__c == null)
				sFzaVtaPrin += ',';
			//DISTRIBUIDOR INPLANT	        
	        System.debug('EN DCT_ReporteCamposModifDirComercial_bch sFzaVtaPrin: ' + sFzaVtaPrin);	        	
        	sRegistroPaso += sFzaVtaPrin + '|';
			//FECHA DE REGISTRO INPLANT
	        String sFechaRegImplant = '';
	        sFechaRegImplant += DirMod.DCTInplantDate1__c != null ? formateaFecha(DirMod.DCTInplantDate1__c) + ',' : ',';
	        sFechaRegImplant += DirMod.DCTInplantDate2__c != null ? formateaFecha(DirMod.DCTInplantDate2__c) : '';
	        System.debug('EN DCT_ReporteCamposModifDirComercial_bch sFechaRegImplant: ' + sFechaRegImplant);	        
        	sRegistroPaso += sFechaRegImplant + '|';
        		        	        		        		        
			//INVESTIGACIONES
			//LEYENDA DE INVESTIGACION
        	sRegistroPaso += DirMod.DCTResearchLegend__c != null ? String.valueOf(DirMod.DCTResearchLegend__c) + '|' : '|';
	        System.debug('EN DCT_ReporteCamposModifDirComercial_bch DirMod.DCTResearchLegend__c: ' + DirMod.DCTResearchLegend__c);
	        //RESULTADO DE LA VERIFICACION
        	sRegistroPaso += DirMod.DCTResultVerification__c != null ? String.valueOf(DirMod.DCTResultVerification__c) + '|' : '|';
	        System.debug('EN DCT_ReporteCamposModifDirComercial_bch DirMod.DCTResultVerification__c: ' + DirMod.DCTResultVerification__c);
	        //MOTIVO DE RECHAZO
        	//sRegistroPaso += DirMod.DCTReasonRejection__c != null ? String.valueOf(DirMod.DCTReasonRejection__c) + '|' : '|';
	        //System.debug('EN DCT_ReporteCamposModifDirComercial_bch DirMod.DCTReasonRejection__c: ' + DirMod.DCTReasonRejection__c);
	        //INVESTIGACION
        	sRegistroPaso += DirMod.DCTInvestigation__c != null ? String.valueOf(DirMod.DCTInvestigation__c) + '|' : '|';
	        System.debug('EN DCT_ReporteCamposModifDirComercial_bch DirMod.DCTInvestigation__c: ' + DirMod.DCTInvestigation__c);
	        //COMENTARIOS
        	sRegistroPaso += DirMod.DCTCommentsInvestigation__c != null ? String.valueOf(DirMod.DCTCommentsInvestigation__c) + '|' : '|';
	        System.debug('EN DCT_ReporteCamposModifDirComercial_bch DirMod.DCTCommentsInvestigation__c: ' + DirMod.DCTCommentsInvestigation__c);
	        
	        //TOTAL LINEAS ACTIVAS
        	sRegistroPaso += iTotLineasActivas != null ? String.valueOf(iTotLineasActivas) + '|' : '|';
	        System.debug('EN DCT_ReporteCamposModifDirComercial_bch iTotLineasActivas: ' + iTotLineasActivas);
			//TIPO DE AUTORIZACION
        	sRegistroPaso += DirMod.DCTTypeAuthorization__c != null ? String.valueOf(DirMod.DCTTypeAuthorization__c) + '|' : '|';
	        System.debug('EN DCT_ReporteCamposModifDirComercial_bch DirMod.DCTTypeAuthorization__c: ' + DirMod.DCTTypeAuthorization__c);			
			//FECHA DE AUTORIZACION
        	sRegistroPaso += DirMod.DCTAuthorizationDateVoBoManagement__c != null ? formateaFecha(DirMod.DCTAuthorizationDateVoBoManagement__c) + '|' : '|';
	        System.debug('EN DCT_ReporteCamposModifDirComercial_bch DirMod.DCTAuthorizationDateVoBoManagement__c: ' + DirMod.DCTAuthorizationDateVoBoManagement__c);
	        
	        //DATOS DE LAS LINEAS SOLICITADAS
	        String sLineasActivas = '';
	        String sLineasSolicitadas = '';	        
	        String sEstatus = '';	        
	        String sFecha = '';
	        String sAutorizadasPor = '';	        
	        String sLineasAutorizadas = '';	        
	        //Aqui metemos los planes si es que tiene algo
	        if (!DirMod.Lineas_Autorizadas__r.isEmpty()){
	        	Integer iCntLineas = 0;
	        	for (DCTAuthorizedLines__c LineaAutoPlan : DirMod.Lineas_Autorizadas__r){
			        System.debug('EN DCT_ReporteCamposModifDirComercial_bch LineaAutoPlan.RecordType.Name: ' + LineaAutoPlan.RecordType.Name);	        		
		        	if (LineaAutoPlan.RecordType.Name == 'Lineas Autorizadas'){
		        		if (iCntLineas == 0){
				       		if (LineaAutoPlan.Status__c == 'AUTORIZADO'){
								iTotLineasActivas = (LineaAutoPlan.DCTActiveLines__c != null ? Integer.valueOf(LineaAutoPlan.DCTActiveLines__c) : 0) + (LineaAutoPlan.DCTAuthorizedLines__c != null ? Integer.valueOf(LineaAutoPlan.DCTAuthorizedLines__c) : 0);
								iTotLineasAutoriz += LineaAutoPlan.DCTAuthorizedLines__c != null ? Integer.valueOf(LineaAutoPlan.DCTAuthorizedLines__c) : 0;
								//LINEAS ACTIVAS
					        	sLineasActivas += (LineaAutoPlan.DCTActiveLines__c != null ? Integer.valueOf(LineaAutoPlan.DCTActiveLines__c) : 0) + (LineaAutoPlan.DCTAuthorizedLines__c != null ? Integer.valueOf(LineaAutoPlan.DCTAuthorizedLines__c) + ',' : ',');								
				       		}//Fin si LineaAutoPlan.Status__c == 'AUTORIZADO'
				       		if (LineaAutoPlan.Status__c != 'AUTORIZADO'){
								iTotLineasActivas = LineaAutoPlan.DCTActiveLines__c != null ? Integer.valueOf(LineaAutoPlan.DCTActiveLines__c) : 0;
								//LINEAS ACTIVAS								
					        	sLineasActivas += LineaAutoPlan.DCTActiveLines__c != null ? String.valueOf(LineaAutoPlan.DCTActiveLines__c) + ',' : ',';								
				       		}
		        		}//Fin si iCntLineas == 0
		        		if (iCntLineas > 0){
					        System.debug('EN DCT_ReporteCamposModifDirComercial_bch LineaAutoPlan.Status__c: ' + LineaAutoPlan.Status__c);		        		
				       		if (LineaAutoPlan.Status__c == 'AUTORIZADO'){
								iTotLineasActivas += (LineaAutoPlan.DCTActiveLines__c != null ? Integer.valueOf(LineaAutoPlan.DCTActiveLines__c) : 0) + (LineaAutoPlan.DCTAuthorizedLines__c != null ? Integer.valueOf(LineaAutoPlan.DCTAuthorizedLines__c) : 0);
								iTotLineasAutoriz += LineaAutoPlan.DCTAuthorizedLines__c != null ? Integer.valueOf(LineaAutoPlan.DCTAuthorizedLines__c) : 0;
								//LINEAS ACTIVAS
					        	sLineasActivas += (LineaAutoPlan.DCTActiveLines__c != null ? Integer.valueOf(LineaAutoPlan.DCTActiveLines__c) : 0) + (LineaAutoPlan.DCTAuthorizedLines__c != null ? Integer.valueOf(LineaAutoPlan.DCTAuthorizedLines__c) + ',' : ',');								
				       		}//Fin si LineaAutoPlan.Status__c == 'AUTORIZADO'
				       		if (LineaAutoPlan.Status__c != 'AUTORIZADO')
								//LINEAS ACTIVAS
					        	sLineasActivas += LineaAutoPlan.DCTActiveLines__c != null ? String.valueOf(LineaAutoPlan.DCTActiveLines__c) + ',' : ',';				       						       		
		        		}//Fin si iCntLineas > 0
						iCntLineas++;
						
						//LINEAS SOLICITADAS
						sLineasSolicitadas += LineaAutoPlan.DCTAuthorizedLines__c != null ? String.valueOf(LineaAutoPlan.DCTAuthorizedLines__c) + ',' : ',';
						//ESTATUS
						sEstatus += LineaAutoPlan.Status__c != null ? String.valueOf(LineaAutoPlan.Status__c) + ',' : ',';
						//FECHA
						sFecha += LineaAutoPlan.DCTAuthorizationDate__c != null ? formateaFecha(LineaAutoPlan.DCTAuthorizationDate__c) + ',' : ',';
						//AUTORIZADO POR
						sAutorizadasPor += LineaAutoPlan.Aprobador__r.Name != null ? LineaAutoPlan.Aprobador__r.Name + ',' : ',';
						//LINEAS AUTORIZADAS
						sLineasAutorizadas += LineaAutoPlan.DCTTotalAuthorizedLines__c != null ? LineaAutoPlan.DCTTotalAuthorizedLines__c + ',' : ',';
						
		        	}//Fin si LineaAutoPlan.RecordType.Name == 'Lineas Autorizadas'
	        	}
		        System.debug('EN DCT_ReporteCamposModifDirComercial_bch sLineasActivas: ' + sLineasActivas);	        	
		        System.debug('EN DCT_ReporteCamposModifDirComercial_bch sLineasSolicitadas: ' + sLineasSolicitadas);		        
		        System.debug('EN DCT_ReporteCamposModifDirComercial_bch sEstatus: ' + sEstatus);		        
		        System.debug('EN DCT_ReporteCamposModifDirComercial_bch sFecha: ' + sFecha);		        
		        System.debug('EN DCT_ReporteCamposModifDirComercial_bch sAutorizadasPor: ' + sAutorizadasPor);		        
	        	//Quita la ultima coma de cada renglon
	        	sLineasActivas = sLineasActivas.substring(0, sLineasActivas.length()-1);
	        	sLineasSolicitadas = sLineasSolicitadas.substring(0, sLineasSolicitadas.length()-1);	        	
	        	sEstatus = sEstatus.substring(0, sEstatus.length()-1);	        	
	        	sFecha = sFecha.substring(0, sFecha.length()-1);	        	
	        	sAutorizadasPor = sAutorizadasPor.substring(0, sAutorizadasPor.length()-1);	        	
	        	sLineasAutorizadas = sLineasAutorizadas.substring(0, sLineasAutorizadas.length()-1);
	        }//Fin si DirMod.Lineas_Autorizadas__r.isEmpty()

			//LINEAS ACTIVAS
        	sRegistroPaso += sLineasActivas != null ? String.valueOf(sLineasActivas) + '|' : '|';
	        System.debug('EN DCT_ReporteCamposModifDirComercial_bch sLineasActivas: ' + sLineasActivas);
			//LINEAS SOLICITADAS
        	sRegistroPaso += sLineasSolicitadas != null ? String.valueOf(sLineasSolicitadas) + '|' : '|';
	        System.debug('EN DCT_ReporteCamposModifDirComercial_bch sLineasSolicitadas: ' + sLineasSolicitadas);
			//ESTATUS
        	sRegistroPaso += sEstatus != null ? String.valueOf(sEstatus) + '|' : '|';
	        System.debug('EN DCT_ReporteCamposModifDirComercial_bch sEstatus: ' + sEstatus);
	        //FECHA
        	sRegistroPaso += sFecha != null ? String.valueOf(sFecha) + '|' : '|';
	        System.debug('EN DCT_ReporteCamposModifDirComercial_bch sFecha: ' + sFecha);
	        //AUTORIZADO POR
        	sRegistroPaso += sAutorizadasPor != null ? String.valueOf(sAutorizadasPor) + '|' : '|';
	        System.debug('EN DCT_ReporteCamposModifDirComercial_bch sAutorizadasPor: ' + sAutorizadasPor);
	        //LINEAS AUTORIZADAS
        	//sRegistroPaso += DirMod.DCTTotLineasAutorInvest__c != null ? String.valueOf(DirMod.DCTTotLineasAutorInvest__c) + '|' : '|';
        	sRegistroPaso += sLineasAutorizadas != null ? String.valueOf(sLineasAutorizadas) + '|' : '|';
	        System.debug('EN DCT_ReporteCamposModifDirComercial_bch sLineasAutorizadas: ' + sLineasAutorizadas);
	        //TOTAL DE LINEAS AUTORIZADAS
        	sRegistroPaso += iTotLineasAutoriz != null ? String.valueOf(iTotLineasAutoriz) + '|' : '|';
	        System.debug('EN DCT_ReporteCamposModifDirComercial_bch iTotLineasAutoriz: ' + iTotLineasAutoriz);
	        
	        //DATOS DEL PROPIETARIO
	        //Ve si el ouwner esciste en el mapa de mapDatosUsuario
	        if (mapDatosUsuario.containsKey(DirMod.OwnerId)){
	        	//NOMBRE COMPLETO DEL PROPIETARIO
	        	sRegistroPaso += mapDatosUsuario.get(DirMod.OwnerId).Name != null ? String.valueOf(mapDatosUsuario.get(DirMod.OwnerId).Name) + '|' : '|';
	        	System.debug('EN DCT_ReporteCamposModifDirComercial_bch mapDatosUsuario.get(DirMod.OwnerId).Name: ' + mapDatosUsuario.get(DirMod.OwnerId).Name);
				//USUARIO UNIVERSAL DEL PROPIETARIO
	        	sRegistroPaso += mapDatosUsuario.get(DirMod.OwnerId).DCTXO__c != null ? String.valueOf(mapDatosUsuario.get(DirMod.OwnerId).DCTXO__c) + '|' : '|';
	        	System.debug('EN DCT_ReporteCamposModifDirComercial_bch mapDatosUsuario.get(DirMod.OwnerId).DCTXO__c: ' + mapDatosUsuario.get(DirMod.OwnerId).DCTXO__c);
	        	//FUERZA DE VENTAS DEL PROPIETARIO
	        	sRegistroPaso += mapDatosUsuario.get(DirMod.OwnerId).DCTVT__c != null ? String.valueOf(mapDatosUsuario.get(DirMod.OwnerId).DCTVT__c) + '|' : '|';
	        	System.debug('EN DCT_ReporteCamposModifDirComercial_bch mapDatosUsuario.get(DirMod.OwnerId).DCTXO__c: ' + mapDatosUsuario.get(DirMod.OwnerId).DCTXO__c);
	        }//Fin si mapDatosUsuario.containsKey(DirMod.OwnerId)	   
			
			//JEFE DE DATOS
        	sRegistroPaso += DirMod.DCT_JefeVoz__c != null ? String.valueOf(DirMod.DCT_JefeVoz__c) + '|' : '|';
	        System.debug('EN DCT_ReporteCamposModifDirComercial_bch DirMod.DCT_JefeVoz__c: ' + DirMod.DCT_JefeVoz__c);
			//FUERZA DE VENTA DE SMD
        	sRegistroPaso += DirMod.DCT_FuerzaVentaSmd__c != null ? String.valueOf(DirMod.DCT_FuerzaVentaSmd__c) + '|' : '|';
	        System.debug('EN DCT_ReporteCamposModifDirComercial_bch DirMod.DCT_FuerzaVentaSmd__c: ' + DirMod.DCT_FuerzaVentaSmd__c);
			
			
	        //DATOS DE LOS CONTATOS DEL DIRECTORIO
	        String sContactName = '';
	        String sContactPuesto = '';	        
	        String sContactTipo = '';	        
	        String sContactCel = '';
	        String sContactNIP = '';	        
	        String sContactEmail = '';	        
	        String sContactAutorizaInfo = '';	        
	        String sContactNotas = '';	        
	        //Aqui metemos los planes si es que tiene algo
	        if (!DirMod.DirectorioComercial_Contactos__r.isEmpty()){
	        	for (Contact LineaAutoPlan : DirMod.DirectorioComercial_Contactos__r){
		        	sContactName += LineaAutoPlan.Name != null ? String.valueOf(LineaAutoPlan.Name) + ',' : ',';
		        	sContactPuesto += LineaAutoPlan.Posicion__c != null ? String.valueOf(LineaAutoPlan.Posicion__c) + ',' : ',';
		        	sContactTipo += LineaAutoPlan.DCTTypeContact__c != null ? String.valueOf(LineaAutoPlan.DCTTypeContact__c) + ',' : ',';		        	
		        	sContactCel += LineaAutoPlan.MobilePhone != null ? String.valueOf(LineaAutoPlan.MobilePhone) + ',' : ',';		        	
		        	sContactNIP += LineaAutoPlan.DCTNIP__c != null ? String.valueOf(LineaAutoPlan.DCTNIP__c) + ',' : ',';
		        	sContactEmail += LineaAutoPlan.Email != null ? String.valueOf(LineaAutoPlan.Email) + ',' : ',';
		        	sContactAutorizaInfo += LineaAutoPlan.DCTReceiveInformation__c != null ? String.valueOf(LineaAutoPlan.DCTReceiveInformation__c) + ',' : ',';
		        	sContactNotas += LineaAutoPlan.Description != null ? String.valueOf(LineaAutoPlan.Description).replaceAll(',', ';') + ',' : ',';
	        	}
	        	//Quita las comas al final de la linea
	        	sContactName = sContactName.substring(0, sContactName.length()-1);	        	
	        	sContactPuesto = sContactPuesto.substring(0, sContactPuesto.length()-1);	        	
	        	sContactTipo = sContactTipo.substring(0, sContactTipo.length()-1);	        	
	        	sContactCel = sContactCel.substring(0, sContactCel.length()-1);	        	
	        	sContactNIP = sContactNIP.substring(0, sContactNIP.length()-1);
	        	sContactEmail = sContactEmail.substring(0, sContactEmail.length()-1);	        	
	        	sContactAutorizaInfo = sContactAutorizaInfo.substring(0, sContactAutorizaInfo.length()-1);
	        	sContactNotas = sContactNotas.substring(0, sContactNotas.length()-1);	        	
	        }//Fin si DirMod.Lineas_Autorizadas__r.isEmpty()
			
			//NOMBRE DE CONTACTO
        	sRegistroPaso += sContactName != null ? String.valueOf(sContactName) + '|' : '|';
	        System.debug('EN DCT_ReporteCamposModifDirComercial_bch sContactName: ' + sContactName);
	        //PUESTO
        	sRegistroPaso += sContactPuesto != null ? String.valueOf(sContactPuesto) + '|' : '|';
	        System.debug('EN DCT_ReporteCamposModifDirComercial_bch sContactPuesto: ' + sContactPuesto);
	        //TIPO DE CONTACTO
        	sRegistroPaso += sContactTipo != null ? String.valueOf(sContactTipo) + '|' : '|';
	        System.debug('EN DCT_ReporteCamposModifDirComercial_bch sContactTipo: ' + sContactTipo);
	        //TELEFONO MOVIL
        	sRegistroPaso += sContactCel != null ? String.valueOf(sContactCel) + '|' : '|';
	        System.debug('EN DCT_ReporteCamposModifDirComercial_bch sContactCel: ' + sContactCel);
	        //NIP
        	sRegistroPaso += sContactNIP != null ? String.valueOf(sContactNIP) + '|' : '|';
	        System.debug('EN DCT_ReporteCamposModifDirComercial_bch sContactNIP: ' + sContactNIP);
	        //CORREO ELECTRONICO
        	sRegistroPaso += sContactEmail != null ? String.valueOf(sContactEmail) + '|' : '|';
	        System.debug('EN DCT_ReporteCamposModifDirComercial_bch sContactEmail: ' + sContactEmail);
	        //AUTORIZA RECIBIR INFORMACION
        	sRegistroPaso += sContactAutorizaInfo != null ? String.valueOf(sContactAutorizaInfo) + '|' : '|';
	        System.debug('EN DCT_ReporteCamposModifDirComercial_bch sContactAutorizaInfo: ' + sContactAutorizaInfo);
			//NOTAS
        	sRegistroPaso += sContactNotas != null ? String.valueOf(sContactNotas) + '|' : '|';			
			

	        //EL ID EXTERNO DEL REGISTRO	        
	        System.debug('EN DCT_ReporteCamposModifDirComercial_bch sRegistroPaso: ' + sRegistroPaso);
	        sIdExterno = DirMod.ID + '-' + DirMod.RFC__c + '-' + Date.today();
	        System.debug('EN DCT_ReporteCamposModifDirComercial_bch sIdExterno: ' + sIdExterno);	        
	        DCT_ReportCamModifDirCom__c objDCTClientesReasignadosPaso = new DCT_ReportCamModifDirCom__c(
	        	Name = sIdExterno,
        		DCT_IdExterno__c = sIdExterno,
        		DCT_Registro__c = sRegistroPaso,
        		DCT_FechaProceso__c = Date.today()
        	);
	        mapClientesPasoIns.put(sIdExterno, objDCTClientesReasignadosPaso);
        }//Fin del for para los reg que se estan creando
        
        System.debug('EN DCT_ReporteCamposModifDirComercial_bch mapClientesPasoIns: ' + mapClientesPasoIns);        
        //Ve si tiene algo la lista de mapClientesPasoIns
        if (!mapClientesPasoIns.isEmpty())
        	Upsert mapClientesPasoIns.values() DCT_ReportCamModifDirCom__c.DCT_IdExterno__c;
        
    }
    
    //Finish
    global void finish(Database.BatchableContext BC){
        System.debug('EN DCT_ReporteCamposModifDirComercial_bch.finish Hora: ' + DateTime.now());      
    }
    
    private String formateaFecha(Date dFecha){
    	System.debug('ENTRO A DCT_ReporteCamposModifDirComercial_bch.formateaFecha dFecha: ' + dFecha);

    	String sFechaFormat = '';
    	
    	if (dFecha != null){
    		Integer iAnyo = dFecha.year() ;
    		Integer iMes = dFecha.month();
    		Integer iDia = dFecha.day();
    		
    		sFechaFormat = iDia < 10 ? '0' + String.valueOf(iDia) + '-' : String.valueOf(iDia) + '-';
    		sFechaFormat += iMes < 10 ? '0' + String.valueOf(iMes) + '-' : String.valueOf(iMes) + '-';    		
    		sFechaFormat += iAnyo;
    		
    	}//Fin si dFecha != null
    	System.debug('ENTRO A DCT_ReporteCamposModifDirComercial_bch.formateaFecha sFechaFormat: ' + sFechaFormat);    	
    	
    	return sFechaFormat;
    }

    private String formateaFechaHora(DateTime dFecha){
    	System.debug('ENTRO A DCT_ReporteCamposModifDirComercial_bch.formateaFecha dFecha: ' + dFecha);

    	String sFechaFormat = '';
    	
    	//Ve si tiene algo la fecha
    	if (dFecha != null){
    		
    		Integer iAnyo = dFecha.year() ;
    		Integer iMes = dFecha.month();
    		Integer iDia = dFecha.day();
    		Integer iHora = dFecha.hour();
    		Integer iMin = dFecha.minute();
    		
    		//La fecha	    		
    		sFechaFormat = iDia < 10 ? '0' + String.valueOf(iDia) + '-' : String.valueOf(iDia) + '-';
    		sFechaFormat += iMes < 10 ? '0' + String.valueOf(iMes) + '-' : String.valueOf(iMes) + '-';    		
    		sFechaFormat += iAnyo + ' ';
			
			//La hora
    		sFechaFormat = iHora < 10 ? '0' + String.valueOf(iHora) + ':' : String.valueOf(iHora) + ':';
    		sFechaFormat += iMin < 10 ? '0' + String.valueOf(iMin) : String.valueOf(iMin);
    		
    	}//Fin si dFecha != null
    	
    	System.debug('ENTRO A DCT_ReporteCamposModifDirComercial_bch.formateaFecha sFechaFormat: ' + sFechaFormat);    	
    	
    	return sFechaFormat;
    }
        
}