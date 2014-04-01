// copy this file to your Play 'app/models/<<$classname>>.scala' file.
// ===================================================================

package models

import play.api.db._
import play.api.Play.current
import anorm.SQL
import anorm.SqlQuery

//-----------------
// 1 THE CASE CLASS
//-----------------
// TODO delete the trailing comma
case class <<$classname|capitalize>> (
<<section name=id loop=$camelcase_fields>>
<<if ($field_is_reqd[id] == true) >>
var <<$camelcase_fields[id]>>: <<$scala_field_types[id]>>,
<<else>>
var <<$camelcase_fields[id]>>: Option[<<$scala_field_types[id]>>],
<</if>>
<</section>>
)

object <<$classname|capitalize>> {

  val sqlQuery = SQL("SELECT * FROM <<$tablename>> ORDER BY id ASC")

  //-----------------------------------
  // 2 THE DATABASE 'SELECT ALL' METHOD
  //-----------------------------------
  // TODO - delete trailing comma
  import play.api.Play.current 
  import play.api.db.DB
  def selectAll(): List[<<$classname|capitalize>>] = DB.withConnection { implicit connection => 
    sqlQuery().map ( row =>
      <<$classname|capitalize>>(
<<section name=id loop=$camelcase_fields>>
<<if ($field_is_reqd[id] == true) >>
row[<<$scala_field_types[id]>>]("<<$fields[id]>>"),
<<else>>
row[Option[<<$scala_field_types[id]>>]]("<<$fields[id]>>"),
<</if>>
<</section>>
      )
    ).toList
  }

}

