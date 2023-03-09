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
        <form name="dcu" action=""  >
            <div id="dcuone">
                <table  style="position:absolute;top:250px" bgcolor="#E0ECF8"  cellpadding="5" cellspacing="5" width="350px">
                       <tr><th colspan="2"><h2><u> Update DCU</u></h2></th></tr>
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
                      </td>
                  </tr>

		  <tr>
                      <td>Select SubDivision : </td>
                       <td>
                           <select name="subdivisionname" id="subdivisionId" style="width:150px;height:20px;font-size:12px;font-family:verdana;" onchange="showSections(this.value);">

                         <option value="-1">Select subdivision</option>


                       </select>
                      </td>
                  </tr>

		<tr>
                      <td align="left">Select Section : </td>


                       <td>
                       <select name="section" id="sectionId" style="width:150px;height:20px;font-size:12px;font-family:verdana;" onchange="showSubStations(this.value);">

                         <option value="-1">Select section</option>


                       </select>
                      </td>
                  </tr>

		 <tr>
                      <td align="left">Select SubStation : </td>


                       <td>
                           <select name="ss" id="ssId" style="width:150px;height:20px;font-size:12px;font-family:verdana;" onchange="showDcu(this.value);">

                         <option value="-1">Select substation</option>


                       </select>
                      </td>
                  </tr>

                  <tr>
                      <td align="left">Select DCU : </td>


                       <td>
                           <select name="dcu" id="dcuId" style="width:150px;height:20px;font-size:12px;font-family:verdana;" onchange="oldDcu();">

                         <option value="-1">Select dcu</option>


                       </select>
                      </td>
                  </tr>
                </table>
            </div>
                    <div id="dcutwo" >
                        <table bgcolor="#E0ECF8" width="350px" style="position:absolute;top:250px;left:600px">
                            <tr>
                                <td>DCU Id:</td>
                                <td>
                                    <input type="text" id="dcuid"></td></tr>
                            <tr>
                                <td>Change DCUName:</td>
                                <td><input type="text" id="dcuName"></td>
                            </tr>
                            <tr>
                                <td>Select SubStation:</td>
                                <td>
                                  <select name="newss" id="newss" style="width:150px;height:20px;font-size:12px;font-family:verdana;" >

                              <option value="-1">Select substation</option>
                                </td>

                  <tr>
                      <td></td>
                      <td><input type="button" value="update "  onclick="newDcu()"/></td>
                  </tr>


              </table>
                    </div>
          </form>
    </body>
</html>
