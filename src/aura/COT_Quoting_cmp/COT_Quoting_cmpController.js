({
	loadOptions: function (component, event, helper) {
		var opts = [
			{ value: "---Seleccionar---", label: "---Seleccionar---" },
			{ value: "Plan, equipo, productos, SVA’s y servicios adicionales", label: "Plan, equipo, productos, SVA’s y servicios adicionales" },
			{ value: "Productos, SVA’s y servicios adicionales", label: "Productos, SVA’s y servicios adicionales" },
			{ value: "Soluciones a la medida", label: "Soluciones a la medida" },
			{ value: "Amigo Kit", label: "Amigo Kit" }
		];
		component.set("v.options", opts);

		var optsSearch = [
			{ value: "Plan", label: "Plan" },
			{ value: "Equipo", label: "Equipo" }
		];
		component.set("v.searchFor", optsSearch);

		var optsSearchType = [
			{ value: "Voz", label: "Voz" },
			{ value: "Datos", label: "Datos" }
		];
		component.set("v.searchType", optsSearchType);

		var optsSearchMode = [
			{ value: "CPP", label: "CPP" },
			{ value: "MPP", label: "MPP" }
		];
		component.set("v.searchMode", optsSearchMode);

		var optsSearchConsumo = [
			{ value: "Abierto", label: "Abierto" },
			{ value: "Controlado", label: "Controlado" }
		];
		component.set("v.searchConsumo", optsSearchConsumo);

		var optsSearchGroup = [
			{ value: "MaxSinLimites1", label: "MaxSinLimites1" },
			{ value: "MaxSinLimites2", label: "MaxSinLimites2" }
		];
		component.set("v.GroupPlan", optsSearchGroup);

		var optsSearchPlan = [
			{ value: "100", label: "100" },
			{ value: "200", label: "200" },
			{ value: "300", label: "300" },
			{ value: "400", label: "400" },
			{ value: "500", label: "500" },
			{ value: "600", label: "600" }
		];
		component.set("v.Plan", optsSearchPlan);

		var optsSearchQuantit = [
			{ value: "01", label: "01" },
			{ value: "02", label: "02" },
			{ value: "03", label: "03" },
			{ value: "04", label: "04" },
			{ value: "05", label: "05" },
			{ value: "06", label: "06" },
			{ value: "07", label: "07" },
			{ value: "08", label: "08" },
			{ value: "09", label: "09" },
			{ value: "10", label: "10" }
		];
		component.set("v.Quantity", optsSearchQuantit);

		var optsSearchPlatform = [
			{ value: "Comunicación", label: "Comunicación" },
			{ value: "Localización", label: "Localización" },
			{ value: "M2M", label: "M2M" },
			{ value: "Productividad", label: "Productividad" },
			{ value: "Seguridad", label: "Seguridad" },
			{ value: "Tablet", label: "Tablet" },
			{ value: "Banda Ancha", label: "Banda Ancha" },
			{ value: "Datos Puros", label: "Datos Puros" }
		];
		component.set("v.Platform", optsSearchPlatform);

		var optsSearchBrand = [
			{ value: "Motorola", label: "Motorola" },
			{ value: "Sony", label: "Sony" },
			{ value: "Huawei", label: "Huawei" }
		];
		component.set("v.Brand", optsSearchBrand);

		var optsSearchModel = [
			{ value: "P Smart", label: "P Smart" },
			{ value: "Iphone X", label: "Iphone X" },
			{ value: "Galaxy S7", label: "Galaxy S7" }
		];
		component.set("v.Model", optsSearchModel);

		var optsCategoria = [
			{ value: "Tablets", label: "Tablets" },
			{ value: "Smartphone", label: "Smartphone" },
			{ value: "Router", label: "Router" }
		];
		component.set("v.Categoria", optsCategoria);

		var optsRango = [
			{ value: "500-700", label: "500-700" },
			{ value: "700-900", label: "700-900" },
			{ value: "900-1000", label: "900-1000" }
		];
		component.set("v.Rango", optsRango);

		var optsSearchTecno = [
			{ value: "3G", label: "3G" },
			{ value: "4G", label: "4G" }
		];
		component.set("v.Tecnologia", optsSearchTecno);

		var optsSO = [
			{ value: "Android", label: "Android" },
			{ value: "IOS", label: "IOS" }
		];
		component.set("v.SO", optsSO);

		var optsSearchModelemoria = [
			{ value: "6 Gb", label: "6 Gb" },
			{ value: "24 Gb", label: "24Gb" },
			{ value: "32 Gb", label: "32 Gb" }
		];
		component.set("v.Memoria", optsSearchModelemoria);

		var optsCamaraPrimaria = [
			{ value: "16 MP", label: "16 MP" },
			{ value: "32 MP", label: "32 MP" },
			{ value: "50 MP", label: "50 MP" }
		];
		component.set("v.CamaraPrimaria", optsCamaraPrimaria);

		var optsPantalla = [
			{ value: "5.9 pulgadas", label: "5.9 pulgadas" },
			{ value: "6.5 pulgadas", label: "6.5 pulgadas" },
			{ value: "8 pulgadas", label: "8 pulgadas" }
		];
		component.set("v.Pantalla", optsPantalla);

		var optsCriterios = [
			{ value: "Nucleos", label: "Nucleos" }
		];
		component.set("v.CriterioExt", optsCriterios);

		var optsValor = [
			{ value: "8", label: "8" }
		];
		component.set("v.ValueCrit", optsValor);

	},
  changeValue : function (component, event, helper) {
    component.set("v.myBool", true);
  },
  otherCarac : function (component, event, helper) {
    component.set("v.blnOtherCara", true);
  },
  SelectColor : function (component, event, helper) {
    component.set("v.color", true);
  },
  smartSearch : function (component, event, helper) {
    component.set("v.smart", true);
  },
  smartSave : function (component, event, helper) {
    component.set("v.saveProfile", true);
  },
  cotizacion : function (component, event, helper) {
    component.set("v.generarCotizacion", true);
  }, 
  QuotinDetails2 : function (component, event, helper) {
    component.set("v.generarCotizacionDetails2", true);
  },
  QuotinDetails : function (component, event, helper) {
    component.set("v.generarCotizacionDetails", true);
  },
  sendQuoting : function (component, event, helper) {
    component.set("v.blnsendQuoting", true);
  },
  blnConFinanciamientoChange : function (component, event, helper) {
    component.set("v.blnConFinanciamiento", true);
  },
  
  handleValueChange : function (component, event, helper) {
      // handle value change
      console.log("old value: " + event.getParam("oldValue"));
      console.log("current value: " + event.getParam("value"));
  },
   openModel: function(component, event, helper) {
      // for Display Model,set the "isOpen" attribute to "true"
      component.set("v.isOpen", true);
   },
 
   closeModel: function(component, event, helper) {
      // for Hide/Close Model,set the "isOpen" attribute to "Fasle"  
      component.set("v.isOpen", false);
   },
 
   likenClose: function(component, event, helper) {
      // Display alert message on the click on the "Like and Close" button from Model Footer 
      // and set set the "isOpen" attribute to "False for close the model Box.
      // alert('thanks for like Us :)');
      component.set("v.isOpen", false);
   },
})