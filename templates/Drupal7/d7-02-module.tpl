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
  # /<<$tablename_clean>>
  $items['<<$tablename_clean>>'] = array(
    'title' => t('<<$tablename_clean|replace:'_':' '|capitalize>> List'),
    'description' => '<<$tablename_clean|replace:'_':' '|capitalize>> List',
    'page callback' => '<<$tablename_clean>>_list',
    'access arguments' => array('access content'),  # TODO change this
    'type' => MENU_NORMAL_ITEM,
    'file' => '<<$tablename_clean>>_crud.inc',
  );

  # /<<$tablename_clean>>/add
  $items['<<$tablename_clean>>/add'] = array(
    'title' => 'Add New <<$tablename_clean_singular|replace:'_':' '|capitalize>>',
    'description' => 'Form to add a new <<$tablename_clean_singular|replace:'_':' '|capitalize>>',
    'page callback' => 'drupal_get_form',
    'page arguments' => array('<<$tablename_clean_singular>>_add'),
    'access callback' => TRUE,
    'type' => MENU_NORMAL_ITEM,
    'file' => '<<$tablename_clean>>_crud.inc',
  );

  # /<<$tablename_clean>>/edit
  $items['<<$tablename_clean>>/edit'] = array(
    'title' => 'Edit <<$tablename_clean_singular|replace:'_':' '|capitalize>>',
    'page callback' => 'drupal_get_form',
    'page arguments' => array('<<$tablename_clean_singular>>_edit'),
    'access callback' => TRUE,
    'type' => MENU_CALLBACK,
    'file' => '<<$tablename_clean>>_crud.inc',
  );

  # /<<$tablename_clean>>/delete
  $items['<<$tablename_clean>>/delete'] = array(
    'title' => 'Delete <<$tablename_clean_singular|replace:'_':' '|capitalize>>',
    'page callback' => 'drupal_get_form',
    'page arguments' => array('<<$tablename_clean_singular>>_delete'),
    'access callback' => TRUE,
    'type' => MENU_CALLBACK,
    'file' => '<<$tablename_clean>>_crud.inc',
  );

  return $items;
}


