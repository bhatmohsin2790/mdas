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

<form name="dtr" action=""  >
    <table align="center" bgcolor="#E0ECF8"  cellpadding="5" cellspacing="5">
        <tr><th colspan="2"><h2><u> Delete DTR</u></h2></th></tr>
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
                        }
    finally{
        con.close();
    }
                    %>

                </select>
            </td>
        </tr>

        <tr>
            <td>Circle name:</td>
            <td>
                <select name="circle" id="circleId" style="width:150px;height:20px;font-size:12px;font-family:verdana;" onchange="showTowns(this.value);">

                    <option value="-1">Select Circle</option>


                </select>
            </td>
        </tr>
        <tr>
            <td>Town name:</td>
            <td>
                <select name="circle" id="townId" style="width:150px;height:20px;font-size:12px;font-family:verdana;" onchange="showDivisions(this.value);">

                    <option value="-1">Select Town</option>


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
                <select name="subdivisionname" id="subdivisionId" style="width:150px;height:20px;font-size:12px;font-family:verdana;" onchange="showSubstations(this.value);">

                    <option value="-1">Select subdivision</option>


                </select>
            </td>
        </tr>        

        <tr>
            <td align="left">Select SubStation : </td>


            <td>
                <select name="ss" id="ssId" style="width:150px;height:20px;font-size:12px;font-family:verdana;" onchange="showFeeders(this.value);">

                    <option value="-1">Select substation</option>


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
                <select name="dtr" id="dtrId" style="width:150px;height:20px;font-size:12px;font-family:verdana;">

                    <option value="-1">Select DTR</option>


                </select>
            </td>
        </tr>
        <tr>
            <td></td>
            <td><input type="button" value="delete "  onclick="deleteDtr()"/></td>
        </tr>


    </table>
</form>