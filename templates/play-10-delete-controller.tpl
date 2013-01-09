  /*
   * The controller 'delete' action.
   * TODO - the plural name on the 'Redirect' line may not be right.
   */
  def delete(id: Long) = Action {
    <<$classname>>.delete(id)
    Redirect(routes.<<$classname>>s.list)
  }  
