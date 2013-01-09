
//-----------------------------------------------------
// NAME THIS FILE views/<<$objectname>>/list.scala.html
//-----------------------------------------------------

@(<<$objectname>>s: List[<<$classname|capitalize>>], <<$classname|lower>>Form: Form[<<$classname|capitalize>>])

@import helper._

@* helper for table headers *@
@header(orderBy: Int, title: String) = {
  <th class="col@orderBy header">
    <a href="#">@title</a>
  </th>
}

@main("<<$classname|capitalize>>s") {
  
  <h1>There are @<<$objectname>>s.size <<$classname|capitalize>>(s)</h1>
  
  @* emit the <table> *@
  @Option(<<$objectname>>s).filterNot(_.isEmpty).map { <<$classname|lower>> =>
    
    <table class="computers zebra-striped" cellpadding="2">

      <thead>
        <tr>
<<counter start=0 print=false>>
<<section name=id loop=$scala_field_types>>
          @header(<<counter>>, "<<$camelcase_fields[id]|replace:'_':' '|capitalize>>")
<</section>>
        </tr>
      </thead>

      <tbody>

        @<<$objectname>>s.map { <<$classname|lower>> =>
           <tr>
              @* TODO - DELETE EXTRA "ID" COLUMN *@
             <td><a href="@routes.<<$classname|capitalize>>s.edit(<<$classname|lower>>.id)">@<<$classname|lower>>.id</a></td>
<<section name=id loop=$scala_field_types>>
<<if ($field_is_reqd[id] == true) >>
             <td>@<<$classname|lower>>.<<$camelcase_fields[id]>></td>
<<else>>
             <td>@<<$classname|lower>>.<<$camelcase_fields[id]>>.getOrElse { <em>-</em> }</td>
<</if>>
<</section>>

             <td>
               <a href="@routes.<<$classname|capitalize>>s.delete(<<$classname|lower>>.id)" onclick="return confirm('Really delete?');">Delete</a>
             </td>
           </tr>
        }

      </tbody>
    </table>

  }.getOrElse {
    
    <div class="well">
      <em>Nothing to display</em>
    </div>
    
  }

  <p>
  <a href="@routes.<<$classname|capitalize>>s.add">add a new <<$classname|lower>></a>
  </p>
  
  
}

