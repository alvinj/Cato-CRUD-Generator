/**
 * the <<$tablename_clean>>/delete validation function
 */
function <<$tablename_clean_singular>>_add_validate($form, &$form_state) {
  # add your validation code here
  # make sure the user owns what they're trying to delete
  # FIX - change this section for your needs/tests
  $q = "SELECT project_id FROM {<<$tablename>>} WHERE id = :<<$tablename_clean_singular>>_id";
  $result = db_query($q, array(':<<$tablename_clean_singular>>_id' => $id_to_delete))->fetchObject();
  # the project_id we find must match the project_id in the session
  if ($result->project_id != get_project_id()) {
    watchdog('sleetmute', "UID  " . get_user_id() . " tried to access '<<$tablename_clean>>/delete' with an invalid <<$tablename_clean_singular>>_id" );
    drupal_set_message(t('Wow, something wicked happened. Please try again.'), 'error');
  # form_set_error('username', 'Validation on the username field failed. Try again.');
    return false;
  }
  
}
