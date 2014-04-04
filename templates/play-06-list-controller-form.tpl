  // TODO - may need to adjust these field types; see the documentation below.
  val <<$objectname>>Form: Form[<<$classname>>] = Form(
    mapping(
<<section name=id loop=$camelcase_fields>>
      "<<$camelcase_fields[id]>>" -> <<$play_field_types[id]>>,
<</section>>
    )
    // (1) <<$objectname>>Form -> <<$classname>>
    // TODO probably won't need all these fields, such as 'id'
    // DATE might want to use `Calendar.getInstance.getTime` to create a Date in your constructor
    // ID might want to use 0 for your `id` field in constructor
    ((<<$fields_as_insert_csv_string>>) => <<$classname>>(<<$fields_as_insert_csv_string>>))
    //
    // (2) <<$classname>> -> <<$objectname>>Form (form fields must match above)
    // TODO delete trailing comma
    ((<<$objectname>>: <<$classname>>) => Some(
<<section name=id loop=$camelcase_fields>>
      <<$objectname>>.<<$camelcase_fields[id]>>,
<</section>>
    ))
  )

//
// see this url for play framework form field mapping examples:
// http://alvinalexander.com/scala/sample-play-framework-controller-forms-fields-mappings
//

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


