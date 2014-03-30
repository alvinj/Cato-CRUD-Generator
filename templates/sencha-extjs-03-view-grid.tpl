// save this file as 'app/view/<<$classname|capitalize>>List.js'
// VERIFY: name should be singular, like 'StockList' or 'TransactionList'

Ext.define('<<$APPLICATION_NAME>>.view.<<$classname|capitalize>>List', {
    extend: 'Ext.grid.Panel',
    alias: 'widget.<<$classname|lower>>List',  // VERIFY should be singular

    frame: true,
    store: Ext.create('<<$APPLICATION_NAME>>.store.<<$classname|capitalize>>'),  //VERIFY - should be plural

    // valid column xtypes are:
    // none, 'numbercolumn', 'datecolumn'
    columns: [
    <<section name=id loop=$camelcase_fields>>
    { 
            text: '<<$camelcase_fields[id]|capitalize>>', 
            width: 50,
            dataIndex: '<<$camelcase_fields[id]>>'
        },
    <</section>>
],
// TODO delete extra comma(s) after column fields

    dockedItems: [
        {
            xtype: 'toolbar',
            flex: 1,
            dock: 'top',
            items: [
                {
                    xtype: 'button',
                    text: 'Add',
                    itemId: 'add',
                    iconCls: 'add'
                },
                {
                    xtype: 'button',
                    text: 'Delete',
                    itemId: 'delete',
                    iconCls: 'delete'
                }
            ]
        }
    ]

});


// -------------
// HELP/EXAMPLES
//--------------

        // integer column
        {
            text: 'Qty',
            width: 100,
            dataIndex: 'quantity',
            xtype: 'numbercolumn',
            format: '0,000',
            align: 'right'
        },

        // decimal/currency column
        {
            text: 'Price',
            width: 100,
            dataIndex: 'price',
            xtype: 'numbercolumn',
            format: '0.00',
            align: 'right'
        },

        // date
        {
            text: 'Date',
            width: 150,
            dataIndex: 'datetime',
            xtype: 'datecolumn',
            format: 'Y-m-d',
            align: 'right'
        },








