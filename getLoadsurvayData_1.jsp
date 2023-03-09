<%@ page session="false" %><%@ include file="report_header.jsp"%>
<%@page import="in.amitech.db.DBUtil"%>
<%@ page import="java.sql.*"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.text.DecimalFormat"%>
<%!     PreparedStatement pstmt = null;
    ResultSet rs = null;
%>
<%
    Connection con = null;
    try {
        String meter_id = "";
        if (request.getParameter("meter_id") == null || request.getParameter("meter_id") == "") {
            meter_id = (String) session.getAttribute("meter_id");
        } else {
            meter_id = request.getParameter("meter_id");
        }
        session.setAttribute("meter_id", meter_id);
        String stringToReturn = "";
        con = new DBUtil().getConnection();
%>


<br>
<div  style="overflow:scroll;width:1050px;height:450px"  >
    <table width="1050px;" border="0">
        <tr bgcolor="#56a5ec">
            <td colspan="51" align="center" class="head1">
                LoadSurvay Data
            </td>
        </tr>
    </table>
    <table class="mtable">
        <tr>
            <td class="td1" width="170px">
                MeterId
            </td>
            <td class="td1" width="170px">
                LoadSurvay Dates
            </td>
            <td class="td1" width="170px">
                ParameterType
            </td>
            <%
       for (int i = 1; i <= 48; i++) {%>
            <td class="td1" width="170px">
                RDNG<%=i%>
            </td>
            <%}%>
        </tr>
    </table>
</div>
<%
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        con.close();
    }
%>