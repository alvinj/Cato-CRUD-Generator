<?php

/**
 * a hook_menu implementation
 */
<<$APPLICATION_NAME|lower>>_menu() {

  $items = array();

  #--------------------------------------------------------------------
  # REMINDER:
  # run this once for each database table you want to generate code
  # for. then include these contents in a file named 
  # 'projectname_module.inc' in your drupal module directory.
  #--------------------------------------------------------------------

  #-----------------------------------------------
  # <<$tablename|replace:'_':' '|capitalize>>
  #-----------------------------------------------
  # /<<$tablename_no_prefix>>
  $items['<<$tablename_no_prefix>>'] = array(
    'title' => t('<<$tablename_no_prefix|replace:'_':' '|capitalize>> List'),
    'description' => '<<$tablename_no_prefix|replace:'_':' '|capitalize>> List',
    'page callback' => '<<$tablename_no_prefix>>_list',
    'access arguments' => array('access content'),  # TODO change this
    'type' => MENU_NORMAL_ITEM,
    'file' => '<<$tablename_no_prefix>>.inc',
  );

  # /<<$tablename_no_prefix>>/add
  $items['<<$tablename_no_prefix>>/add'] = array(
    'title' => 'Add New <<$tablename_no_prefix_singular|replace:'_':' '|capitalize>>',
    'description' => 'Form to add a new <<$tablename_no_prefix_singular|replace:'_':' '|capitalize>>',
    'page callback' => 'drupal_get_form',
    'page arguments' => array('<<$tablename_no_prefix_singular>>_add'),
    'access callback' => TRUE,
    'type' => MENU_NORMAL_ITEM,
    'file' => '<<$tablename_no_prefix>>.inc',
  );

  # /<<$tablename_no_prefix>>/edit
  $items['<<$tablename_no_prefix>>/edit'] = array(
    'title' => 'Edit <<$tablename_no_prefix_singular|replace:'_':' '|capitalize>>',
    'page callback' => 'drupal_get_form',
    'page arguments' => array('<<$tablename_no_prefix_singular>>_edit'),
    'access callback' => TRUE,
    'type' => MENU_CALLBACK,
    'file' => '<<$tablename_no_prefix>>.inc',
  );

  # /<<$tablename_no_prefix>>/delete
  $items['<<$tablename_no_prefix>>/delete'] = array(
    'title' => 'Delete <<$tablename_no_prefix_singular|replace:'_':' '|capitalize>>',
    'page callback' => 'drupal_get_form',
    'page arguments' => array('<<$tablename_no_prefix_singular>>_delete'),
    'access callback' => TRUE,
    'type' => MENU_CALLBACK,
    'file' => '<<$tablename_no_prefix>>.inc',
  );

  return $items;
}


