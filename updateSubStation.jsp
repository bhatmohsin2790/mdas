<%@ page session="false" %>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="in.amitech.db.DBUtil"%>


      <%
            Connection con = new DBUtil().getConnection();
            PreparedStatement pstmt = null;
            ResultSet rs = null;
      %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <form name="ss" action=""  >
            <div id="ssone" style="position:absolute;top:250px">
                <table align="center" bgcolor="#E0ECF8"  cellpadding="5" cellspacing="5" width="350px">
                       <tr><th colspan="2"><h2><u> Choose Substation to change</u></h2></th></tr>
                       <tr><td></td>
                           <td></td>
                       </tr>
                  		<tr>
                      <td>Zone name:</td>
                      <td>
                        <select name="zone" id="zone" style="width:150px;height:20px;font-size:12px;font-family:verdana;" onchange="showCircles(this.value);">
                        <option value="-1">Select Zone</option>
                           <%

                                try {
                                    pstmt = con.prepareStatement("select * from zone");
                                    rs = pstmt.executeQuery();
                                    while (rs.next()) {
                    %>
                <option value="<%=rs.getString("zoneid")%>"><%=rs.getString("zonename")%></option>
          <%
                                    }

                                } catch (Exception e) {
                                    e.printStackTrace();
                                    con.close();
                                }
                    %>
                       </select>
                      </td>
                  </tr>
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
                          <select name="town" id="townId" style="width:150px;height:20px;font-size:12px;font-family:verdana;" onchange="showDivisions(this.value);">
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
                      </td>
                  </tr>
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
                           <select name="ss" id="ssId" style="width:150px;height:20px;font-size:12px;font-family:verdana;" onchange="oldSs();">
                         <option value="-1">Select substation</option>
                       </select>
                      </td>
                  </tr>
                </table>
            </div>
                    <div id="sstwo"  >                        
                        <table bgcolor="#E0ECF8" width="350px" style="position:absolute;top:250px;left:600px">
                            <tr><th colspan="2"><h2><u> Update Substation</u></h2></th></tr>&nbsp;&nbsp;
                            <tr>
                                <td>SubStation Id:</td>
                                <td><input type="text" id="newsid" readonly></td>
                            </tr>
                            <tr>
                                <td>Change SubstationName:</td>
                                <td><input type="text" id="ssname"></td>
                            </tr>
                  <tr>
                      <td align="left">Select SubDivision : </td>
                      <td>
                           <select name="newsubdivision" id="newsubdivisionId" style="width:150px;height:20px;font-size:12px;font-family:verdana;" >
                          <option value="-1">Select SubDivision</option>                 
                       </select>
                      </td>
                  </tr>
                  <tr>
                      <td></td>
                      <td><input type="button" value="update"  onclick="newSs()"/></td>
                  </tr>
              </table>
                    </div>
          </form>
    </body>
</html>
