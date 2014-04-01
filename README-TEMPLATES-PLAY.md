Play Framework Templates
========================

This document describes how Cato works with the current
set of Play Framework templates.


Database
--------

Cato generates code from database tables. It assumes that you use
the same database table name convention that Ruby on Rails uses,
specifically:

* Table names are plural, like `users`, `stocks`, and `transactions`
* Table names made from multiple words are separated by underscores,
  as in `research_links`
* Field names made from multiple words are also assumed to use 
  underscores, such as the name `date_time`

To show how Cato works I need a sample database table. For the purposes 
of this discussion, I'll generate code from the following MySQL table 
named `transactions`:

    create table transactions (
        id int auto_increment not null,
        symbol varchar(10) not null,
        ttype char(1) not null,
        quantity int not null,
        price decimal(10,2) not null,
        date_time timestamp not null default now(),
        notes text,
        primary key (id)
    ) engine = InnoDB;

This table contains the fields necessary to describe a stock market transaction,
i.e., a "buy" or "sell" of a block of stock, such as buying 100 shares of AAPL stock
at 525.00. Everything in the table is pretty normal, except for the `ttype` field. 
This field will contain `B` for "Buy", or `S` for "Sell".

If you find that view hard to read, here's what the table looks like when using 
the MySQL `desc transactions` command:

    +-----------+---------------+------+-----+-------------------+----------------+
    | Field     | Type          | Null | Key | Default           | Extra          |
    +-----------+---------------+------+-----+-------------------+----------------+
    | id        | int(11)       | NO   | PRI | NULL              | auto_increment |
    | symbol    | varchar(10)   | NO   |     | NULL              |                |
    | ttype     | char(1)       | NO   |     | NULL              |                |
    | quantity  | int(11)       | NO   |     | NULL              |                |
    | price     | decimal(10,2) | NO   |     | NULL              |                |
    | date_time | timestamp     | NO   |     | CURRENT_TIMESTAMP |                |
    | notes     | text          | YES  |     | NULL              |                |
    +-----------+---------------+------+-----+-------------------+----------------+

Given that database table, let's look at how Cato generates Play/Scala code.


The Play Framework routes File
------------------------------

As a simple example of how Cato works, here's the template for a Play Framework
_conf/routes_ file:

    # put this code in your module's "conf/routes" file
    
    GET     /<<$tablename>>                 controllers.<<$tablename|capitalize>>.list
    GET     /<<$tablename>>/add             controllers.<<$tablename|capitalize>>.add
    POST    /<<$tablename>>/add             controllers.<<$tablename|capitalize>>.submit
    GET     /<<$tablename>>/:id/edit        controllers.<<$tablename|capitalize>>.edit(id: Long)
    GET     /<<$tablename>>/:id/delete      controllers.<<$tablename|capitalize>>.delete(id: Long)

This template file is named _play-01-routes.tpl_, and it's located in the _templates_
directory. Cato works with the "Smarty Template" system, and variables are
placed inside the `<<` and `>>` characters. Variables such as `$tablename`,
`$classname`, `$objectname`, and many more are made available to you by Cato.

If you use Cato to apply that template file to the `transactions` database table, Cato will 
generate the following output:

    # put this code in your module's "conf/routes" file
    
    GET     /transactions                 controllers.Transactions.list
    GET     /transactions/add             controllers.Transactions.add
    POST    /transactions/add             controllers.Transactions.submit
    GET     /transactions/:id/edit        controllers.Transactions.edit(id: Long)
    GET     /transactions/:id/delete      controllers.Transactions.delete(id: Long)

