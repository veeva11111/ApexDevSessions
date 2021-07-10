({
	//onSearchClickHelper : function(component, event, helper) {
		//alert('From client side controller helper: Search button has been clicked');
	//},
    getCarType : function(component, helper) {
		var action = component.get("c.getCarTypes");
		action.setCallback(this, function(response) {
		 var state = response.getState();
            if (state === "SUCCESS") {
                 component.set("v.carTypes", response.getReturnValue());
                }
               

		else if(state === "ERROR") {
                alert('Unknown error');
            }
        });
	$A.enqueueAction(action);
	}
})