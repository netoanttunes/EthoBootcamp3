({

    init : function(component, event, helper) {
        helper.setColumns(component);
        helper.fetchData(component);
    },

    handleClick : function(component, event, helper) {
        component.set('{! v.showModal}',!component.get('v.showModal'));
    }
})
