// this is a Sencha ExtJS 'form'
// this is a form to let the user add and edit a <<$classname|capitalize>>

// save this file as 'app/view/<<$classname|capitalize>>Form.js'
// VERIFY - should be capitalized and singular, like 'StockForm'
Ext.define('<<$APPLICATION_NAME>>.view.<<$classname|capitalize>>Form', {
    extend: 'Ext.window.Window',

    // VERIFY - should be lc and singular, like 'stockForm'
    alias: 'widget.<<$classname|lower>>Form',

    height: 300,
    width: 360,

    layout: {
        align: 'stretch',
        type: 'vbox'
    },

    title: 'Add/Edit <<$classname|capitalize>>',

    items: [
        {
            xtype: 'form',
            bodyPadding: 5,
            layout: {
                type: 'vbox',
                align: 'stretch'
            },
            defaults: {
                anchor: '100%',
                xtype: 'textfield',
                blankText: 'Required',
                labelWidth: 90
            },
            items: [
                // TODO do i need this hidden field?
                // TODO the 'id' field is duplicated here; probably want it hidden
                {
                    xtype: 'hiddenfield',
                    fieldLabel: 'Label',
                    name: 'id'
                },

        <<section name=id loop=$camelcase_fields>>
            {
                    fieldLabel: '<<$camelcase_fields[id]|capitalize>>',
                    name: '<<$camelcase_fields[id]>>',
                    itemId: '<<$camelcase_fields[id]>>',
                    allowBlank: false,
                    maxLength: 10
                },
    <</section>>

            ]
        }
    ],

    dockedItems: [
        {
            xtype: 'toolbar',
            flex: 1,
            dock: 'bottom',
            ui: 'footer',
            layout: {
                pack: 'end',
                type: 'hbox'
            },
            items: [
                {
                    xtype: 'button',
                    text: 'Cancel',
                    itemId: 'cancel',
                    iconCls: 'cancel'
                },
                {
                    xtype: 'button',
                    text: 'Save',
                    itemId: 'save',
                    iconCls: 'save'
                }
            ]
        }
    ]

});



// -------------
// HELP/EXAMPLES
// -------------

                // RADIO GROUP
                // -----------
                {
                    fieldLabel: 'Type',
                    itemId: 'ttype',
                    xtype: 'radiogroup',
                    // horizontal: true,   //this works, but separates the buttons too much
                    layout: 'hbox',
                    // defaults: {     
                    //     flex: 1
                    // },
                    items: [{
                        boxLabel: 'Buy',
                        inputValue: 'B',
                        name: 'ttype',
                        checked: true,
                        flex: 1
                    }, {
                        boxLabel: 'Sell',
                        inputValue: 'S',
                        name: 'ttype',
                        flex: 4
                    }]
                },

                // INT FIELD with REGEX
                // --------------------
                {
                    fieldLabel: 'Qty',
                    name: 'quantity',
                    itemId: 'quantity',
                    allowBlank: false,
                    maxLength: 10,
                    maskRe: /([0-9]+)$/   // int field
                },

                // HIDDEN FIELD
                // ------------
                {
                    xtype: 'hiddenfield',
                    fieldLabel: 'datetime',
                    name: 'datetime'
                },


















