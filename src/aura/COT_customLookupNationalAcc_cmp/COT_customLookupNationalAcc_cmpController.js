({
  
	keyPressController : function(component, event, helper) {
      // get the search Input keyword   
		var getInputkeyWord = component.get("v.SearchKeyWord");
         var getTypeAcc = component.get("v.TypeAccount");
        //var getInputkeyWord2 = component.get("v.SearchKeyWord2");
        console.log('***getInputkeyWord: '+getInputkeyWord);
        //console.log('***getInputkeyWord2: '+getInputkeyWord2);
      // check if getInputKeyWord size id more then 0 then open the lookup result List and 
      // call the helper 
      // else close the lookup result List part.   
        if( getInputkeyWord.length > 0){
            console.log('Luis');
             var forOpen = component.find("searchRes");
               $A.util.addClass(forOpen, 'slds-is-open');
               $A.util.removeClass(forOpen, 'slds-is-close');
            helper.searchHelper(component,event,getInputkeyWord, getTypeAcc);
        }else{  
            component.set("v.listOfSearchRecords", null ); 
             var forclose = component.find("searchRes");
               $A.util.addClass(forclose, 'slds-is-close');
               $A.util.removeClass(forclose, 'slds-is-open');
          }
         
	},
    
    keyPressController2 : function(component, event, helper) {
      // get the search Input keyword   
		//var getInputkeyWord = component.get("v.SearchKeyWord");
        var getInputkeyWord2 = component.get("v.SearchKeyWord2");
        var getTypeAcc = component.get("v.TypeAccount");
        //console.log('***getInputkeyWord: '+getInputkeyWord);
        console.log('***getInputkeyWord2: '+getInputkeyWord2);
      // check if getInputKeyWord size id more then 0 then open the lookup result List and 
      // call the helper 
      // else close the lookup result List part.   
        if( getInputkeyWord2.length > 0){
            console.log('Enrique');
             var forOpen = component.find("searchRes");
               $A.util.addClass(forOpen, 'slds-is-open');
               $A.util.removeClass(forOpen, 'slds-is-close');
            helper.searchHelper(component,event,getInputkeyWord2, getTypeAcc);
        }else{  
            component.set("v.listOfSearchRecords", null ); 
             var forclose = component.find("searchRes");
               $A.util.addClass(forclose, 'slds-is-close');
               $A.util.removeClass(forclose, 'slds-is-open');
          }
         
	},
  
  // function for clear the Record Selaction 
    clear :function(component,event,helper){
      
         var pillTarget = component.find("lookup-pill");
         var lookUpTarget = component.find("lookupField"); 
        
         $A.util.addClass(pillTarget, 'slds-hide');
         $A.util.removeClass(pillTarget, 'slds-show');
        
         $A.util.addClass(lookUpTarget, 'slds-show');
         $A.util.removeClass(lookUpTarget, 'slds-hide');
      
         component.set("v.SearchKeyWord",null);
         component.set("v.listOfSearchRecords", null );
    },
    
  // This function call when the end User Select any record from the result list.   
    handleComponentEvent : function(component, event, helper) {
     
    // get the selected Account record from the COMPONETN event 	 
       var selectedAccountGetFromEvent = event.getParam("NationalAccByEvent");
	   
	   component.set("v.selectedRecord" , selectedAccountGetFromEvent); 
       
        var forclose = component.find("lookup-pill");
           $A.util.addClass(forclose, 'slds-show');
           $A.util.removeClass(forclose, 'slds-hide');
      
        
        var forclose = component.find("searchRes");
           $A.util.addClass(forclose, 'slds-is-close');
           $A.util.removeClass(forclose, 'slds-is-open');
        
        var lookUpTarget = component.find("lookupField");
            $A.util.addClass(lookUpTarget, 'slds-hide');
            $A.util.removeClass(lookUpTarget, 'slds-show');  
      
	},
  // automatically call when the component is done waiting for a response to a server request.  
    hideSpinner : function (component, event, helper) {
        var spinner = component.find('spinner');
        var evt = spinner.get("e.toggle");
        evt.setParams({ isVisible : false });
        evt.fire();    
    },
 // automatically call when the component is waiting for a response to a server request.
    showSpinner : function (component, event, helper) {
        var spinner = component.find('spinner');
        var evt = spinner.get("e.toggle");
        evt.setParams({ isVisible : true });
        evt.fire();    
    },
})