<%
  String category = request.getParameter("category");
%>
Select Meter Types: &nbsp;&nbsp;&nbsp;
<%if(category.equals("all") || category.equals("ZW")){ %>
<input type="radio" name="Mtype" value="Feeder" onchange="" />Feeder
<% }%>
<input type="radio" name="Mtype" value="DTR" onchange="" />DTR
<input type="radio" name="Mtype" value="HT"  onchange=""/>HT
