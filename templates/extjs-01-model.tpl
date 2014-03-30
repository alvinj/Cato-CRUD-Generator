// save this file as 'app/model/<<$classname|capitalize>>.js'
// (name should be singular, like 'Stock' or 'Transaction')

// --------------------------------------------------------------
// some of these types will not be right.
// valid sencha types are: 
//     'auto', 'string', 'int', 'integer', 
//     'float', 'number', 'boolean', 'date'
// int and integer are interchangeable; so are float and number.
// --------------------------------------------------------------


// (A) USE THIS BLOCK IF YOU WANT TYPES
// ------------------------------------
Ext.define('<<$APPLICATION_NAME>>.model.<<$classname|capitalize>>', {
    extend: 'Ext.data.Model',

    idProperty: 'id',

    fields: [
    <<section name=id loop=$camelcase_fields>>
    { name: '<<$camelcase_fields[id]>>', type: '<<$scala_field_types[id]|lower>>' },
    <</section>>
]

});


// (B) USE THIS BLOCK IF YOU DON'T WANT TYPES
// ------------------------------------------
Ext.define('<<$APPLICATION_NAME>>.model.<<$classname|capitalize>>', {
    extend: 'Ext.data.Model',

    idProperty: 'id',

    fields: [
    <<section name=id loop=$camelcase_fields>>
    { name: '<<$camelcase_fields[id]>>' },
    <</section>>
]

});



