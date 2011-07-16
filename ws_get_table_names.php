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
 * this "web service" gets a list of database table field names
 * for the given database table name.
 * 
 * in its current state it will fail miserably if the table name
 * is invalid for any reason.
 */

/*
WHAT THE JSON NEEDS TO LOOK LIKE:
echo '[ ';
echo '{"optionValue": "0", "optionDisplay": "Mark"}, ';
echo '{"optionValue": "1", "optionDisplay": "Andy"}, ';
echo '{"optionValue": "1", "optionDisplay": "Jim"}';
echo ' ]';
*/

# assume we're getting the field from the browser call
$table_name = $_GET['table'];

# need this for MDB2
require_once 'db.cfg';
require_once 'app.cfg';
require_once 'MDB2.php';

# connect to the database
$mdb =& MDB2::connect($dsn, $dsn_options);
if (PEAR::isError($mdb)) {
  die($mdb->getMessage());
}
$mdb->loadModule('Manager');

# get the field names for the given database table
$table_field_names = $mdb->listTableFields($table_name);

$array_length = count($table_field_names);
$i = 1;

# write the json output
# @see http://remysharp.com/2007/01/20/auto-populating-select-boxes-using-jquery-ajax/
echo "[ ";
foreach ($table_field_names as $field)
{
  if ($i == $array_length) {
    # no trailing comma on the last record
    echo "{\"optionValue\": \"$field\", \"optionDisplay\": \"$field\"} ";
  } else {
    echo "{\"optionValue\": \"$field\", \"optionDisplay\": \"$field\"}, ";
  }
  $i++;
}
echo " ]";

$mdb->disconnect();

?>


