  def list = Action {
    Ok(html.<<$classname|lower>>.list(<<$classname>>.selectAll(), <<$objectname>>Form))
  }

