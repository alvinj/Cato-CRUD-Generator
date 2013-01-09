  // TODO - delete trailing comma
  // TODO - use correct field types
  val <<$objectname>>Form: Form[<<$classname>>] = Form(
    mapping(
<<section name=id loop=$camelcase_fields>>
      "<<$camelcase_fields[id]>>" -> <<$play_field_types[id]>>,
<</section>>
    )(<<$classname>>.apply)(<<$classname>>.unapply)
  )


//--------------------------------------
// OTHER PLAY FRAMEWORK EXAMPLES & TYPES
//--------------------------------------
"date" -> optional(date("yyyy-MM-dd")),   // java.util.Date
"date" -> date("yyyy-MM-dd"),   // java.util.Date
"username" -> nonEmptyText,
"username" -> nonEmptyText(6),       // requires a minimum of six characters
"notes" -> text,
"password" -> text(minLength = 10),
"count" -> number,
"addToMailingList" -> boolean,
"email" -> email,
"company" -> optional(text),
"numberOfShares" -> optional(number),
"stocks" -> list(text),
"emailAddresses" -> list(email),
"id" -> ignored(1234),

boolean
checked
date
email
ignored
list
longNumber
nonEmptyText
number
optional
seq
single
sqlDate
text


