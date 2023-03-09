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
                <tr> <th colspan="2"><h2><u>Add Meter to DTR</u></h2></th></tr>
                <tr>
                    <td align="left" height="30px"><label>Select Substation:</label></td>
                    <td><select  onchange="showFeeders(this.value);">

                            <option value="-1">Select Substation</option>
                            <%

                                try {
                                    //pstmt = con.prepareStatement("select sb.substationid,sb.substationname,t.townname from substation sb,town t where sb.townid=t.townid");
									pstmt = con.prepareStatement("select * from substation order by substationname");
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
                        <select name="feeder" id="feederId" style="width:150px;height:20px;font-size:12px;font-family:verdana;" onchange="showDtrs(this.value);">

                            <option value="-1">Select Feeder</option>


                        </select>
                    </td>
                </tr>
                <tr>
                    <td>select DTR:</td>
                    <td>
                        <select name="dtr" id="dtrId" style="width:150px;height:20px;font-size:12px;font-family:verdana;" >

                            <option value="-1">Select DTR</option>


                        </select>
                    </td>
                </tr>
                <tr><td >Select Meter:</td>
                    <td><select name="meter" id="meterId"  style="width:150px;height:20px;font-size:12px;font-family:verdana;">
                            <option  value="-1">Select Meter</option>
                            <%

                                try {
                                    pstmt = con.prepareStatement("select * from meter where meterlocation in (select locationid from meterlocation where locationname='DTR') and dtrid is null");
                                    rs = pstmt.executeQuery();
                                    while (rs.next()) {
                            %>
                            <option value="<%=rs.getString("meterid")%>"><%=rs.getString("meter_serial_no")%></option>
                            <%
                                    }

                                } catch (Exception e) {
                                    e.printStackTrace();
                                } finally {
                                    con.close();
                                }
                            %>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td></td>
                    <td> <input type="button"  onclick="insertDtrMeter()"value="ADD" ></td></tr></table>
        </form>
    </body>
</html>
<%
    if (con != null) {
        con.close();
    }
%>