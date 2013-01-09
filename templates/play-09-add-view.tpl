
#---------------------------------------------------------------
# TODO: Name your file app/views/<<$objectname>>/form.scala.html
#---------------------------------------------------------------

@(<<$objectname>>Form: Form[<<$classname>>])

@import helper._
@import helper.twitterBootstrap._

@main("<<$classname>>s") {
  
  @if(<<$objectname>>Form.hasErrors) {
    <div class="alert-message error">
      <p><strong>Bam!</strong> (There were errors)</p>
      <ul>
        @<<$objectname>>Form.errors.map { error =>
          <li>@error</li>
        }
      </ul>
    </div>
  }

  //
  // TODO - DELETE THE 'ID' FORM ELEMENT
  //
  @helper.form(routes.<<$classname>>s.submit) {
    
     <h1><<$classname>> information</h1>

     @* id = 0 for 'create', otherwise it has the real value *@
     @if( <<$objectname>>Form.data.isEmpty ) {
       <input type="hidden" id="id" name="id" value='0'>
     } else {
       <input type="hidden" id="id" name="id" value='@<<$objectname>>Form.get.id'>
     }

<<section name=id loop=$camelcase_fields>>
     @inputText(
       <<$objectname>>Form("<<$camelcase_fields[id]>>"), 
       '_label -> "<<$fields[id]|replace:'_':' '|capitalize>>"
     )
<</section>>
     
    <div class="actions">
      <input type="submit" class="btn primary" value="Insert">
      <a href="@routes.<<$classname>>s.list" class="btn">Cancel</a>
    </div>
    
  }
  
}


#--------
# HELPERS
#--------

DATE:
     @inputDate(
       <<$objectname>>Form("date"), 
       '_label -> "Date"
     ) 








