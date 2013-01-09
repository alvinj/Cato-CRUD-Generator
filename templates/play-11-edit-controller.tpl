  /**
   * Display a form pre-filled with an existing <<$classname>>.
   * TODO: Verify that the user owns the id. See the Zentasks sample project.
   */
  def edit(id: Long) = Action {
    val <<$objectname>> = <<$classname>>.findById(id)
    Ok(html.<<$objectname>>.form(<<$objectname>>Form.fill(<<$objectname>>)))
  }


