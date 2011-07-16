package <<$DAO_PACKAGE_NAME>>;

import java.sql.*;
import java.util.*;
import <<$MODEL_PACKAGE_NAME>>.*;
import <<$CONTROLLER_PACKAGE_NAME>>.*;

TODO/ERROR - this template has several known errors:
* need a getAllLike() method
* change method names to insert, update, delete, select, selectAll
* add a 'search' method?

public class <<$classname>>Dao
{
  
  // this method is used by the 'get' methods of this Dao class.
  private <<$classname>> getFromResultSet (ResultSet r) 
  throws SQLException
  {
    <<$classname>> <<$objectname>> = new <<$classname>>();
<<section name=id loop=$camelcase_fields>>
    <<$objectname>>.set<<$camelcase_fields[id]|capitalize>>( r.get<<$types[id]|capitalize>>("<<$camelcase_fields[id]>>") );
<</section>>
    return <<$objectname>>;
  }

  /**
   * This method lets you select a <<$classname>> object by specifying the object's id.
   */
  public <<$classname>> selectByKey (Connection conn, int id) 
  throws SQLException
  {
    Commands currentRow = null;
    Statement statement = null;
    ResultSet resultSet = null;
    try
    {
      // TODO should do this with a PreparedStatement to avoid sql injection problems
      String query = " SELECT * FROM <<$tablename>> WHERE id = " + id;
      statement = conn.createStatement();
      resultSet = statement.executeQuery(query);
      if ( resultSet.next() )
      {
        currentRow = getFromResultSet(resultSet);
      }
    }
    catch (SQLException se)
    {
      // log exception if desired
      throw se;
    }
    finally
    {
      if ( statement != null )
      {
        statement.close();
      }
    }
  }

  /**
   * Insert a new <<$classname>> into the <<$tablename>> database table.
   */
  public void insert<<$classname>>(<<$classname>> <<$objectname>>, Connection connection)
  {
    try
    {
      // TODO/ERROR - need to fix this query, as it will have an extra comma at the end
      // create the insert statement
      String query = "INSERT INTO <<$tablename>> "
        + "(<<$fields_as_insert_csv_string>>)"
        + "VALUES (<<$prep_stmt_as_insert_csv_string>>)";

      // create the mysql insert preparedstatement
      PreparedStatement preparedStatement = connection.prepareStatement(query);
<<section name=insertid loop=$camelcase_fields>>
      preparedStatement.set<<$types[insertid]|capitalize>>(<<$smarty.section.insertid.index_next>>, <<$objectname>>.get<<$camelcase_fields[insertid]|capitalize>>();
<</section>>

      // execute the preparedstatement
      preparedStatement.execute();
      connection.close();
    }
    catch (Exception e)
    {
      // TODO log the exception however you normally do
    }
  }

  /**
   * Perform a SQL DELETE on the given id for the <<$tablename>> table.
   */
  public boolean deleteByKey (Connection connection, int id) 
  throws SQLException
  {
    try
    {
      String query = "DELETE FROM <<$tablename>> where id = ?";
      PreparedStatement preparedStatement = connection.prepareStatement(query);
      preparedStatement.setInt(1, id);
      preparedStatement.execute();
      connection.close();
    }
    catch (SQLException se)
    {
      // log exception if desired
      throw se;
    }
    finally
    {
      if ( preparedStatement != null )
      {
        preparedStatement.close();
      }
    }
  }


  /**
   * Update the given <<$classname>> object into the <<$tablename>> table.
   * Assumes the key for the object is the 'id' field.
   */
  public void update<<$classname>>(<<$classname>> <<$objectname>>, Connection connection)
  {
    try
    {
      // TODO/ERROR - need to fix this query, as it will have an extra comma at the end
      String query = "UPDATE <<$tablename>> SET "
                   + "<<$prep_stmt_as_update_csv_string>>"
                   + " WHERE id =?";

      // smarty template note: index_next lets the index start at 1 instead of 0
      // do all the 'set' statements for the fields
      PreparedStatement preparedStatement = connection.prepareStatement(query);
<<section name=updateid loop=$camelcase_fields>>
      preparedStatement.set<<$types[updateid]|capitalize>>(<<$smarty.section.updateid.index_next>>, <<$objectname>>.get<<$camelcase_fields[updateid]|capitalize>>();
<<assign var="nfields" value=$smarty.section.updateid.index_next>>
<</section>>
      // set the key

<<* using the smarty math function to get the right number here *>>
      preparedStatement.setInt(<<math equation="x + y" x=$nfields y=1>>, <<$objectname>>.getId());

      // execute the preparedstatement
      preparedStatement.execute();
      connection.close();
    }
    catch (Exception e)
    {
      // TODO log the exception however you normally do
    }
  }  
}

