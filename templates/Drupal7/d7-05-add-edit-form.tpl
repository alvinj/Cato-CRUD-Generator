<?php

#-------------------------------------------
# copy and paste this code into a file named
# "<<$tablename_clean>>_form.inc"
#-------------------------------------------

#------------------------------------------------------
# the form used to add and edit a <<$tablename_clean_singular|capitalize>> object
#------------------------------------------------------

<<assign var="weight" value=10>>
# TODO: currently assume all fields are 'textfield'.
# other field types: textarea, select, 
# see http://www.devdaily.com/drupal/drupal-form-module-programming-examples-tutorials
# for more examples
<<section name=id loop=$fields>>
  <<if preg_match('/id$/', $fields[id]) == 0 >>
$form['<<$fields[id]>>'] = array(
    <<if $db_types[id] eq 'text' or $db_types[id] eq 'integer'>>
'#type' => 'textfield',
    <<elseif $db_types[id] eq 'blob'>>
'#type' => 'textarea',
    <<elseif $db_types[id] eq 'timestamp'>>
'#type' => 'date',
    <<else>>
'#type' => 'textfield',
    <</if>>
'#title' => t('<<$fields[id]|replace:'_':' '|capitalize>>'),
    '#description' => "The <<$fields[id]|replace:'_':' '|capitalize>> field.",
    '#weight' => <<$weight>>,
    '#required' => TRUE,
    '#default_value' => $<<$fields[id]>>,
  );
  <<assign var="weight" value="`$weight+10`">>
  <<else>>
    # ignoring <<$fields[id]>> field
  <</if>>

<</section>>

# FIX - set this to the field name where you want default input focus
$form['#suffix'] = '<script type="text/javascript">'
                 . "jQuery('input#edit-name').focus();"
                 . '</script>';

$form['submit'] = array(
  '#type' => 'submit',
  '#value' => 'Save',
  '#suffix' => '<span id="cancel_button"><a href="/<<$tablename_clean>>">Cancel</a></span>',
  '#weight' => 1000,
);


*** EVERYTHING BELOW HERE IS SAMPLE FORM CODE TO  ***
*** MAKE YOUR FORM DEVELOPMENT FASTER / EASIER.   ***
*** DELETE ANYTHING NOT NEEDED.                   ***

#-------
# HIDDEN
#-------

# an html hidden field for our drupal form
$form['wizard_page'] = array(
  '#type' => 'hidden',
  '#value' => 2,
);

#----------------------------
# DRUPAL GET USER ID FUNCTION
#----------------------------

function get_user_id() {
  global $user;
  return $user->uid;
}

#--------------------------------------
# SELECT/OPTION (DROPDOWN) EXAMPLE CODE
#--------------------------------------

$options = array('A' => t('Option A'),
                 'B' => t('Option B'),
                 'C' => t('Option C'))
);
$form['type'] = array(
  '#title' => t('<<$tablename_clean_singular|replace:'_':' '|capitalize>>'),
  '#type' => 'select',
  '#description' => "Select a <<$tablename_clean_singular|replace:'_':' '|capitalize>>.",
  '#options' => $options,
  '#weight' => 10,
  '#default_value' => $type,
);

#----------------
# PASSWORD FIELDS
#----------------

$form['password'] = array(
  '#type' => 'password',
  '#title' => t('Password'),
  '#description' => t('Please enter your password'),
  '#size' => 32,
  '#maxlength' => 32,
  '#required' => TRUE,
);

$form['pass_fields'] = array(
  '#type' => 'password_confirm',
  '#description' => t('Enter the same password in both fields'),
  '#size' => 32,
  '#required' => TRUE,
);

#--------------
# RADIO BUTTONS
#--------------

# the options to display in our form radio buttons
$options = array(
  'punt' => t('Punt'),
  'field_goal' => t('Kick field goal'), 
  'run' => t('Run'),
  'pass' => t('Pass'),
);

$form['fourth_down'] = array(
  '#type' => 'radios',
  '#title' => t('What to do on fourth down'),
  '#options' => $options,
  '#description' => t('What would you like to do on fourth down?'),
  '#default_value' => $options['punt'],
);

#-----------
# CHECKBOXES
#-----------

# the options to display
$toppings = array(
  'pepperoni' => t('Pepperoni'),
  'black_olives' => t('Black olives'), 
  'veggies' => t('Veggies')
);

# the drupal checkboxes form field definition
$form['pizza'] = array(
  '#title' => t('Pizza Toppings'),
  '#type' => 'checkboxes',
  '#description' => t('Select the pizza toppings you would like.'),
  '#options' => $toppings,
);

#------------
# DATE WIDGET
#------------

$form['birthdate'] = array(
  '#title' => t('Birthdate'),
  '#type' => 'date',
  '#description' => t('Select your birthdate'),
  '#default_value' => array(
    'month' => format_date(time(), 'custom', 'n'), 
    'day' => format_date(time(), 'custom', 'j'), 
    'year' => format_date(time(), 'custom', 'Y'),
  ),
);

#---------
# FIELDSET
#---------

#--------------------------------------
# define your drupal 'fieldset' element
#--------------------------------------
$form['name'] = array(
  '#type' => 'fieldset',
  '#title' => t('Name'),
  '#collapsible' => TRUE,
  '#collapsed' => TRUE,
);

#--------------------------------------------------------
# create a form element as a sub-array of your
# top-level fieldset element; notice that this element is
# declared as "$form['name']['firstname']" -- a sub-array
# of the fieldset element.
#--------------------------------------------------------
$form['name']['firstname'] = array(
  '#type' => 'textfield',
  '#title' => t('First name'),
);

#-----------------------
# HTML PREFIX AND SUFFIX
#-----------------------

# an html textfield for our drupal form
$form['name'] = array(
  '#type' => 'textfield',
  '#title' => t('First Name'),
);

# the drupal form prefix and suffix properties
$form['#prefix'] = '<div class="my-form-class">';
$form['#suffix'] = '</div>';











