<%@ page session="false" %>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="in.amitech.db.DBUtil"%>
<script type="text/javascript" src="date-picker.js"></script>

<%
            Connection con = new DBUtil().getConnection();
            PreparedStatement pstmt = null;
            ResultSet rs = null;
%>

<form name="HT"  action="">
    <table align="center" bgcolor="#E0ECF8" cellpadding="5" cellspacing="5">
        <tr><th colspan="4"><h2><u> Add HT Consumer</u></h2></th></tr>
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

            <td>Circle name:</td>
            <td>
                <select name="circle" id="circleId" style="width:150px;height:20px;font-size:12px;font-family:verdana;" onchange="showTowns(this.value);">

                    <option value="-1">Select Circle</option>


                </select>
            </td>
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

            <td>Consumer name<sup style="color:red">*</sup>:</td>
            <td><input type="text" name="consumer" id="consumer"/></td>
        </tr>
        <tr>
            <td>Address<sup style="color:red">*</sup>:</td>
            <td><input type="text" name="address" id="address"/></td>
            <td>Mobile No<sup style="color:red">*</sup>:</td>
            <td><input type="text" name="mobile" id="mobile"/></td>
        </tr>
        <tr>
            <td>Phone No:</td>
            <td><input type="text" name="phone" id="phone"/></td>
            <td>Email Id<sup style="color:red">*</sup>:</td>
            <td><input type="text" name="email" id="email"/></td>
        </tr>
        <tr>
            <td>Alt Email:</td>
            <td><input type="text" name="altemail" id="altemail"/></td>
            <td>concession:</td>
            <td><input type="text" name="concession" id="concession"/></td>
        </tr>
        <tr>
            <td>AgrmntFromDate<sup style="color:red">*</sup>:</td>
            <td><input type="text" readonly="true" size="10" name="startingDate" id="startingDate"/>
                <a href="javascript:show_calendar('HT.startingDate')"> <img src="images/cal.gif" id="sdate"  width=24 height=22 border=0/></a>
            </td>
            <td>AgrmntToDate<sup style="color:red">*</sup>:</td>
            <td><input type="text" readonly="true" size="10" name="endingDate" id="endingDate"/>
                <a href="javascript:show_calendar('HT.endingDate')"> <img src="images/cal.gif" id="edate"  width=24 height=22 border=0/></a>
            </td>
        </tr>
        <tr>
            <td>ConletterNo:</td>
            <td><input type="text" name="ConletterNo" id="ConletterNo"/></td>
            <td>Rebate:</td>
            <td><input type="text" name="rebate" id="rebate"/></td>
        </tr>


        <tr >
            <td style="color: red">* filelds are compulsary</td>
            <td></td>

            <td><input type="button" value="add consumer" onclick="insertHT()"  /></td>
        </tr>


    </table>
</form>