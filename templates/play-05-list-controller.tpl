  // ===========================================================
  // Use one of the three options below in your controller file,
  // app/controllers/<<$classname>>.scala
  // ===========================================================

  // (A) non-async with a Play view
  // ------------------------------
  def list = Action {
    Ok(html.<<$classname|lower>>.list(<<$classname>>.selectAll, <<$objectname>>Form))
  }

  // needed for json
  import play.api.libs.json._
  import play.api.libs.json.Json
  import play.api.libs.json.Json._

  // (B) non-async with json
  // -----------------------
  def list = Action {
    Ok(Json.toJson(<<$classname>>.selectAll))
  }

  // (C) async with json
  // -------------------

  // needed to return async results
  import play.api.libs.concurrent.Execution.Implicits.defaultContext

  def list = Action.async {
    val <<$objectname>>AsFuture = scala.concurrent.Future{ <<$classname>>.selectAll }
    <<$objectname>>AsFuture.map(result => Ok(Json.toJson(result)))
  }


//
// NOTES might need some of these import statements
//

import play.api._
import play.api.mvc._
import play.api.data._
import play.api.data.Forms._
import play.api.data.validation.Constraints._
import views._
import models._
import play.api.libs.json._
import play.api.libs.json.Json
import play.api.libs.json.Json._
import play.api.data.format.Formats._  // needed for `of[Double]` in mapping


