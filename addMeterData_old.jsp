<%@ page session="false" %>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="in.amitech.db.DBUtil"%>
<%! PreparedStatement pstmt = null;
    Connection con = null;
    ResultSet rs = null;

%>
<form action=""  name="meter">


    <table align="center" bgcolor="#E0ECF8" cellpadding="5" cellspacing="5">

        <tr><th colspan="4"><h2><u>Meter Information</u></h2></th></tr>
        <tr>
            <td>
                METER_SERIAL_NO:</td><td>
                <input name="metersno" id="metersno" type="text" ></td>
            <td></td>

            <td></td>
        </tr>
        <tr><td>
                METERMAKE:</td><td>
                <select name="meterMake" id="meterMake" style="width: 200px;">

                    <option value="-1">Select Metermake</option>
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
                                }
                                 finally
                                        {
                                    con.close();
                                    }
                    %>
                </select></td>
            <td>
                METERLOCATION:</td><td>
                <select name="meterLoc" id="meterLoc" style="width: 200px;">
                    <option value="-1">Select MeterLocation</option>
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
                                }
                                 finally
                                        {
                                    con.close();
                                    }
                    %>

                </select></td></tr>
        <tr><td>

                PROG_PT_PRI:</td><td>
                <input name="prog_PT_PRI" id="prog_PT_PRI" type="text" ></td>
            <td>
                PROG_PT_SEC:</td><td>
                <input name="prog_PT_SEC" id="prog_PT_SEC" type="text" ></td></tr>
        <tr><td>

                PROG_CT_PRI:</td><td>
                <input name="prog_CT_PRI" id="prog_CT_PRI" type="text" ></td>
            <td>
                PROG_CT_SEC:</td><td>
                <input name="prog_CT_SEC" id="prog_CT_SEC" type="text" ></td></tr>
        <tr><td>

                METER_CLASS:</td><td>
                <input name="meterClass" id="meterClass" type="text" ></td>
            <td>
                METER_RATING:</td><td>
                <input name="meterRating" id="meterRating"type="text"></td></tr>
        <tr><td>
                METER_TYPE:</td><td>
                <input name="meterType" id="meterType"type="text" ></td>
            <td>
                METER_SCALING:</td><td>
                <input name="meterScaling" id="meterScaling" type="text" ></td></tr>
        <tr><td>

                METER_PROG:</td><td>
                <input name="meterProg" id="meterProg" type="text"></td>
            <td>
                METER_CUM_COUNT:</td><td>
                <input name="meter_cum_count" id="meter_cum_count" type="text"></td></tr>
        <tr><td>

                MAN_NAME:</td><td>
                <input name="man_name" id="man_name" type="text"></td>
            <td>       MAN_CODE:</td><td>
                <input name="man_Code" id="man_Code" type="text"></td></tr>

        <tr><td>       RST_COUNT:</td><td>
                <input name="rst_Count" id="rst_Count" type="text" ></td>
            <td>     MIOS_MEM_ID:</td><td>
                <input name="mios_Mem_Id" id="mios_Mem_Id" type="text" ></td></tr>

        <tr><td>         METER_ADD_INFO:</td><td>
                <input name="meter_Add_Info" id="meter_Add_Info" type="text"></td>
            <td>        METER_TIMESTAMP:</td><td>
                <input name="meter_Timestamp" id="meter_Timestamp" type="text"></td></tr>

        <tr><td>       LOG_TIMESTAMP:</td><td>
                <input name="log_Timestamp" id="log_Timestamp" type="text" ></td>
            <td>        MODEM_SERIAL_NO:</td><td>
                <input name="modem_Serial_No" id="modem_Serial_No" type="text" ></td></tr>

        <tr><td>     MODEM_IMEI:</td><td>
                <input name="modem_Imei" id="modem_Imei" type="text" ></td></tr>




        <tr><td></td><td></td><td>

                <input type="button" value="ADD" onclick="insertMeter()"></td></tr>





    </table>


</form>








<!--<html>
    <head><title></title></head>
    <body>
        <form action="master_data/InsertMeterData.jsp">

<table align="center" bgcolor="#E0ECF8" cellpadding="5" cellspacing="5">

    <tr><th colspan="4"><h2>Meter Information</h2></th></tr>
    <tr><td>

            METERID:</td><td>
            <input name="meterid" type="text" ></td>
    <td>
            METER_SERIAL_NO:</td><td>
            <input name="metersno" type="text" ></td></tr>
    <tr><td>
        METERMAKE:</td><td>
            <select name="metermake" >
                <option>LNT</option>
                <option>SECURE</option>
                <option>DLMS</option>
            </select></td>
    <td>
            METERLOCATION:</td><td>
            <select name="meterloc">
                <option>FEEDER</option>
                <option>DTR</option>
                <option>HT</option>
                <option>LT</option>

            </select></td></tr>
    <tr><td>

            PROG_PT_PRI:</td><td>
            <input name="prog_PT_PRI" type="text" ></td>
    <td>
            PROG_PT_SEC:</td><td>
            <input name="prog_PT_SEC" type="text" ></td></tr>
    <tr><td>

            PROG_CT_PRI:</td><td>
            <input name="prog_CT_PRI"type="text" ></td>
    <td>
            PROG_CT_SEC:</td><td>
            <input name="prog_CT_SEC"type="text" ></td></tr>
    <tr><td>

            METER_CLASS:</td><td>
            <input name="meterClass" type="text" ></td>
    <td>
            METER_RATING:</td><td>
            <input name="meterRating"type="text"></td></tr>
    <tr><td>
           METER_TYPE:</td><td>
            <input name="meterType"type="text" ></td>
   <td>
           METER_SCALING:</td><td>
            <input name="meterScaling"type="text" ></td></tr>
    <tr><td>

           METER_PROG:</td><td>
            <input name="meterProg" type="text"></td>
  <td>
           METER_CUM_COUNT:</td><td>
           <input name="meter_cum_count" type="text"></td></tr>
    <tr><td>

            MAN_NAME:</td><td>
            <input name="man_name" type="text"></td>
      <td>       MAN_CODE:</td><td>
            <input name="man_Code" type="text"></td></tr>

      <tr><td>       RST_COUNT:</td><td>
            <input name="rst_Count" type="text" ></td>
      <td>     MIOS_MEM_ID:</td><td>
            <input name="mios_Mem_Id" type="text" ></td></tr>

    <tr><td>         METER_ADD_INFO:</td><td>
            <input name="meter_Add_Info" type="text"></td>
   <td>        METER_TIMESTAMP:</td><td>
            <input name="meter_Timestamp" type="text"></td></tr>

     <tr><td>       LOG_TIMESTAMP:</td><td>
            <input name="log_Timestamp" type="text" ></td>
    <td>        MODEM_SERIAL_NO:</td><td>
            <input name="modem_Serial_No" type="text" ></td></tr>

      <tr><td>     MODEM_IMEI:</td><td>
            <input name="modem_Imei" type="text" ></td></tr>




      <tr><td></td><td></td><td>

            <input type="submit" value="ADD" ></td></tr>





</table>


        </form>
    </body>
</html>-->