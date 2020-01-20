({
    clickCreateItem : function(component, event, helper) {
            var validItem = component.find('itemform').reduce(function (validSoFar, inputCmp) {
                        inputCmp.showHelpMessageIfInvalid();
                        return validSoFar && inputCmp.get('v.validity').valid;
            }, true);
            if(validItem){
                var newItem = component.get("v.newItem");
                var theItems = component.get("v.items");
                theItems.push(newItem);
                helper.createItem(component, newItem);
                component.set("v.items", theItems);

            }
        },
})