As you can see, in simple examples this is very straightforward. The only secret is
knowing a little bit about the Smarty Template syntax, and the variables Cato makes
available to you. (The variables are described in this project's _README-TEMPLATES_ file.)


Stub Code for a Play Framework Controller
-----------------------------------------

As a second simple example, the template file named _play-02-controller.tpl_
contains this code:

    package controllers
    
    import play.api._
    import play.api.mvc._
    import play.api.data._
    import play.api.data.Forms._
    import play.api.data.validation.Constraints._
    import views._
    import models._
    
    object <<$tablename|capitalize>> extends Controller {
    
      def list = TODO
    
      def add = TODO
    
      def submit = TODO
    
      def delete(id: Long) = TODO
    
      def edit(id: Long) = TODO
    
    }

When applied to the `transactions` table, Cato generates the following Play/Scala code:

    package controllers
    
    import play.api._
    import play.api.mvc._
    import play.api.data._
    import play.api.data.Forms._
    import play.api.data.validation.Constraints._
    import views._
    import models._
    
    object Transactions extends Controller {
    
       def list = TODO
       
       def add = TODO
       
       def submit = TODO
       
       def delete(id: Long) = TODO
    
      def edit(id: Long) = TODO
      
    }

As you can see, in just a matter of moments you can generate a Play Framework
_conf_ file and stub controller.


Play Framework Model
--------------------

Hopefully you can see how Cato works, so I'll just show a few more examples.
Next, we'll look at generating Play Framework "model" code.

The template file named `play-03-model.tpl` contains the following template 
code for a Play Framework "model":

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

When you use Cato to apply that template file to the `transactions` database table,
Cato generates the following Play Framework 'model' class code:

    // copy this file to your Play 'app/models/Transaction.scala' file.
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
    case class Transaction (
        var id: Long,
        var symbol: String,
        var ttype: String,
        var quantity: Integer,
        var price: Double,
        var dateTime: java.util.Date,
        var notes: Option[Object],
    )
    
    object Transaction {
    
      val sqlQuery = SQL("SELECT * FROM transactions ORDER BY id ASC")
    
      //-----------------------------------
      // 2 THE DATABASE 'SELECT ALL' METHOD
      //-----------------------------------
      // TODO - delete trailing comma
      import play.api.Play.current 
      import play.api.db.DB
      def selectAll(): List[Transaction] = DB.withConnection { implicit connection => 
        sqlQuery().map ( row =>
          Transaction(
              row[Long]("id"),
              row[String]("symbol"),
              row[String]("ttype"),
              row[Integer]("quantity"),
              row[Double]("price"),
              row[java.util.Date]("date_time"),
              row[Option[Object]]("notes"),
          )
        ).toList
      }
    
    }

As you can see, the code isn't perfect, but it's close, very close. Just delete the trailing
commas, and you're in business.

Truth in advertising: The code spacing isn't perfect. I modified some of the indentation
to make the code easier to read. Until I get the code spacing just right, you'll have to
fix the indentation in your IDE.


Play Framework JSON Model Code
------------------------------

I recently started using JSON for just about everything, so I added a new
template named _play-03-model-json.tpl_. It contains a lot of template code,
so I won't show it all here. Just look at the file to see it.

The important thing is the Play/Scala code that template file generates.
Here's the output from that file when it's applied to the `transactions`
table:

      // copy this code to the `object` in your 
      // app/models/Transaction.scala file
      // ======================================
    
      /**
       * JSON Serializer Code
       * --------------------
       */
      import play.api.libs.json.Json
      import play.api.libs.json._
      import java.text.SimpleDateFormat
    
      implicit object TransactionFormat extends Format[Transaction] {
    
      // convert from Transaction object to JSON (serializing to JSON)
      def writes(transaction: Transaction): JsValue = {
          val sdf = new SimpleDateFormat("yyyy-MM-dd")
          val transactionSeq = Seq(
          // VERIFY valid types are JsString, JsNumber, JsBoolean, JsArray, JsNull, JsObject
          // TODO delete trailing comma
          // DATE example: "datetime" -> JsString(sdf.format(researchLink.datetime)),
          // SEE http://www.playframework.com/documentation/2.2.x/ScalaJson
              "id" -> JsNumber(transaction.id),
              "symbol" -> JsString(transaction.symbol),
              "ttype" -> JsString(transaction.ttype),
              "quantity" -> JsNumber(transaction.quantity),
              "price" -> JsNumber(transaction.price),
              "dateTime" -> JsString(transaction.dateTime),
              "notes" -> JsString(transaction.notes.getOrElse("")),
          )
          JsObject(transactionSeq)
      }
    
      // convert from a JSON string to a Transaction object (de-serializing from JSON)
      // @see http://www.playframework.com/documentation/2.2.x/ScalaJson regarding Option
      // DATE fields should be like: val datetime = (json \ "datetime").as[java.util.Date]
      def reads(json: JsValue): JsResult[Transaction] = {
         val id = (json \ "id").as[JsNumber]
         val symbol = (json \ "symbol").as[JsString]
         val ttype = (json \ "ttype").as[JsString]
         val quantity = (json \ "quantity").as[JsNumber]
         val price = (json \ "price").as[JsNumber]
         val dateTime = (json \ "dateTime").as[JsString]
         val notes = (json \ "notes").asOpt[JsString]
         JsSuccess(Transaction(id,symbol,ttype,quantity,price,date_time,notes))
      }
    }

I haven't worked out all the kinks in the process, but I think you'll agree that this
code gives you something to work with. (If you look at the code, you'll see that I even
handle `Option` fields.) Just make a few changes, and you're in business.
It sure beats the heck out of typing the whole thing by hand.


A Play Framework `list` Controller Method
-----------------------------------------

As another example, Cato generates the following `list` method options for
you:

     // ===========================================================
    // Use one of the three options below in your controller file,
    // app/controllers/Transaction.scala
    // ===========================================================
    
    // (A) non-async with a Play view
    // ------------------------------
    def list = Action {
      Ok(html.transaction.list(Transaction.selectAll, transactionForm))
    }
    
    // needed for json
    import play.api.libs.json._
    import play.api.libs.json.Json
    import play.api.libs.json.Json._
    
    // (B) non-async with json
    // -----------------------
    def list = Action {
      Ok(Json.toJson(Transaction.selectAll))
    }
    
    // (C) async with json
    // -------------------
    
    // needed to return async results
    import play.api.libs.concurrent.Execution.Implicits.defaultContext
    
    def list = Action.async {
      val transactionAsFuture = scala.concurrent.Future{ Transaction.selectAll }
      transactionAsFuture.map(result => Ok(Json.toJson(result)))
    }

In this case the template file _play-05-list-controller.tpl_ gives you several
options for how you want your `list` method to work:

* A non-async method that works with a Play view.
* A non-async method that outputs JSON code.
* An async method that outputs JSON code.

Just use whichever version of the method you want, and once again you're
quickly in business. Other template files generate `add`, `delete`, and
`update` controller actions.


Play Anorm SQL Methods
----------------------

The template file _play-08-add-model-insert.tpl_ generates the following
Anorm `insert` method for you:

    // TODO delete trailing commas
    // TODO delete the 'id' field
    def insert(transaction: Transaction): Boolean = {
      DB.withConnection { implicit c =>
        SQL("""
            insert into transactions (id,symbol,ttype,quantity,price,date_time,notes) 
            values (
              {symbol},
              {ttype},
              {quantity},
              {price},
              {dateTime},
              {notes},
            )
            """
        )
        .on(
          'symbol -> transaction.symbol,
          'ttype -> transaction.ttype,
          'quantity -> transaction.quantity,
          'price -> transaction.price,
          'dateTime -> transaction.dateTime,
          'notes -> transaction.notes,
        ).executeUpdate() == 1
      }
    }

Once again you have to delete a few trailing commas, but the rest of the code
is in good shape.

In a similar way Cato can generate the following Anorm `delete` method:

    def delete(id: Long): Int = {
      DB.withConnection { implicit c =>
        val nRowsDeleted = SQL("DELETE FROM transactions WHERE id = {id}")
          .on('id -> id)
          .executeUpdate()
        nRowsDeleted
      }
    }

It can also generate an Anorm `find` method:

    // (1) FIND
    // TODO - delete trailing comma
    def findById(id: Long): Transaction = {
      DB.withConnection { implicit c =>
        val row = SQL("SELECT * FROM transactions WHERE id = {id}")
          .on('id -> id)
          .apply
          .head
        val transaction = Transaction(
          row[Long]("id"),
          row[String]("symbol"),
          row[String]("ttype"),
          row[Integer]("quantity"),
          row[Double]("price"),
          row[Java.Util.Date]("date_time"),
          row[Option[Object]]("notes"),
        )
        contact
      }
    }

as well as an Anorm `update` method:

    // (2) UPDATE
    // TODO - fix commas
    def update(transaction: Transaction) {
      DB.withConnection { implicit c =>
        SQL("""
          update transactions set 
          symbol = {symbol},
          ttype = {ttype},
          quantity = {quantity},
          price = {price},
          date_time = {dateTime},
          notes = {notes},
          where id={id}
          """
        )
        .on(
          'symbol -> transaction.symbol,
          'ttype -> transaction.ttype,
          'quantity -> transaction.quantity,
          'price -> transaction.price,
          'dateTime -> transaction.dateTime,
          'notes -> transaction.notes,
          'id -> transaction.id
        ).executeUpdate()
      }
    }


Summary
-------

I could keep sharing more examples, but I think you get the idea of how Cato
supports the Play Framework.

As a final important note, if you don't like these templates -- that's great!
Cato is open, so you can create your own! You'll find all of the current templates 
under the _templates_ directory.










