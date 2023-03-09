<%
  String townId = request.getParameter("townId");
  String ssID = request.getParameter("ssId");  
  System.out.println("townName = "+townId+"\t FeederID = "+ssID);
%>
Select Meter Types: &nbsp;&nbsp;&nbsp;
<input type="radio" name="Mtype" value="DTR" onchange="getDTRs(this.value)"/>DTR
<input type="radio" name="Mtype" value="HT" onchange="getDTRs(this.value)"/>HT
