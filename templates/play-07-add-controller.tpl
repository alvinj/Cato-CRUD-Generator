  // ======================================================
  // Use one of the  options below in your controller file,
  // app/controllers/<<$classname>>s.scala
  // ======================================================

  // (1A) non-async controller method with a Play view
  def add = Action {
    Ok(html.<<$objectname>>.form(<<$objectname>>Form))
  }

  // (1B) - handle the submit process of a Play view
  // TODO update won't be implemented yet
  def submit = Action { implicit request =>
    <<$objectname>>Form.bindFromRequest.fold(
      errors => BadRequest(html.<<$objectname>>.form(errors)),
      <<$objectname>> => {
        if (<<$objectname>>.id == 0) {
          val res = <<$classname>>.insert(<<$objectname>>)
        } else {
          val res = <<$classname>>.update(<<$objectname>>)
        }
        Redirect(routes.<<$classname>>s.list)
      }
    )
  }


  // (2) async 'add' with json

  // needed to return async results
  import play.api.libs.concurrent.Execution.Implicits.defaultContext

  /**
   * The Sencha client will send me `symbol`, `url`, and `notes` in a POST request.
   * I need to return something like this on success:
   *     { "success" : true, "msg" : "", "id" : 100 }
   * Note: May want to return an HTTP 200 status on error.
   */
  def add = Action { implicit request =>
    <<$objectname>>Form.bindFromRequest.fold(
      errors => {
        // REVIEW return an HTTP 200 error here instead?
        Ok(Json.toJson(Map("success" -> toJson(false), "msg" -> toJson("Boom!"), "id" -> toJson(0))))
      },
      <<$objectname>> => {
        val id = <<$classname>>.insert(<<$objectname>>)
        id match {
          case Some(autoIncrementId) =>
              // REVIEW return whatever you need to return to your client here
              Ok(Json.toJson(Map("success" -> toJson(true), "msg" -> toJson("Success!"), "id" -> toJson(autoIncrementId))))
          case None =>
              // TODO inserts can fail; handle this properly
              Ok(Json.toJson(Map("success" -> toJson(true), "msg" -> toJson("Success!"), "id" -> toJson(-1))))
        }
        
      }
    )
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







