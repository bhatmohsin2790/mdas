<%@ page session="false" %>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="in.amitech.db.DBUtil"%>
<script type="text/javascript" src="date-picker.js"></script>

      <%
                               Connection con2 = new DBUtil().getConnection();
                                PreparedStatement pstmt2 = null;
                                ResultSet rs2 = null;
              %>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <form name="HT"  action="">
              <table align="center" bgcolor="#E0ECF8" cellpadding="5" cellspacing="5">
                  <tr><th colspan="2" ><h2><u>Update HT_Meter Mapping</u></h2></th></tr>
                  		<tr>
                      <td>Zone name:</td>
                      <td>
                       <select name="zone" id="zone" style="width:150px;height:20px;font-size:12px;font-family:verdana;" onchange="showCircles(this.value);">

                         <option value="-1">Select Zone</option>
                          <%

                                try {
                                    pstmt2 = con2.prepareStatement("select * from zone");
                                    rs2 = pstmt2.executeQuery();
                                    while (rs2.next()) {
                    %>
                <option value="<%=rs2.getString("zoneid")%>"><%=rs2.getString("zonename")%></option>
          <%
                                    }

                                } catch (Exception e) {
                                    e.printStackTrace();
                                }
                    %>


                       </select>
                      </td></tr>
                                <tr>

                      <td>Circle name:</td>
                      <td>
                          <select name="circle" id="circleId" style="width:150px;height:20px;font-size:12px;font-family:verdana;" onchange="showTowns(this.value);">

                         <option value="-1">Select Circle</option>


                       </select>
                      </td>
                  </tr>
                  <tr>

                      <td>Town name:</td>
                      <td>
                          <select name="town" id="townid" style="width:150px;height:20px;font-size:12px;font-family:verdana;" onchange="showDivisions(this.value);">

                         <option value="-1">Select Town</option>


                       </select>
                      </td>
                  </tr>
 		<tr>
                      <td>Select Division : </td>



                       <td>
                       <select name="divisionname" id="divisionId" style="width:150px;height:20px;font-size:12px;font-family:verdana;" onchange="showSubDivisions(this.value);">

                         <option value="-1">Select division</option>


                       </select>
                      </td></tr>
                <tr>
                      <td>Select SubDivision : </td>
                       <td>
                           <select name="subdivisionname" id="subdivisionId" style="width:150px;height:20px;font-size:12px;font-family:verdana;" onchange="showSubstations(this.value);">

                         <option value="-1">Select subdivision</option>


                       </select>
                      </td>
                  </tr>
	
                <tr>

                      <td align="left">Select SubStation : </td>


                       <td>
                       <select name="ss" id="ssId" style="width:150px;height:20px;font-size:12px;font-family:verdana;" onchange="showFeeders(this.value);">

                         <option value="-1">Select substation</option>


                       </select>
                      </td>
                  </tr>

		<tr>
                      <td align="left">Select Feeder : </td>


                       <td>
                       <select name="feeder" id="feederId" style="width:150px;height:20px;font-size:12px;font-family:verdana;" onchange="showHT(this.value);">

                         <option value="-1">Select Feeder</option>


                       </select>
                      </td>


                  </tr>
                  <tr>
                      <td align="left">Select HT : </td>


                       <td>
                       <select name="ht" id="htId" style="width:150px;height:20px;font-size:12px;font-family:verdana;" onchange="showhtMeter(this.value);">

                         <option value="-1">Select HT</option>


                       </select>
                      </td>


                  </tr>
                   <tr><td >Mapped HTMeter:</td>
        <td><input type="text" id="mappedMeter">
            </td>
         </tr>
         <tr><td >Select HTMeter:</td>
        <td><select name="meter" id="newmeterId"  style="width:150px;height:20px;font-size:12px;font-family:verdana;">
                     <option  value="-1">Select Meter</option>
                     <%

                                try {
                                    pstmt2 = con2.prepareStatement("select * from meter where meterlocation in (select locationid from meterlocation where locationname='HT') and htconsumerid is null");
                                    rs2 = pstmt2.executeQuery();
                                    while (rs2.next()) {
                    %>
                <option value="<%=rs2.getString("meterid")%>"><%=rs2.getString("meter_serial_no")%></option>
          <%
                                    }

                                } catch (Exception e) {
                                    e.printStackTrace();
                                }
                    %>
            </select>
            </td>
         </tr>


                  <tr >
                      <td></td>

                      <td colspan="2"><input type="button" value="Update" onclick="updateHTMeter()"  /></td>
                  </tr>


              </table>
          </form>
    </body>
</html>
