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


<form name="s1" id="form1" action="addSubStationData.jsp">
    <div id="ssone">
        <table bgcolor="#E0ECF8" cellpadding="5" cellspacing="5"  id="table1" width="350px">
            <tr><th colspan="2"><h2><u> Updating Section</u></h2></th></tr>
            <tr><td>&nbsp;</td>
                <td>&nbsp;</td></tr>
            <tr>
                <td >Zone name:</td>
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
                        %>


                    </select>
                </td>
            </tr>

            <tr>
                <td>Circle name:</td>
                <td>
                    <select name="circle" id="circleId" style="width:150px;height:20px;font-size:12px;font-family:verdana;" onchange="showDivisions(this.value);">

                        <option value="-1">Select Circle</option>


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
                    <select name="subdivisionname" id="subdivisionId" style="width:150px;height:20px;font-size:12px;font-family:verdana;" onchange="showSections(this.value);">

                        <option value="-1">Select subdivision</option>


                    </select>
                </td>
            </tr>
            <tr>
                <td align="left">Select Section : </td>


                <td>
                    <select name="section" id="sectionId" style="width:150px;height:20px;font-size:12px;font-family:verdana;" onchange="oldSection();">

                        <option value="-1">Select section</option>


                    </select>
                </td>
            </tr></table></div>
    <div id="sstwo" >
        <table bgcolor="#E0ECF8" width="350px"  >
            <tr>
                <td>SectionId:</td>
                <td><input type="text" id="sid" readonly></td>
            </tr>
            <tr>
                <td align="left">change SectionName : </td>
                <td><input type="text" name="news" id="sname"></td>

            </tr>
            <tr>
                <td>select subdivision:</td>
                <td>
                    <select name="newsd" id="newsd" style="width:150px;height:20px;font-size:12px;font-family:verdana;" >

                        <option value="-1">Select subdivision</option>
                    </select>
                </td>
            </tr>
            <tr><td></td>
                <td><input type="button" value="update" onclick="newSection()"></td>
            </tr></table>
    </div>

</form>
