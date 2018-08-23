({
	changeValue : function (component, event, helper) {
    component.set("v.myBool", true);
  	},

  	loadOptions: function (component, event, helper) {
  // 		//call apex class method
  // 		var action = component.get('c.getComDir');
  // 		action.setCallback(this, function(response) {
  //  			//store state of response
  //  			var state = response.getState();
  //  			if (state === "SUCCESS") {
  //   			//set response value in ListOfAccount attribute on component.
  //   			component.set('v.ListOfAccount', response.getReturnValue());
  //  			}
  // 		});
		// $A.enqueueAction(action);
 	// },
		var opts = [
		{'label': 'Grupo', 'value': 'Grupo'},
		{'label': 'Razón Social', 'value': 'Razón Social'},
		{'label': 'Cuenta Nacional', 'value': 'Cuenta Nacional'},
		{'label': 'Cuenta Padre', 'value': 'Cuenta Padre'}
		];
		component.set("v.options", opts);

		var listGroup = [{ value: "---Seleccionar---", label: "---Seleccionar---" }];
		var listName = [{ value: "---Seleccionar---", label: "---Seleccionar---" }];
		var listNational = [{ value: "---Seleccionar---", label: "---Seleccionar---" }];
		var listFather = [{ value: "---Seleccionar---", label: "---Seleccionar---" }];
		var ListControlGroup = new Array();
		var ListControlName = new Array();
		var ListControlNational = new Array();
		var ListControlFather = new Array();
		console.log( '***listGroup: '+listGroup);

		var action = component.get('c.getComDir');
		console.log( '***action: '+action);
		action.setCallback(this, function(response) {
            var state = response.getState();
   			if (state === "SUCCESS") {
            	var DirComAcc = response.getReturnValue();
				for (var i = 0; i < DirComAcc.length; i++) {
					var dc = DirComAcc[i];
					if (dc.Grupo__c != null) {
						console.log( '***dc.Grupo__r.Name: '+dc.Grupo__r.Name);
						console.log( '***dc.Grupo__c: '+dc.Grupo__c);
						console.log( '***ListControlGroup.includes('+dc.Grupo__r.Name+'): '+ListControlGroup.includes(dc.Grupo__r.Name));
						if (!ListControlGroup.includes(dc.Grupo__r.Name)) {
							listGroup.push( 
								{ value: dc.Id, label: dc.Grupo__r.Name }
							);
							ListControlGroup.push(dc.Grupo__r.Name);
						}
						// console.log( '***listGroup: '+listGroup);
					}
					if (dc.Name != null) {
						console.log( '***dc.Name: '+dc.Name);
						console.log( '***ListControlName.includes('+dc.Name+'): '+ListControlName.includes(dc.Name));
						if (!ListControlName.includes(dc.Name)) {
							listName.push( 
								{ value: dc.RFC__c, label: dc.Name }
							);
							ListControlName.push(dc.Name);
						}
						// console.log( '***listGroup: '+listGroup);
					}
				}
				component.set("v.SearchGroup", listGroup);
				component.set("v.SearchName", listName);
			}
        });

		var action_02 = component.get('c.getRegion');
		console.log( '***action_02: '+action_02);
		action_02.setCallback(this, function(response) {
			var state = response.getState();
   			if (state === "SUCCESS") {
   				var regiones = response.getReturnValue();
   				for (var i = 0; i < regiones.length; i++) {
   					var reg = regiones[i];
   					if (reg.FatherAccount__c) {
   						listNational.push( 
							{ value: reg.Name, label: reg.FatherAccount__c }
						);
						listFather.push( 
							{ value: reg.Name, label: reg.NationalAccount__c }
						);
   					}
   				}
   				component.set("v.SearchNational", listNational);
				component.set("v.SearchFather", listFather);
   			}
		});
        $A.enqueueAction(action);
        $A.enqueueAction(action_02);
	},
})