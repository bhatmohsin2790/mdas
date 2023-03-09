<%@ page session="false" %>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="in.amitech.db.DBUtil"%>


<table align="center" bgcolor="#E0ECF8" cellpadding="5" cellspacing="5">
   <tr><th colspan="4"><h2>Meter Make</h2></th></tr>
    <tr><td>
           METERMAKE:</td><td>
           <select name="Metermake" id="Metermake" style="width: 200px;">

                    <option value="-1">Select Metermake</option>
                    <%
                                Connection con = new DBUtil().getConnection();
                                try {
                                    PreparedStatement pstmt = con.prepareStatement("select * from metermake");
                                    ResultSet rs = pstmt.executeQuery();
                                    while (rs.next()) {
                    %>
                    <option value="<%=rs.getString("metermakeid")%>"><%=rs.getString("metermakename")%></option>
                    <%
                                    }

                                } catch (Exception e) {
                                    e.printStackTrace();
                                }
                                finally{
                                    con.close();
                                }
                    %>
                </select>
        </td></tr>
  <!--  <tr><td>
            METERMAKENAME:</td><td>
            <input name="metermakeName" type="text" ></td></tr>
    <tr><td>
            METER_SERIES:</td><td>
            <input name="meterSeries" type="text" ></td></tr>
    <tr><td>
           METER_VERSION:</td><td>
            <input name="meterVersion" type="text"></td></tr>
    <tr><td>
            NO_OF_PARAMS:</td><td>
            <input name="noofParams" type="text" ></td></tr>
    <tr><td>
            PARAM_NAMES:</td><td>
            <input name="paramNames" type="text" ></td></tr>
    <tr><td>
            B4_TOD_PARAMS:</td><td>
            <input name="b4_Tod_Params" type="text" ></td></tr>
    <tr><td>
            D4_PARAMS:</td><td>
            <input name="d4_Params" type="text" ></td.</tr> -->
    <tr><td></td><td>

            <input type="button" value="Delete" onclick="deleteMetermake()"></td></tr>



</table>

       