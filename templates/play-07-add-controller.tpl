  def add = Action {
    Ok(html.<<$objectname>>.form(<<$objectname>>Form))
  }

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
