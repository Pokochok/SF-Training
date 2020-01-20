//({
//	packItem : function(component, event, helper) {
//        var btnClicked = event.getSource();
//        btnClicked.set("v.disabled", "true");
//		component.set("v.item.Packed__c", "true");
//	}
//})
({
    packItemCheck : function(component, event, helper) {
        if(component.find("packedItemId").get("v.checked")){
            component.set("v.item.Packed__c", true);
        } else{
            component.set("v.item.Packed__c", false);
        }
        var item = component.get("v.item");
        helper.createItem(component, item);
//        var updateEvent = component.getEvent("updateItem");
//                updateEvent.setParams({ "item": item });
//                updateEvent.fire();
    }
})