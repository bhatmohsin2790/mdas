<%@ page session="false" %>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="in.amitech.db.DBUtil"%>
<script type="text/javascript">
    function delZone()
    {
        alert("this is ");
        zoneId=document.getElementById("zone");
        alert(zoneId);
    }
</script>
<form name="dzone" title="Deleting Zones" >
    <table align="center" bgcolor="#E0ECF8" cellpadding="5" cellspacing="5">
        <tr><th colspan="2"><h2>Delete Zone</h2></th></tr>
        <tr>
            <td align="left">Select Zone : </td>
            <td>
                <select name="zone" id="zoneId" style="width:150px;height:20px;font-size:12px;font-family:verdana;">

                    <option value="-1">Select zone</option>
                    <%
                                Connection con = new DBUtil().getConnection();
                                PreparedStatement pstmt = null;
                                ResultSet rs = null;
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
            <td></td>
            <td><input type="button" value="delete" onclick="delZone()"/></td>
        </tr>


    </table>
</form>