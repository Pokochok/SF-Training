({
    doInit: function(component, event, helper) {
        var action = component.get("c.getItems");
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.items", response.getReturnValue());
            }
            else {
                console.log("Failed with state: " + state);
            }
        });
        $A.enqueueAction(action);
    },

//	clickCreateItem : function(component, event, helper) {
//        var validItem = component.find('itemform').reduce(function (validSoFar, inputCmp) {
//                    inputCmp.showHelpMessageIfInvalid();
//                    return validSoFar && inputCmp.get('v.validity').valid;
//        }, true);
//        if(validItem){
//            var newItem = component.get("v.newItem");
//            console.log("Create Item: " + JSON.stringify(newItem));
//            helper.createItem(component, newItem);
//            var theItems = component.get("v.items");
//            theItems.push(newItem);
//            component.set("v.items", theItems);
//            component.set("v.newItem", {'sobjectType':'Camping_Item__c',
//                                                            'Name': '',
//                                                            'Quantity__c': 0,
//                                                            'Price__c': 0,
//                                                            'Packed__c': false});
//        }
//    },

    handleAddItem: function(component, event, helper) {
        var item = event.getParam("item");
        var action = component.get("c.saveItem");
        action.setParams({
            "item": item
        });
        console.log("handleAddItem: " + JSON.stringify(item));
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                var items = component.get("v.items");
                items.push(response.getReturnValue());
                component.set("v.item", items);
            }
        });
        $A.enqueueAction(action);
    },

    updateItem: function(component, expense) {
        var action = component.get("c.saveItem");
        action.setParams({
            "item": item
        });
        if (callback) {
            action.setCallback(this, callback);
        }
        $A.enqueueAction(action);
    },
})