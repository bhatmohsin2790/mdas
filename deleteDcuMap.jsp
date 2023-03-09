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
        <form name="feeder" action="" >
              <table align="center" bgcolor="#E0ECF8" cellpadding="5" cellspacing="5">
                    <tr><th colspan="2"><h2><u> Delete DCU_Mapping  </u></h2></th></tr>


		<tr>
                      <td align="left">Select Section : </td>


                       <td>
                       <select name="section" id="sectionId" style="width:150px;height:20px;font-size:12px;font-family:verdana;" onchange="showSubStations(this.value);">

                         <option value="-1">Select section</option>
                           <%

                                try {
                                    pstmt = con.prepareStatement("select * from section");
                                    rs = pstmt.executeQuery();
                                    while (rs.next()) {
                    %>
                <option value="<%=rs.getString("sectionid")%>"><%=rs.getString("sectionname")%></option>
          <%
                                    }

                                } catch (Exception e) {
                                    e.printStackTrace();
                                }
                                finally
                                        {
                                    con.close();
                                    }
                    %>
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
                      <td align="left">Select Dcu : </td>

                       <td>
                           <select name="dcu" id="dcuId" style="width:150px;height:20px;font-size:12px;font-family:verdana;" onchange="showModemMapping(this.value);">

                         <option value="-1">Select dcu</option>

                       </select>
                      </td>
                  </tr>
                  <tr>
                      <td align="left">Mapped Modem : </td>

                       <td>
                           <input type="text" id="mappedModem">
                      </td>
                  </tr>

                  <tr>
                      <td></td>
                      <td><input type="button" value="delete " onclick="deleteDCUMap()"/></td>
                  </tr>


              </table>
          </form>
    </body>
</html>
