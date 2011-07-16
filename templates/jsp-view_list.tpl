<%@ page import="<<$PACKAGE_NAME>>.<<$classname>>, java.util.List" errorPage="error.jsp" %>

<html>
<head>
  <title><<$classname>> List</title>
</head>

<body>

<h2><<$classname>> List</h2>

<table>

<<* --- the header row; put the field names here --- *>>
<tr>
<<section name=id loop=$camelcase_fields>>
  <th><<$camelcase_fields[id]>></th>
<</section>>
</tr>

<%
  // TODO get the list of users however you need to
  List <<$objectname>>s = <<$classname>>Controller.get<<$classname>>s();
  // TODO now need to iterate over this list of objects ...
  foreach (<<$classname>> : <<$objectname>>)
  {
%>
<<section name=id loop=$camelcase_fields>>
  <tr>
    <td>
      <<* this demonstrates how to build a 'get' method *>>
      <%=<<$objectname>>.get<<$camelcase_fields[id]|capitalize>>(); %>
    </td>
  </tr>
<</section>>
<%
  // end the foreach loop
  }
%>
</table>

</body>
</html>
