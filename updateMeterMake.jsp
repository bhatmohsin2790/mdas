<%@ page session="false" %>

<%@page import="in.amitech.db.DBUtil"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>


<table align="center" bgcolor="#E0ECF8" cellpadding="5" cellspacing="5">
    <tr><td>METERMAKE:</td>
        <td><select  name="metermakeid" id="Metermakeid" style="width: 200px;" onchange="getMetermake();">

                <option>select Metermake</option>

                <%
                            Statement stmtumm = null;
                            ResultSet rsumm = null;
                            Connection conumm = null;
                            conumm = new DBUtil().getConnection();
                            try {

                                stmtumm = conumm.createStatement();
                                rsumm = stmtumm.executeQuery("SELECT * FROM  metermake");
                                while (rsumm.next()) {
                                    out.println("<option value=" + rsumm.getString("metermakeid") + " >" + rsumm.getString("metermakename") + "</option>");
                                }
                            } catch (Exception e) {
                            }

                %>
            </select>
        </td></tr>
    <tr><td>METERMAKENAME:</td>
        <td><input  name="metermakeName" id="MetermakeName" type="text"></td></tr>
    <tr><td>
            METER_SERIES:</td><td>
            <input name="meterSeries" id="MeterSeries" type="text" ></td></tr>
    <tr><td>
            METER_VERSION:</td><td>
            <input name="meterVersion" id="MeterVersion" type="text"></td></tr>
    <!--
        <tr><td>
                NO_OF_PARAMS:</td><td>
                <input name="noofParams" id="NoofParams" type="text" ></td></tr>
        <tr><td>
                PARAM_NAMES:</td><td>
                <input name="paramNames" id="ParamNames" type="text" ></td></tr>
        <tr><td>
                B4_TOD_PARAMS:</td><td>
                <input name="b4_Tod_Params" id="B4_Tod_Params" type="text" ></td></tr>
        <tr><td>
                D4_PARAMS:</td><td>
                <input name="d4_Params" id="D4_Params"type="text" ></td></tr>
        <tr><td></td><td>
    -->

    <tr><td></td><td></td></tr>
    <tr><td></td><td></td></tr>
    <tr><td></td><td> <input type="button" value="UPDATE" onclick="updateMetermake()"></td></tr>
</table>
<%
            if (rsumm != null) {
                rsumm.close();
            }
            if (stmtumm != null) {
                stmtumm.close();
            }
            if (conumm != null) {
                conumm.close();
            }
%>