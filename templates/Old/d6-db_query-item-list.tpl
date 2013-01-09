
  # a query to build an array for a table view

  $sql = " SELECT <<$fields_as_insert_csv_string>>"
       . " FROM {<<$tablename>>}";

  $query = db_query($sql);

  $header = array(
<<section name=id loop=$camelcase_fields>>
    '<<$camelcase_fields[id]>>',
<</section>>
  );

  $data = array();
  # build an array of strings from our query
  # TODO make this a paged list of results
  # TODO convert these into links so the user can view/edit them
  while ($row = db_fetch_array($query)) {
<<section name=id loop=$camelcase_fields>>
    $<<$camelcase_fields[id]>> = $row['<<$camelcase_fields[id]>>'];
<</section>>
  }


/**
 * what follows is what my ITEM LIST example looks like
 */

// item_list takes a one-dimensional array of text, or more usefully, links
// (so the user can view and edit them)
$query = db_query("SELECT id, event, event_time FROM {minime_reminders}");
$header = array('ID', 'Event', 'Event Time');
$data = array();
# build an array of strings from our query
# TODO make this a paged list of results
# TODO convert these into links so the user can view/edit them
while ($row = db_fetch_array($query)) {
 $id = $row['id'];
 $uri = '/minime/reminders/view/' . $id;
 $tmp = "<a href=\"$uri\">" . $row['event'] . '</a>';
 $data[] = $tmp;
}
$title = NULL;
$type = 'ul';
$attributes = array('data-role' => 'listview', 'data-theme' => 'g');
$out .= theme('item_list', $data, $title, $type, $attributes);
