<?php

/**
 * Copyright Alvin Alexander, http://www.devdaily.com, 2011. 
 * All Rights Reserved.
 *
 * This program is distributed free of charge under the terms and 
 * conditions of the GNU GPL v3. See our LICENSE file, or
 * http://www.gnu.org/licenses/gpl.html for more information.
 *
 * The MDB2 and Smarty libraries are included under their own
 * licensing terms.
 */

/**
 * this "web service" takes one database table, N number
 * of table fields, and one template as input, and attempts 
 * to return one string as output; that string is the
 * Smarty-processed template.
 *
 * if people use something besides our ui to send this 
 * service the data, a lot of things can go wrong, very few
 * of which i have accounted for.
 */

// very simple form validation
$formIsReady = true;
if ( !isset($_POST['tables']) ||
     !isset($_POST['fields']) ||
     !isset($_POST['templates']) ) {
  error_log("gen_code: didn't get table, fields, or template data");
  $formIsReady = false;
}
if (!$formIsReady) {
  echo "Please choose a Table, Fields, and a Template";
  return;
}

$tablename = $_POST['tables'];
$fields = $_POST['fields'];
$template = $_POST['templates'];

#------------------------------------------------
# handle all of our "include" and "require" needs
#------------------------------------------------
# need the current directory to find the app.config file
set_include_path(get_include_path() . PATH_SEPARATOR . '.');

# get root_path, smarty_dir, template_dir
require_once 'app.cfg';

# must create a $smarty reference before reading the config file  
require($smarty_dir . '/Smarty.class.php');
$smarty = new Smarty();

# need this for MDB2. also need a $smarty reference before calling this file.
require_once 'db.cfg';
require_once 'smarty.cfg';

# get the user's database configuration, smarty template config, and more.
# this file may further modify the include path, so i'm trying to bring it in
# early; for instance, i have to modify the include path for mamp and mdb2.
require_once 'MDB2.php';

# handles the logic of converting database table information into
# the various types we can use in our templates
require_once 'DatabaseTable.php';

# use Pear MDB2
# @see http://pear.php.net/package/MDB2/docs/latest/MDB2/MDB2.html
$mdb =& MDB2::connect($dsn, $dsn_options);
if (PEAR::isError($mdb)) {
  die($mdb->getMessage());
}

# get the database name
$dbname = $mdb->getDatabase();

# need the Manager module to do our magic
# @see http://pear.php.net/package/MDB2/docs/latest/MDB2/MDB2_Driver_Manager_Common.html
$mdb->loadModule('Manager');

# how i used to get the database table field names for the
# command line version of cato
#$table_field_names = $mdb->listTableFields($tablename);

# now i get the field names from the form that is submitted
# to us
$table_field_names =& $fields;
$nfields = count($table_field_names);

# need to issue a query against the desired table to get the metadata
$query = "SELECT * FROM $tablename";

# on success this returns an MDB2_Result handle
# TODO - deal with the failure condition here
#$result = $mdb->query($query, true, true, 'MDB2_BufferedIterator');
$result =& $mdb->query($query, true, true);

# now that we have a result set, we can get the field types
# as an array:
$dt = new DatabaseTable();
$dt->set_raw_table_name($tablename);
$dt->set_raw_field_names($table_field_names);
$dt->set_db_field_types($result->types);

# assign all the smarty variables we support
$smarty->assign('classname', $dt->get_camelcase_table_name());
$smarty->assign('objectname', $dt->get_java_object_name());
$smarty->assign('tablename', $tablename);
$smarty->assign('fields', $table_field_names);
$smarty->assign('camelcase_fields', $dt->get_camelcase_field_names());
$smarty->assign('fields_as_insert_csv_string', $dt->get_fields_as_insert_stmt_csv_list());
$smarty->assign('prep_stmt_as_insert_csv_string', $dt->get_prep_stmt_insert_csv_string());
$smarty->assign('prep_stmt_as_update_csv_string', $dt->get_fields_as_update_stmt_csv_list());
$smarty->assign('types', $dt->get_java_field_types());
$smarty->assign('dt', $dt);

# read and process the template with fetch(), then echo it out
$out = $smarty->fetch("$template");
echo $out;

$mdb->disconnect();

?>

