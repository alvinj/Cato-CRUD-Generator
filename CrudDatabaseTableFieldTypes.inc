<?php

# a map of the database field types to their java field types

$field_types_map = array( 
  'blob'    => 'Object' ,
  'date'    => 'Date',
  'integer' => 'int',
  'text'    => 'String',
  'timestamp' => 'Timestamp'
);

$scala_field_types_map = array(
  'blob'    => 'Object' ,
  'date'    => 'Date',
  'integer' => 'Integer',
  'long' => 'Long',
  'text'    => 'String',
  'timestamp' => 'Timestamp'
);

$play_reqd_field_types_map = array(
  'blob'    => 'nonEmptyText' ,
  'text'    => 'nonEmptyText',
  'date'    => 'sqlDate',
  'integer' => 'number',
  'long' => 'longNumber',
  'timestamp' => 'sqlDate'
);

$play_optional_field_types_map = array(
  'blob'    => 'optional(text)' ,
  'text'    => 'optional(text)',
  'date'    => 'sqlDate',
  'integer' => 'optional(number)',
  'long' => 'optional(longNumber)',
  'timestamp' => 'sqlDate'
);


?>

