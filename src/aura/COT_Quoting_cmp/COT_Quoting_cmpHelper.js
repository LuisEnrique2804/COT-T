({
	getRecordType : function(component, event, strRecordType, sobject) {
        console.log('AQUI: ');
		var action = component.get("c.getRecordTypeByName");
      	// set param to method  
        action.setParams({
        	'recordTypeName': strRecordType,
            'profile' : sobject,
        });
      	// set a callBack    
        action.setCallback(this, function(response) {
        	var state = response.getState();
            if (state === "SUCCESS") {
                var storeResponse = response.getReturnValue();
              	// if storeResponse size is equal 0 ,display No Result Found... message on screen.
                if (storeResponse.length == 0) {
                    console.log('No Respondio Bien: ');
                } else {
                    console.log('Respondio Bien: '+ storeResponse);
                }
                
                component.set("v.recordId", storeResponse);  
            }
		});
        // enqueue the Action  
        $A.enqueueAction(action);
	},
})