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

        <tr><th colspan="4"><h2><u> CHANGE METER INFO</u></h2></th></tr>
        <tr>
            <td>
                Meter Sl No:</td>
            <td><select name="meterno" id="meterno" onchange="getDetailsFromWS(this.value)">
                    <option value="-1">select meter no</option>
                    <%
                                   Connection con1 = null;
                                    Statement st = null;
                                    String sql = null;
                                    sql = "select meter_serial_no,consumerid from meter where htconsumerid is not null and consumerid is not null";
                                    con1 = new DBUtil().getConnection();
                                    st = con1.createStatement();
                                    ResultSet rs = st.executeQuery(sql);
                                    while (rs.next()) {
                    %>
                     <option value="<%=rs.getString("consumerid") %>"><%= rs.getString("meter_serial_no")%> </option>
               
            <% } %>
             </select></td>
            <td></td>

            <td></td>
        </tr>

        <tr><td>
                Consumer Code :</td><td>
                <input name="cc" id="cc" type="text" readonly></td>
            <td>
                Consumer Name</td><td>
                <input name="cname" id="cname" type="text" readonly></td></tr>
        <tr><td>
                Addr1:</td><td>
                <input name="addr1" id="addr1" type="text" readonly></td>
            <td>
                Addr2:</td><td>
                <input name="addr2" id="addr2" type="text" readonly></td></tr>

        <tr><td>
                Sanction Load:</td><td>
                <input name="load" id="load" type="text" readonly></td>
            <td>
                SDO:</td><td>
                <input name="sdo" id="sdo" type="text" readonly></td></tr>
        <tr>
            <td>Feeder:</td>
            <td>
                <input name="feeder" id="feeder" type="text" readonly></td>
            </td>
            <td>
                Replaced Meter:</td><td>
                <input name="replacedmeter" id="replacedmeter" type="text"></td>  
            
                
            </tr>
   

        <tr><td></td><td></td><td>

                <input type="button" value="Update" onclick="changeMeterInfo()"></td></tr>

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

