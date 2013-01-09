  // (1) FIND
  // TODO - delete trailing comma
  def findById(id: Long): <<$classname|capitalize>> = {
    DB.withConnection { implicit c =>
      val row = SQL("SELECT * FROM <<$tablename>> WHERE id = {id}")
        .on('id -> id)
        .apply
        .head
      val <<$objectname>> = <<$classname|capitalize>>(
<<section name=id loop=$camelcase_fields>>
<<if ($field_is_reqd[id] == true) >>
row[<<$scala_field_types[id]|capitalize>>]("<<$fields[id]>>"),
<<else>>
row[Option[<<$scala_field_types[id]|capitalize>>]]("<<$fields[id]>>"),
<</if>>
<</section>>
      )
      contact
    }
  }

  // (2) UPDATE
  // TODO - fix commas
  def update(<<$objectname>>: <<$classname>>) {
    DB.withConnection { implicit c =>
      SQL("""
        update <<$tablename>> set 
<<section name=id loop=$camelcase_fields>>
<<if ($camelcase_fields[id] != 'id') >>
        <<$fields[id]>> = {<<$camelcase_fields[id]>>},
<</if>>
<</section>>
        where id={id}
        """
      )
      .on(
<<section name=id loop=$camelcase_fields>>
<<if ($camelcase_fields[id] != 'id') >>
        '<<$camelcase_fields[id]>> -> <<$objectname>>.<<$camelcase_fields[id]>>,
<</if>>
<</section>>
        'id -> <<$objectname>>.id
      ).executeUpdate()
    }
  }

REQUIREMENTS:

- must use the same form for 'add' and 'edit'  

COMPUTER DATABASE EDIT FORM:

// the id is passed into the form, then there is this form statement
@form(routes.Application.update(id)) {

- the problem with this approach is that you need two '@form' statements, one
  for 'create' and another for 'edit'; this is okay if you can wrap it in an
  if/then statement
- @form(routes.Application.save()) {  // THE 'ADD' FORM STATEMENT

MARTINEZ APPROACH IN FORM:

a) "id" -> optional(of[Long]),
b) save method tests id to see if it should do an insert or update
c) sadly, he shows the id in the form
   i) this can be okay if i use id as a hidden field


FROM 'FORMS' EXAMPLE

Ok(html.contact.form(contactForm))                        // display empty form
Ok(html.contact.form(contactForm.fill(existingContact)))  // edit
errors => BadRequest(html.contact.form(errors)),          // validation errors

contact form:
@(contactForm: Form[Contact])











