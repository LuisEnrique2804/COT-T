global class DCT_ResponseSISACactiva_cls {
	global Boolean       esExitoso; 
	global List<Info1y7> resultadoMetodo17;
	global List<Info2y8> resultadoMetodo28;
	global List<Info6y9> resultadoMetodo69;
	global List<Info3>   resultadoMetodo3;
	global List<Info4>   resultadoMetodo4;
	global List<Info5>   resultadoMetodo5;
	global List<Info10>  resultadoMetodo10;
	global List<Info11>  resultadoMetodo11;
	global List<Info12>  resultadoMetodo12;
	global List<Info1314y15>  resultadoMetodo131415;
	global List<Error>   listaErrores;

	global class Error{
		global String codigo;
		global String descripcion;
	}
	global class Info2y8 {
		global String  LeyendaInvestigacion;
		global String  RazonSocial; 
		global String  DATFuerzaVenta;
		global String  FuerzaVentaEjecutivo;
		global String  FuerzaVentaServicioVoz;
		global String  FuerzaVentaServicioDatos;
		global String  CicloFacturacion;
		global String  ClaseCredito;
		global String  TipoCuenta;
		global String  TarifasAutorizada;
		global String  GrupoPlan;
		global String  FuerzaVentaPromocionVentaEmpleado;
		global String  FuerzaVentaRenovacionAdendum;
		global Boolean FuerzaVentaCambioSim;
		global String  Rfc;
		global Boolean AdendumAnticipado;
		global String  PlazoDiasAdendum;
		global Boolean BonificaPenalizacion;
		global String  UsuarioXO;
		global Boolean PuedeActivarVPN;
		global String  FuerzadeVentaActivarVPN;
		global String  Estatus;
		//global String Integrador;
	}
	global class Info1y7 {
		global String  LeyendaInvestigacion;
		global String  RazonSocial; 
		global String  DATFuerzaVenta;
		global String  FuerzaVentaEjecutivo;
		global String  FuerzaVentaServicioVoz;
		global String  FuerzaVentaServicioDatos;
		global String  CicloFacturacion;
		global String  ClaseCredito;
		global String  TipoCuenta;
		global String  TarifasAutorizada;
		global String  GrupoPlan;
		global String  FuerzaVentaPromocionVentaEmpleado;
		global String  FuerzaVentaRenovacionAdendum;
		global Boolean FuerzaVentaCambioSim;
		global String  Rfc;
		global Boolean AdendumAnticipado;
		global String  PlazoDiasAdendum;
		global Boolean BonificaPenalizacion;
		global String  UsuarioXO;
		global Boolean PuedeActivarVPN;
		global String  FuerzadeVentaActivarVPN;
		global String  Estatus;
		//global String Integrador;
	}
	global class Info6y9 {
		global String  LeyendaInvestigacion;
		global String  DATFuerzaVenta;
		global String  FuerzaVentaEjecutivo;
		global String  FuerzaVentaServicioVoz;
		global String  FuerzaVentaServicioDatos;
		global String  CicloFacturacion;
		global String  ClaseCredito;
		global String  TipoCuenta;
		global String  TarifasAutorizada;
		global String  GrupoPlan;
		global String  FuerzaVentaPromocionVentaEmpleado;
		global String  FuerzaVentaRenovacionAdendum;
		global Boolean FuerzaVentaCambioSim;
		global Boolean AdendumAnticipado;
		global String  PlazoDiasAdendum;
		global Boolean BonificaPenalizacion;
		global String  UsuarioXO;
		global Boolean PuedeActivarVPN;
		global String  FuerzadeVentaActivarVPN;
		global String  Estatus;
	}
	global class Info3 {
		global String RazonSocial; 
		global String DireccionFiscal;
		global String DireccionCorrespondencia;
		global String Id;
		global String Estatus;
	}
	global class Info4 {
		global String RazonSocial; 
		global String UsuarioXO; 
		global String Estatus;
	}
	global class Info5 {
		global String RazonSocial; 
		global String Rfc; 
		global String Estatus;
	}
	global class Info10 {
		global String FuerzaVentaEjecutivo;
		global String UsuarioXO; 
		global String Estatus;
	}

	global class Info11 {
		global String UsuarioXO; 
		global String Estatus;
	}

	global class Info12{
		global String RazonSocial;
		global String UsuarioXO;  
		global String Id;
		global String Estatus;
	}

	global class Info1314y15{
		global String  Id;
		global String  Rfc;
		global String  RazonSocial;
		global String  Grupo;
		global String  Segmento;
		global String  Sector;
		global String  Subsector;
		global String  ClaveNisi;
		global string  NombreComercial;
		global String  DireccionFiscal;
		global String  DireccionCorrespondencia;
		global Boolean AdendumAnticipado;
		global String  PlazoDiasAdendum;
		global Boolean BonificaPenalizacion;
		global Date    ClienteTelcelDesde;
		global String  Antiguedad;
		global String  FormaPago;
		global String  ReferenciaRAP;
		global String  TipoCliente;
		global String  Estatus;
		global String  PersonaJuridica;
		global String  RazonSocialModificadaPor;
		global Date    RazonSocialFechaModificacion;
		global Boolean EstaEnBuro; 
		global Boolean EsVIP; 
		global Boolean TieneAVL; 
		global String  RepresentanteLegal;
		global String  Beneficios;
		global Date    ClienteFechaRegistro;
		global Date    FechaModificacion;
		global String  UsuarioModificoNombre;
		global String  UsuarioModificoXO;
		global Date    FechaBaja;
	 	global Boolean PuedeActivarVPN;
		global String  CicloFacturacion;
		global String  ClaseCredito;
		global String  TipoCuenta;
		global Boolean ExcentaFianza; 
		global String  ComentarioGeneral;
		global String  GrupoPlan;
		global String  TarifasAutorizada;
		global String  ClavePlan;
		global String  PlanNombre;
		global String  PlanPlazo;
		global String  GerenteAutorizo;
		global String  PlanFechaAutorizacion;
		global Boolean TieneTratoCompartido;
		global String  DATId;
		global String  DATFuerzaVenta;
		global String  DATNombre;
		global String  Servicios;
		global String  InplantNombre;
		global String  InplantTelefono;
		global String  InplantExtension;
		global String  InplantCelular;
		global String  InplantCorreoElectronico;
		global String  InplantDAT;
		global String  InplantFechaRegistro;
		global String  LeyendaInvestigacion;
		global String  ResultadoVerificacion;
		global String  Investigacion;
		global String  InvestigacionComentarios;
		global Decimal TotalLineasActivas;
		global String  TipoAutorizacion;
		global Date    LineasFechaAutorizacion;
		global String  LineasActivas;
		global String  LineasSolicitadas;
		global String  LineasSolicitadasEstatus;
		global String  LineasFechaSolicitud;
		global String  LineasAutorizadasPor;
		global String  LineasAutorizadas;
		global Decimal TotalLineasAutorizadas;
		global String  NombrePropietario;
		global String  UsuarioXO;
		global String  FuerzaVentaEjecutivo;
		global String  JefeDatos;
		global String  FuerzaVentaJefeDatos;
		global String  ContactoNombre;
		global String  ContactoPuesto;
		global String  TipoContacto;
		global String  ContactoTelefono;
		global String  ContactoNip;
		global String  ContactoCorreoElectronico;
		global String  AutorizaRecibirInformacion;
		global String  Notas;
	}
}