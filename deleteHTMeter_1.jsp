<%@ page session="false" %>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="in.amitech.db.DBUtil"%>
<script type="text/javascript" src="date-picker.js"></script>

      <%
                               Connection con1 = new DBUtil().getConnection();
                                PreparedStatement pstmt1 = null;
                                ResultSet rs1 = null;
              %>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <form name="HT"  action="">
              <table align="center" bgcolor="#E0ECF8" cellpadding="5" cellspacing="5">
                  <tr><th colspan="2" ><h2><u> Delete HT_Meter Mapping</u></h2></th></tr>
                  		<tr>
                      <td>Zone name:</td>
                      <td>
                       <select name="zone" id="zone" style="width:150px;height:20px;font-size:12px;font-family:verdana;" onchange="showCircles(this.value);">

                         <option value="-1">Select Zone</option>
                          <%

                                try {
                                    pstmt1 = con1.prepareStatement("select * from zone");
                                    rs1 = pstmt1.executeQuery();
                                    while (rs1.next()) {
                    %>
                <option value="<%=rs1.getString("zoneid")%>"><%=rs1.getString("zonename")%></option>
          <%
                                    }

                                } catch (Exception e) {
                                    e.printStackTrace();
                                }
                                finally{
                                    con1.close();
                                }
                    %>


                       </select>
                      </td></tr>
                                <tr>

                      <td>Circle name:</td>
                      <td>
                          <select name="circle" id="circleId" style="width:150px;height:20px;font-size:12px;font-family:verdana;" onchange="showDivisions(this.value);">

                         <option value="-1">Select Circle</option>


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
                           <select name="subdivisionname" id="subdivisionId" style="width:150px;height:20px;font-size:12px;font-family:verdana;" onchange="showSections(this.value);">

                         <option value="-1">Select subdivision</option>


                       </select>
                      </td>
                  </tr>

		<tr>
                      <td align="left">Select section : </td>


                       <td>
                           <select name="section" id="sectionId" style="width:150px;height:20px;font-size:12px;font-family:verdana;" onchange="showSubStations(this.value);">

                         <option value="-1">Select section</option>


                       </select>
                      </td></tr>
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
                           <select name="ht" id="htId" style="width:150px;height:20px;font-size:12px;font-family:verdana;"  onchange="showhtMeter(this.value);">

                         <option value="-1">Select HT</option>


                       </select>
                      </td>


                  </tr>
                   <tr><td >Mapped HTMeter:</td>
        <td><input type="text" id="mappedMeter">
            </td>
         </tr>
                  <tr >
                      <td></td>

                      <td colspan="2"><input type="button" value="Delete " onclick="deleteHTMeter()"  /></td>
                  </tr>


              </table>
          </form>
    </body>
</html>
