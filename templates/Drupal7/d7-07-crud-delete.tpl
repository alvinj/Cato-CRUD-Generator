
/**
 * The "DELETE <<$tablename_clean_singular|replace:'_':' '|capitalize>>" process
 * --------------------------------------------------------------------------------
 * when the user goes to something like '/<<$tablename_clean>>/delete/4' they end up here
 *
 */
function <<$tablename_clean_singular>>_delete($form, &$form_state) {
  $<<$tablename_clean_singular>>_id = get_id_from_form($form_state, '<<$tablename_clean_singular>>_delete');
  if (!<<$tablename_clean_singular>>_id_is_valid($<<$tablename_clean_singular>>_id)) {
    drupal_goto('<<$tablename_clean>>');
  }
  # prompt the user to confirm. flow then passes to our submit function.
  $cancel_button_uri = '<<$tablename_clean>>';
  $description = 'About to delete <<$tablename_clean_singular|replace:'_':' '|capitalize>> ID ' . $<<$tablename_clean_singular>>_id . '.';
  return confirm_form($form, t('Are you sure?'), $cancel_button_uri, $description, t('Remove'));
}

/**
 * A delete helper/validation function, used to make sure the id we were given
 * is 'valid'. This typically means a) the id is a number, b) the number is not zero,
 * and c) the id is owned by the current user.
 */
function <<$tablename_clean_singular>>_id_is_valid($id_to_delete) {
  # rule 1: make sure $id_to_delete is a number, and is not zero
  if (isset($id_to_delete) && is_numeric($id_to_delete) && ($id_to_delete > 0)) {
    // do nothing, go to next rule
  } else {
    watchdog('sleetmute', "UID  " . get_user_id() . " tried to access '<<$tablename_clean>>/delete' without a correct <<$tablename_clean_singular>>_id" );
    drupal_set_message(t('Wow, something wicked happened. Please try again.'), 'error');
    return false;
  }

  return true;
}

/**
 * the validate function
 */
function <<$tablename_clean_singular>>_delete_validate($form, &$form_state) {
  # form_set_error('username', 'Validation on the username field failed. Try again.');
}

/**
 * the submit handler function.
 * do the work to delete the given <<$tablename_clean_singular|replace:'_':' '>> id 
 * and return to the list of <<$tablename_clean>>
 */
function <<$tablename_clean_singular>>_delete_submit($form, &$form_state) {
  $<<$tablename_clean_singular>>_id_to_delete = get_id_from_form($form_state, '<<$tablename_clean_singular>>_delete_submit');
  if (!<<$tablename_clean_singular>>_id_is_valid($<<$tablename_clean_singular>>_id_to_delete)) {
    drupal_goto('<<$tablename_clean>>');
  }
  # TODO need to check the return value of db_delete
  # FIX - may want to add a condition here (->condition('project_id', get_project_id()))
  db_delete('<<$tablename>>')
    ->condition('id', $<<$tablename_clean_singular>>_id_to_delete)
    ->execute();
  drupal_set_message(t('The <<$tablename_clean_singular|replace:'_':' '|capitalize>> was probably deleted.'));
  $form_state['redirect'] = '<<$tablename_clean>>';
}





