<%@ page session="false" %>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.*" %>
<%@page import="java.sql.Connection"%>
<%@page import="in.amitech.db.DBUtil"%>
<%! PreparedStatement pstmt = null;
    Connection con = null;
    ResultSet rs = null;

%>
<form action=""  name="meter">


    <table align="center" bgcolor="#E0ECF8" cellpadding="5" cellspacing="5">

        <tr><th colspan="4"><h2><u> EDIT METER INFO</u></h2></th></tr>
        <tr>
            <td>
                Meter Sl No:</td>
            <td><select name="oldmeter " id="oldmeter" onchange="getmeterdetails(this.value)">
                    <option value="-1">select meter no</option>
                    <%
                                   Connection con1 = null;
                                    Statement st = null;
                                    String sql = null;
                                    sql = "select * from meter order by meter_serial_no";
                                    con1 = new DBUtil().getConnection();
                                    st = con1.createStatement();
                                    ResultSet rs = st.executeQuery(sql);
                                    while (rs.next()) {
                    %>
                     <option value="<%=rs.getString("meterid") %>"><%= rs.getString("meter_serial_no")%> </option>
               
            <% } %>
             </select></td>
            <td></td>

            <td></td>
        </tr>
        <tr><td>
                Meter Make:</td><td>
                <select name="meterMake" id="meterMake" style="width: 200px;">

                    <option value="-1">Select Meter make</option>
                    <%
                                con = new DBUtil().getConnection();

                                try {
                                    pstmt = con.prepareStatement("select * from metermake");
                                    rs = pstmt.executeQuery();
                                    while (rs.next()) {
                    %>
                    <option value="<%=rs.getString("metermakeid")%>"><%=rs.getString("metermakename")%></option>
                    <%
                                    }

                                } catch (Exception e) {
                                    e.printStackTrace();
                                } finally {
                                    con.close();
                                }
                    %>
                </select></td>
            <td>
                Meter Location:</td><td>
                <select name="meterLoc" id="meterLoc" style="width: 200px;">
                    <option value="-1">Select Meter Location</option>
                    <%
                                con = new DBUtil().getConnection();

                                try {
                                    pstmt = con.prepareStatement("select * from meterlocation");
                                    rs = pstmt.executeQuery();
                                    while (rs.next()) {
                    %>
                    <option value="<%=rs.getString("locationid")%>"><%=rs.getString("locationname")%></option>
                    <%
                                    }

                                } catch (Exception e) {
                                    e.printStackTrace();
                                } finally {
                                    con.close();
                                }
                    %>

                </select></td></tr>
        <tr><td>
                Meter CTR:</td><td>
                <input name="meterCTR" id="meterCTR" type="text" value="1.0"></td>
            <td>
                Meter PTR:</td><td>
                <input name="meterPTR" id="meterPTR" type="text" value="1.0"></td></tr>
        <tr><td>
                Adopted CTR:</td><td>
                <input name="adoptedCTR" id="adoptedCTR" type="text" value="1.0"></td>
            <td>
                Adopted PTR:</td><td>
                <input name="adoptedPTR" id="adoptedPTR" type="text" value="1.0"></td></tr>

        <tr><td>
                Class of Accuracy:</td><td>
                <input name="accuracy" id="accuracy"type="text" ></td>
            <td>
                Multiplication Factor:</td><td>
                <input name="mf" id="mf" type="text" value="1.0" disabled></td></tr>
        <tr><td>
                Meter Type:</td><td>
                <input name="meterType" id="meterType" type="text"></td>    
            <td>Modem SlNo:</td><td>
                <input name="modem_Serial_No" id="modem_Serial_No" type="text" ></td></tr>
        <tr><td>
                Location Code:</td><td>
                <input name="locationCode" id="locationCode" type="text"></td>       

            <td>Consumer Id:</td><td>
                <input name="consumerId" id="consumerId" type="text" ></td></tr>

        <tr><td></td><td></td><td>
                <input type="button" value="UPDATE" onclick="updateMeter()"></td></tr>

    </table>


</form>


<%
            if (rs != null) {
                rs.close();
            }
            if (pstmt != null) {
                pstmt.close();
            }
            if (con != null) {
                con.close();
            }


%>

