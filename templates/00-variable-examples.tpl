// this file shows the output that cato variables produce.
// just select a database table and its fields, then generate
// output with this template to see the output each variable
// produces

Variable Name                     Generated Output
-------------                     ----------------
$classname:                       <<$classname>>
$objectname:                      <<$objectname>>
$tablename:                       <<$tablename>>
$fields_as_insert_csv_string:     <<$fields_as_insert_csv_string>>
$prep_stmt_as_insert_csv_string:  <<$prep_stmt_as_insert_csv_string>>
$prep_stmt_as_update_csv_string:  <<$prep_stmt_as_update_csv_string>>


Array Variables
---------------

The following variables are meant to be used in loops:

$camelcase_fields:                <<$camelcase_fields>>
$fields:                          <<$fields>>
$field_is_reqd:                   <<$field_is_reqd>>
$types:                           <<$types>>
$scala_field_types:               <<$scala_field_types>>
$play_field_types:                <<$play_field_types>>
$play_json_field_types:           <<$play_json_field_types>>
$db_types:                        <<$db_types>>

The output from these variables is shown below. Each section
is generated with a loop that looks like this:

    section name=id loop=$VARNAME
    $VARNAME[id]
    /section

Here is the output for each array when applied to the fields
in the table you selected::

$camelcase_fields[id]
---------------------
<<section name=id loop=$camelcase_fields>>
<<$camelcase_fields[id]>>
<</section>>

$db_types[id]
-------------
<<section name=id loop=$camelcase_fields>>
<<$db_types[id]>>
<</section>>

$fields[id]
-----------
<<section name=id loop=$camelcase_fields>>
<<$fields[id]>>
<</section>>

$field_is_reqd[id]
------------------
<<section name=id loop=$camelcase_fields>>
<<$field_is_reqd[id]>>
<</section>>

$play_field_types[id]
---------------------
<<section name=id loop=$camelcase_fields>>
<<$play_field_types[id]>>
<</section>>

$play_json_field_types[id]
--------------------------
<<section name=id loop=$camelcase_fields>>
<<$play_json_field_types[id]>>
<</section>>

$scala_field_types
------------------
<<section name=id loop=$camelcase_fields>>
<<$scala_field_types[id]>>
<</section>>

$types[id] (these are Java field types)
---------------------------------------
<<section name=id loop=$camelcase_fields>>
<<$types[id]>>
<</section>>




