/**
 * The "List <<$tablename_clean|replace:'_':' '|capitalize>>" table (the 'list view')
 * ----------------------------------------------------------------------
 */
function <<$tablename_clean>>_list() {

  # FIX - limit your column headers here
  # configure the table header columns
  $header = array(
<<section name=id loop=$fields>>
    array('data' => '<<$fields[id]|replace:'_':' '|capitalize>>', 'field' => '<<$fields[id]>>', 'sort' => 'ASC'),
<</section>>
    array('data' => 'Actions'),
  );

  $select = db_select('<<$tablename>>', 'p')
              ->extend('PagerDefault')
              ->extend('TableSort');

  # FIX - limit the fields here as desired
  # FIX - restrict your query to the current user, project, whatever
  #     ->condition('user_id', get_user_id())
  # get the desired fields
  $select->fields('p', array(
<<section name=id loop=$fields>>
                  '<<$fields[id]>>',
<</section>>
         ))
         ->limit(2)
         ->orderByHeader($header);
  
  # execute the query
  $results = $select->execute();

  # configure the table rows, making the first column a link to our 'edit' page
  $rows = array();
  foreach ($results as $row) {
    $rows[] = array(
      # FIX - probably want this for your first column
      #'<a href="/<<$tablename_clean>>/edit/' . $row->id . '">' . $row->name . '</a>',
<<section name=id loop=$fields>>
      $row-><<$fields[id]>>,
<</section>>
      # last column is assumed to be a 'delete' action
      '<a href="/<<$tablename_clean>>/delete/' . $row->id . '">delete</a>',
    );
  }

  # generate an html table
  $output = theme('table', array('header' => $header, 'rows' => $rows));
  
  # add the pager
  $output .= theme('pager');

  $output .= '<div id="add_link"><a href="/<<$tablename_clean>>/add">Add</a></div>';

  return $output;
}

