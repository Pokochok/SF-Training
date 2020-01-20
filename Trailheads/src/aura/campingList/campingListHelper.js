({
    createItem: function(component, item) {
        var action = component.get("c.saveItem");
        action.setParams({
            "item": item
        });
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

    updateItem: function(component, item) {
        var action = component.get("c.saveItem");
        action.setParams({
            "item": item
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                // do nothing!
            }
        });
        $A.enqueueAction(action);
    },

	createExpense: function(component, item) {
        var theItems = component.get("v.items");
        var newItem = JSON.parse(JSON.stringify(item));
        theItems.push(newItem);
        component.set("v.items", theItems);
    }
})