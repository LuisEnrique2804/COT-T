({
	changeValue : function (component, event, helper) {
    component.set("v.myBool", true);
  },

  	loadOptions: function (component, event, helper) {
		var opts = [
		{'label': 'Grupo', 'value': 'Grupo'},
		{'label': 'Razón Social', 'value': 'Razón Social'},
		{'label': 'Cuenta Nacional', 'value': 'Cuenta Nacional'},
		{'label': 'Cuenta Padre', 'value': 'Cuenta Padre'}
		];
		component.set("v.options", opts);
	},
})