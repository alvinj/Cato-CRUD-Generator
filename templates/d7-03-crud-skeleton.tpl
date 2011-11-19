<?php 

#---------------------------------------------------------------------------
# (1) copy and paste this code into a file named "<<$tablename_no_prefix>>.inc"
# (2) after you do this and rebuild the menus, all the urls should work 
#     (they will show something)
#---------------------------------------------------------------------------

require_once 'common.inc';

/**
 * The "List <<$tablename_no_prefix|replace:'_':' '|capitalize>>" table (the 'list view')
 * ----------------------------------------------------------------------
 */
function <<$tablename_no_prefix>>_list() {
  # TODO - replace this stub
  return 'This is the stub for the "list" page.';
}

/**
 * The "ADD <<$tablename_no_prefix_singular|replace:'_':' '|capitalize>>" form
 * ----------------------------------------------------------------------
 */
function <<$tablename_no_prefix_singular>>_add($form, &$form_state) {
  # TODO - replace this stub
  $form['description'] = array(
    '#type' => 'item',
    '#title' => t("Add <<$tablename_no_prefix_singular|replace:'_':' '|capitalize>> stub."),
  );
  return $form;
}

function <<$tablename_no_prefix_singular>>_add_validate($form, &$form_state) {
}

function <<$tablename_no_prefix_singular>>_add_submit($form, &$form_state) {
}

/**
 * The "DELETE <<$tablename_no_prefix_singular|replace:'_':' '|capitalize>>" process
 * ----------------------------------------------------------------------
 */
// when the user goes to something like '/projects/delete/4' they end up here
function <<$tablename_no_prefix_singular>>_delete($form, &$form_state) {
  # TODO - replace this stub
  $form['description'] = array(
    '#type' => 'item',
    '#title' => t('Delete a <<$tablename_no_prefix_singular|replace:'_':' '|capitalize>> stub.'),
  );
  return $form;
}

// handle the deletion of the project that will be in $form_state
function <<$tablename_no_prefix_singular>>_delete_submit($form, &$form_state) {
}

/**
 * The "EDIT <<$tablename_no_prefix_singular|replace:'_':' '|capitalize>>" form
 * ----------------------------------------------------------------------
 */
function <<$tablename_no_prefix_singular>>_edit($form, &$form_state) {
  # TODO - replace this stub
  $form['description'] = array(
    '#type' => 'item',
    '#title' => t('Edit a <<$tablename_no_prefix_singular|replace:'_':' '|capitalize>> stub'),
  );
  return $form;
}

/**
 * handle the <<$tablename_no_prefix_singular>>/edit 'submit' process
 */
function <<$tablename_no_prefix_singular>>_edit_submit($form, &$form_state) {
}


