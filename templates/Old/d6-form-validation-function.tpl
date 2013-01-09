
function CHANGE_ME_form_validate($form, &$form_state) {

  # get the fields to validate
<<section name=id loop=$camelcase_fields>>
  $<<$camelcase_fields[id]>> = $form_state['values']['<<$camelcase_fields[id]>>'];
<</section>>

  # set an error if required fields are not given
<<section name=id loop=$camelcase_fields>>
  $<<$camelcase_fields[id]>> = $form_state['values']['<<$camelcase_fields[id]>>'];
  if (!$<<$camelcase_fields[id]>>) {
    form_set_error('<<$camelcase_fields[id]>>', 'The <<$camelcase_fields[id]|capitalize>> field is required.');
  }

<</section>>

}
