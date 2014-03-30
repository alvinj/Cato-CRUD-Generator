// this is a Sencha ExtJS 'Store' class
// save this file as 'app/store/<<$classname|capitalize>>.js' 
// (name should be plural, like 'Stocks')

// TODO the store name should be plural (like 'Stocks', not 'Stock')
Ext.define('<<$APPLICATION_NAME>>.store.<<$classname|capitalize>>', {
    extend: 'Ext.data.Store',

    requires: [
        '<<$APPLICATION_NAME>>.model.<<$classname|capitalize>>'
    ],

    model: '<<$APPLICATION_NAME>>.model.<<$classname|capitalize>>',

    proxy: {
        type: 'ajax',
        url: 'php/<<$classname|lower>>.php',  //TODO your url here

        reader: {
            type: 'json'
        }
    },

    init: function(application) {
        console.log('<<$classname|capitalize>> Store created');
    }

});

