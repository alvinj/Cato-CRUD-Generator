// this is a Sencha ExtJS 'Controller' class

//VERIFY - should be plural, like 'Stocks'
Ext.define('<<$APPLICATION_NAME>>.controller.<<$classname|capitalize>>', {
    extend: 'Ext.app.Controller',

    //VERIFY - should be singular and uc, like 'StockList'
    views: [
        '<<$classname|capitalize>>List',
    ],

    //VERIFY - should be plural and uc, like 'Stocks'
    stores: [
        '<<$classname|capitalize>>s'
    ],

    //VERIFY - both of these should be singular and lc, like 'stockList'
    refs: [
        {
            ref: '<<$classname|lower>>List',
            selector: '<<$classname|lower>>List'
        }
    ],

    init: function(application) {

        // add the components and events we listen to
        this.control({
            //VERIFY - these should all be singular and lc, like 'stockList'
            '<<$classname|lower>>List': {
                render: this.onRender
            },
            '<<$classname|lower>>List button#add': {
                click: this.onAddTransactionButtonClicked
            },
            '<<$classname|lower>>List button#delete': {
                click: this.onDeleteTransactionButtonClicked
            },
            '<<$classname|lower>>Form button#cancel': { //<<$classname>>Form cancel button
                click: this.onAddTransactionFormCancelClicked
            },
            '<<$classname|lower>>Form button#save': { //<<$classname>>Form save button
                click: this.onAddTransactionFormSaveClicked
            }
        });

        // VERIFY - these should both be uc and plural
        if (!Ext.getStore('<<$classname|capitalize>>s')) {
            Ext.create('<<$APPLICATION_NAME>>.store.<<$classname|capitalize>>s');
        }    
    },

    /**
     * <<$classname|capitalize>>Form events/methods
     */

    // the 'add' button click event
    onAdd<<$classname|capitalize>>ButtonClicked: function(button, event, options) {
        var win = Ext.create('<<$APPLICATION_NAME>>.view.<<$classname|capitalize>>Form');
        win.setTitle('Add <<$classname|capitalize>>');
        win.show();
    },

    // the 'cancel' button click event on the 'add form'
    onAdd<<$classname|capitalize>>FormCancelClicked: function(button, event, options) {
        button.up('window').close();
    },

    // the 'save' button click event on the 'add form'
    onAdd<<$classname|capitalize>>FormSaveClicked: function(button, event, options) {
        var win = button.up('window'),
            formPanel = win.down('form'),
            store = this.get<<$classname|capitalize>>List().getStore();

        if (formPanel.getForm().isValid()) {
            formPanel.getForm().submit({
                clientValidation: true,
                // TODO - PUT YOUR URL HERE
                url: 'php/<<$classname|lower>>save.php',
                success: function(form, action) {
                    var result = action.result;
                    console.log(result);
                    if (result.success) {
                        Packt.util.Alert.msg('Success!', '<<$classname|capitalize>> was saved.');
                        store.load();
                        win.close();                      
                    } else {
                        Packt.util.Util.showErrorMsg(result.msg);
                    }
                },
                failure: function(form, action) {
                    switch (action.failureType) {
                        case Ext.form.action.Action.CLIENT_INVALID:
                            Ext.Msg.alert('Failure', 'Form fields may not be submitted with invalid values');
                            break;
                        case Ext.form.action.Action.CONNECT_FAILURE:
                            Ext.Msg.alert('Failure', 'Ajax communication failed');
                            break;
                        case Ext.form.action.Action.SERVER_INVALID:
                            Ext.Msg.alert('Failure', action.result.msg);
                   }
                }
            });
        }
    },

    // delete one or more <<$classname|lower>>s
    onDelete<<$classname|capitalize>>ButtonClicked: function (button, e, options) {
        var grid = this.get<<$classname|capitalize>>List(),
            record = grid.getSelectionModel().getSelection(), 
            store = grid.getStore();

        if (store.getCount() >= 1 && record[0]) {
            var idToDelete = record[0].get('id');
            Ext.Msg.show({
                 title:'Delete?',
                 msg: 'Are you sure you want to delete ID(' + idToDelete + ')?',
                 buttons: Ext.Msg.YESNO,
                 icon: Ext.Msg.QUESTION,
                 fn: function (buttonId){
                    if (buttonId == 'yes'){
                        Ext.Ajax.request({
                            // TODO - YOUR 'DELETE' URL HERE
                            url: 'php/delete<<$classname|lower>>.php',
                            params: {
                                id: idToDelete
                            },
                            success: function(conn, response, options, eOpts) {
                                var result = Packt.util.Util.decodeJSON(conn.responseText);
                                if (result.success) {
                                    Packt.util.Alert.msg('Success', 'The <<$classname|lower>> was deleted.');
                                    store.load();
                                } else {
                                    Packt.util.Util.showErrorMsg(conn.responseText);
                                }
                            },
                            failure: function(conn, response, options, eOpts) {
                                Packt.util.Util.showErrorMsg(conn.responseText);
                            }
                        });
                    }
                 }
            });
        } else {
            Ext.Msg.show({
                title:'Dude',
                msg: 'Dude, you need to select at least one <<$classname|lower>>.',
                buttons: Ext.Msg.OK,
                icon: Ext.Msg.WARNING
            });
        }
    },

    onRender: function(component, options) {
        component.getStore().load();
    }

});











