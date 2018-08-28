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

		
        $A.enqueueAction(action);
	},

	handleComponentEvent : function(component, event, helper) {
     
    // get the selected Account record from the COMPONETN event 	 
       var selectedAccountGetFromEvent = event.getParam("DirComercialByEvent");
	   
	   component.set("v.selectedValue" , selectedAccountGetFromEvent); 
        //$A.enqueueAction(update);
	},
    
    handleComponentEvaluationEvent : function(component, event, helper) {
     
    // get the selected Account record from the COMPONETN event 	 
       var selectedAccountGetFromEvent = event.getParam("NameByEvent");
	   
	   component.set("v.selectedValue2" , selectedAccountGetFromEvent); 
        //$A.enqueueAction(update);
	},
    
    handleComponentNationalAccEvent : function(component, event, helper) {
     
    // get the selected Account record from the COMPONETN event 	 
       var selectedAccountGetFromEvent = event.getParam("NationalAccByEvent");
	   
	   component.set("v.selectedValue3" , selectedAccountGetFromEvent); 
       component.set("v.selectedValue4" , selectedAccountGetFromEvent); 
        //$A.enqueueAction(update);
	},
})