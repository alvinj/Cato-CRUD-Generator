<%@ page import="<<$PACKAGE_NAME>>.<<$classname>>" errorPage="error.jsp" %>

<<* --- this template lets the user view the detail for one object --- *>>
<<* --- (such as for one "user") --- *>>

<<* get the current object from the session or request *>>
<%
  // get the "user" object from the request
  <<$classname>> <<$objectname>> = (<<$classname>>)request.getObject("<<$objectname>>");
%>

<html>
<head>
  <title>Current <<$classname>></title>
</head>

<body>

<h2>Current <<$classname>></h2>

<form action="<<$classname>>Controller" method="post">

  <input type="hidden" name="ACTION" value="VIEW">
  <input type="hidden" name="CURRENT_PAGE" value="<<$classname>>View.jsp">

  <table>

<<* --- create an input field for each database table field --- *>>
<<section name=id loop=$camelcase_fields>>
    <tr>
      <td><<$camelcase_fields[id]>>:</td>
      <td><%=<<$objectname>>.get<<$camelcase_fields[id]|capitalize>>(); %></td>
    </tr>
<</section>>

    <<* --- TODO: Add your own Edit, Delete, and Cancel links here, as desired --- *>>
    <tr>
      <td>
        &nbsp;
      </td>
      <td><input type=submit name="edit" value="  Edit  "><input
             type="button"
             value="  Cancel  "
             onClick="window.location.href='GO_SOMEWHERE.jsp'">
      </td>
    </tr>
  </table>

</form>
</body>
</html>
