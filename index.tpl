<html>

<head>
  <title>Cato</title>
  <link type="text/css" rel="stylesheet" media="all" href="/css/cato.css" />
  <script type="text/javascript" src="js/jquery-1.6.2.min.js"></script>
  <script type="text/javascript" src="js/jquery.copy.min.js"></script>
</head>

{* TODO - make the keywords and description more appropriate to this project/directory *}

<body>

<div id="header">
  <h1>cato</h1>
</div>

<!-- the form wraps pretty much everything -->
<form action="ws_gen_code.php" method="post">

<!-- start left-column -->
<div id="left-column">

  <div id="tables">
  <h2>Tables</h2>
  <select name="tables" id="tables" size="8" class="required">
  {html_options values=$tables output=$tables}
  </select>
  </div>

  <div id="fields">
  <h2>Fields</h2>
  <select name="fields[]" id="fields" size="8" class="required" multiple="multiple">
  <option value="default">--select a table--</option> 
  </select>
  </div>

  <div id="templates">
  <h2>Templates</h2>
  <select name="templates" id="templates" size="8" class="required">
  {html_options values=$templates output=$templates}
  </select>
  </div>

<div id="button">
<!-- action defined below with jquery -->
<input type="submit" value="Generate Code" />
</div>

</div>
<!-- end left-column -->

<!-- start right-column -->
<div id="right-column">

  <h2>Output</h2>

  <textarea rows="2" cols="20" name="output" id="output">

  your template-based output will be shown here

  </textarea>
  <!--
  <button type="button" id="copy">Copy to Clipboard</button>
  -->

</div>
<!-- end right-column -->

</form>

{include file='footer.tpl'}


<script>

// TODO getting collisions here with the submit button,
//      so i've taken this out for now
// copy to clipboard function
//$('button#copy').click(function() {
//  $("textarea#output").copy()
//});

/**
 * this is the ajax form submission function.
 * when the submit button is clicked, this function submits
 * the form data, gets the data back from the server, and
 * populates the textfield with the results.
 */
$('form').submit(function(event) {
  event.preventDefault();
  // TODO do the validation here
  var isErrorFree = true;
  //$('select.required').each(function(){
  //  if (validateElement.isValid(this) == false){
  //    isErrorFree = false;
  //  }
  //});
  
  $('input[name="usingAJAX"]',this).val('true');
  var $this = $(this);
  var url = $this.attr('action');
  var dataToSend = $this.serialize();
  var callback = function(dataReceived) {
    $('textarea').text(dataReceived);
  };
  var typeOfDataToReceive = 'html';
  if (isErrorFree) $.post(url, dataToSend, callback, typeOfDataToReceive)
}); // end .submit action

/**
 * this function handles the process where you click a table
 * and the fields table is automatically populated.
 */
$(function() {
  $("select#tables").change(function() {
    $.getJSON("/ws_get_table_names.php", { table: $(this).val(), ajax: 'true' }, function(j) {
      //alert("JSON success!");
      var options = '';
      for (var i = 0; i < j.length; i++) {
        options += '<option value="' + j[i].optionValue + '">' + j[i].optionDisplay + '</option>';
      }
      $("select#fields").html(options);
    })
  })
})
</script>

</body>
</html>








