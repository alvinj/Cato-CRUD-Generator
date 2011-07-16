/**
 * A Drupal module submit handler
 * ------------------------------------------------------------------
 * Displays success message on top of form.
 * Form is still displayed.
 * ------------------------------------------------------------------
 * Adds a submit handler/function to our form to send a successful
 * completion message to the screen.
 */
#function minime_reminder_add_form_submit($form, &$form_state) {
function MODULE_NAME_PROCESS_NAME_add_form_submit($form, &$form_state) {

  # form is already validated, just save it here
<<section name=id loop=$camelcase_fields>>
  $<<$camelcase_fields[id]>> = $form_state['values']['<<$camelcase_fields[id]>>'];
<</section>>

  # get the user id
  global $user;
  $uid = $user->uid;

  # get the current date/time in the needed format (YYYY-MM-DD HH:MM:SS)
  $datetime = "$date $time:00";

  # ----------------------------
  # (1) one way to do the insert
  # ----------------------------
  $sql = "INSERT INTO {<<$tablename>>}"
       . " (<<$fields_as_insert_csv_string>>) "
       . " VALUES (<<$prep_stmt_as_insert_csv_string>>)";
  $sql_fields = "<<$fields_as_insert_csv_string>>";

  # do the insert
  db_query($sql, $sql_fields);

  # EXAMPLE OF WHAT THIS SHOULD LOOK LIKE
  # db_query("INSERT INTO {minime_reminders} (uid, event, event_time) VALUES (%d, '%s', '%s')",
  #  $uid, $event, $datetime);

  # ----------------------------------------
  # (2) a second way to do the insert (TODO)
  # ----------------------------------------
  $data = array(
<<section name=id loop=$camelcase_fields>>
    '<<$camelcase_fields[id]>>' => $<<$camelcase_fields[id]>>,
<</section>>
  );
  drupal_write_record('<<$tablename>>', $data);

  # this message is shown on the top of the resulting page
  #drupal_set_message(t("You said: $event, $date, $time, $uid"));
  # and this correctly redirects the user to the main page
  # (can leave this out to add another reminder)
  #$form_state['redirect'] = 'minime/reminders';
}





