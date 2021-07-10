({
  doInit : function(component, event, helper) {
        var createCarRecord = $A.get("e.force:createRecord");
            if (createCarRecord) {
                 component.set("v.showNew", true);
                }
               
             else {
                component.set("v.showNew", false);
                 console.log('Create record event is not supported');
            }
			helper.getCarType(component, helper);
        },


    
	onSearchClick : function(component, event, helper) {
        //alert('From client side controller: Search button has been clicked');
        helper.onSearchClickHelper(component, event, helper);
	},
    valueChangeHandler: function(component, event, helper) {
       var selectedVal = component.find("carTypeList").get("v.value");
       alert(selectedVal + ' has been selected');
	},
    renderHandler: function(component, event, helper) {
       alert('Component has been rendered');
	}

})