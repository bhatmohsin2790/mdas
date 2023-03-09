<%@ page session="false" %>
<%
String meterId=request.getParameter("meterId");
String requestType="MODEM_"+request.getParameter("requestType");
String startDate=request.getParameter("startDate");
String endDate=request.getParameter("endDate");
%>
<table border="1" bgcolor="#EDF5FA" id="table1">
<tr>
    <td align="center" colspan="9"><%=requestType%> </td>
            </tr>

             <tr>
                <td> Requested Id</td>
                <td> Requested Time Stamp</td>
                <td> Request Type</td>
                <td> Requested Data</td>
                <td> Response Count</td>
                <td> Response Time Stamp</td>
                <td> Modem Seroal Number</td>
                <td> Mobile Number</td>
                <td> SMS Status</td>

            </tr>
            <%@ include file="getConnection.jsp"%>
            <%
            String sql="select * from sms_config where req_type=? and meter_id=?";
            PreparedStatement pstmt = con.prepareStatement(sql);
            pstmt.setString(1, requestType);
            pstmt.setInt(2, Integer.parseInt(meterId));
            ResultSet rs = pstmt.executeQuery();
            while(rs.next()){
                int smsStatus = 0;
                    boolean smsResult = false;
                    try {
                        smsStatus = Integer.parseInt(rs.getString(10));
                        if (smsStatus == 0) {
                            smsResult = true;
                        }
                    } catch (Exception e) {
                    }
            %>
                <tr>
                    <td> <%=rs.getString(1)%></td>
                <td> <%=rs.getString(2)%></td>
                <td> <%=rs.getString(3)%></td>
                <td> <%=rs.getString(4)%></td>
                <td> <%=rs.getString(5)%></td>
                <td> <%=rs.getString(6)%></td>
                <td> <%=rs.getString(7)%></td>
                <td> <%=rs.getString(8)%></td>
                <td> <%=smsResult%></td>
            </tr>
            <%
            }
            con.close();
            %>
</table>