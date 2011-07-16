<<section name=id loop=$camelcase_fields>>
  # <<$fields[id]>> text field
  $form['<<$fields[id]>>'] = array(
    '#type' => 'textfield',
    '#title' => t('<<$fields[id]|replace:'_':' '|capitalize>>'),
    '#required' => 'true',
  );

<</section>>

  # a simple submit button refreshes the form and clears its contents;
  # this is the default behavior for forms.
  $form['submit'] = array(
    '#type' => 'submit',
    '#value' => 'Save',
  );
