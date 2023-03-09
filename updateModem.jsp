<%@ page session="false" %>
<%@page import="in.amitech.db.DBUtil"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>

 <table align="center" bgcolor="#E0ECF8" cellpadding="5" cellspacing="5">
    <tr><td>MODEM</td>
        <td> <select  name="modemid" id="ModemId" style="width: 202px;" onchange="getModemData(this.value);">

                <option>select Modem</option>

                <%
                            Statement stmtgmd = null;
                            ResultSet rsgmd = null;
                            Connection con = null;
                            con = new DBUtil().getConnection();
                            try {

                                stmtgmd = con.createStatement();
                                rsgmd = stmtgmd.executeQuery("SELECT * FROM  modem order by modem_serial_no ");
                                while (rsgmd.next()) {
                                    out.println("<option value=" + rsgmd.getString("modem_id") + " >" + rsgmd.getString("modem_serial_no") + "</option>");
                                }
                            } catch (Exception e) {
                            }

                %>

            </select><td></tr>

    <tr> <td> MODEM:</td><td>
            <input name="modem_serial_no" id="Modem_serial_no" type="text"></td></tr>



   


    <tr><td>     MOBILE_NO:</td><td>
            <input name="mobile_no" id="Mobile_no" type="text" ></td></tr>
     <tr><td>       IMEI NO:</td><td>
            <input name="imei_no" id="imei_no" type="text" ></td></tr>
      <tr><td>     STATIC IP:</td><td>
            <input name="static_ip" id="static_ip" type="text" ></td></tr>
 <!--   <tr><td>       IS_DCU:</td><td>
            <input name="is_dcu" id="Is_dcu" type="text" ></td></tr>


    <tr><td>     DCU_ID:</td><td>
            <input name="dcu_id" id="Dcu_id" type="text" ></td></tr> -->

    <tr><td></td><td><input type="button" value="update"  onclick="updateModem()"></tr>


</table>