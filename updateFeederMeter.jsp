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
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <form action="" name="feeder">
             <table align="center" bgcolor="#E0ECF5" cellpadding="5" cellspacing="5">
                 <tr> <th colspan="2"><h2><u>Update Feeder_Meter Mapping</u></h2></th></tr>
                <tr>
                    <td align="left" height="30px"><label>Select Substation:</label></td>
                    <td><select  onchange="showFeeders(this.value);">

                                <option value="-1">Select Substation</option>
                          <%

                                try {
                                    pstmt = con.prepareStatement("select * from substation");
                                    rs = pstmt.executeQuery();
                                    while (rs.next()) {
                    %>
                <option value="<%=rs.getString("substationid")%>"><%=rs.getString("substationname")%></option>
          <%
                                    }

                                } catch (Exception e) {
                                    e.printStackTrace();
                                }
                    %>
                        </select>
                    </td>
                </tr>

                <tr>
                      <td align="left">Select Feeder : </td>


                       <td>
                       <select name="feeder" id="feederId" style="width:150px;height:20px;font-size:12px;font-family:verdana;" onchange="showFeederMeter(this.value);">

                         <option value="-1">Select Feeder</option>


                       </select>
                      </td>
                  </tr>

         <tr><td >Mapped Meter:</td>
        <td><input type="text" id="feederMeter">
            </td>
         </tr>
         <tr><td >Select Meter:</td>
        <td><select name="meter" id="newmeterId"  style="width:150px;height:20px;font-size:12px;font-family:verdana;">
                     <option  value="-1">Select Meter</option>
                     <%

                                try {
                                    pstmt = con.prepareStatement("select * from meter where meterlocation in (select locationid from meterlocation where locationname='Feeder') and feederid is null");
                                    rs = pstmt.executeQuery();
                                    while (rs.next()) {
                    %>
                <option value="<%=rs.getString("meterid")%>"><%=rs.getString("meter_serial_no")%></option>
          <%
                                    }

                                } catch (Exception e) {
                                    e.printStackTrace();
                                }
                    %>
            </select>
            </td>
         </tr>
         <tr>
             <td></td>
             <td> <input type="button"  onclick="updateFeederMeter()"value="Update" ></td></tr></table>
        </form>
    </body>
</html>