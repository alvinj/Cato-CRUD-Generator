
/**
 * The "ADD <<$tablename_no_prefix_singular|replace:'_':' '|capitalize>>" form
 * ----------------------------------------------------------------------
 */
function <<$tablename_no_prefix_singular>>_add($form, &$form_state) {
  
  # the 'add' form has its own description
  $form['description'] = array(
    '#type' => 'item',
    '#title' => t('Add a new <<$tablename_no_prefix_singular|replace:'_':' '|capitalize>>'),
  );

  # set up default values for the form
<<section name=id loop=$fields>>
<<if preg_match('/id$/', $fields[id]) == 1 >>
  # skipping '<<$fields[id]>>' field
<<elseif $db_types[id] eq 'integer'>>
  $<<$fields[id]>> = 0;
<<elseif $db_types[id] eq 'blob' or $db_types[id] eq 'text'>>
  $<<$fields[id]>> = '';
<<elseif $db_types[id] eq 'timestamp'>>
  $<<$fields[id]>> = get_current_timestamp();
<<else>>
  $<<$fields[id]>> = '';
<</if>>
<</section>>

  # then we mix in the rest of the form
  require_once('<<$tablename_no_prefix>>_edit_form.inc');

  return $form;
}

function <<$tablename_no_prefix_singular>>_add_validate($form, &$form_state) {
  # nothing here yet
  # form_set_error('username', 'Validation on the username field failed. Try again.');
}

function <<$tablename_no_prefix_singular>>_add_submit($form, &$form_state) {
  $<<$tablename_no_prefix_singular>> = new stdClass();
  #$<<$tablename_no_prefix_singular>>->user_id = get_user_id();

  # FIX - probably want to tie this to user_id, project_id, or other fk
<<section name=id loop=$fields>>
<<if preg_match('/^id$/', $fields[id]) == 0 >>
  $<<$tablename_no_prefix_singular>>-><<$fields[id]>> = $form_state['values']['<<$fields[id]>>'];
<</if>>
<</section>>

  # new drupal 7 style insert
  # FIX - watch out for 'id' fields here
  $id = db_insert('<<$tablename>>')
      ->fields(array(
<<section name=id loop=$fields>>
  <<if preg_match('/^id$/', $fields[id]) == 0 >>
         '<<$fields[id]>>' => $<<$tablename_no_prefix_singular>>-><<$fields[id]>>,
  <</if>>
<</section>>
  ))
  ->execute();
  
  # TODO use this if you can get it to fade away
  #drupal_set_message(t('The new <<$tablename_no_prefix_singular|capitalize>> has been added.'));
  
  # do a redirect here
  $form_state['redirect'] = '<<$tablename_no_prefix>>';
}

