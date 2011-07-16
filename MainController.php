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

# need to connect to the user's database
require_once 'db.cfg';
require_once 'app.cfg';
require_once 'MDB2.php';

class MainController
{
  /**
   * this function displays the main cato form (which is 
   * currently the only cato form).
   */
  function display_form($template_dir, $smarty)
  {
    # get the list of database tables
    $tables = $this->get_list_of_db_tables();
    # get the list of the user's template files
    $templates = $this->get_list_of_templates($template_dir);
    # assign the smarty variables, then display the main page
    $smarty->assign('tables', $tables);
    $smarty->assign('templates', $templates);
    $smarty->display('index.tpl');
  }

  # returns a list of the database table names
  function get_list_of_db_tables()
  {
    # need to include the database config info here (within the class)
    # so this function can access the $dsn and $dsn_options variables
    include('db.cfg');

    $mdb =& MDB2::connect($dsn, $dsn_options);
    if (PEAR::isError($mdb)) {
      die($mdb->getMessage());
    }

    # need the Manager module to do our magic
    $mdb->loadModule('Manager');

    # get all the db table names
    $tables = $mdb->listTables();
    $mdb->disconnect();
    return $tables;
  }
  
  # returns a list of template file names,
  # including the '.tpl' part
  function get_list_of_templates($template_dir)
  {
    $arr = array();
    if ($handle = opendir($template_dir)) {
      while (false !== ($file = readdir($handle))) {
        if ($file != "." && $file != "..") {
          array_push($arr, $file);
        }
      }
      closedir($handle);
    } else {
      # TODO log or display the error message here
    }
    return $arr;
  }
  

}

?>

