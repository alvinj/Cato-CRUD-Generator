


  # an example drupal date validation
<<section name=id loop=$camelcase_fields>>
  $<<$camelcase_fields[id]>> = $form_state['values']['<<$camelcase_fields[id]>>'];
  if ($<<$camelcase_fields[id]>> && ($<<$camelcase_fields[id]>> < 1900 || $<<$camelcase_fields[id]>> > 2000)) {
    form_set_error('<<$camelcase_fields[id]>>', 'Enter a year between 1900 and 2000.');
  }

<</section>>

