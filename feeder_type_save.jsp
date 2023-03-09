
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ include file="getConnection.jsp"%>
<%
try
{
    String[] feeder_id = request.getParameterValues("feeder_id");
    String[] feeder_type = request.getParameterValues("feeder_type");
    String[] DI_name=request.getParameterValues("DI_name");
    String[] incoming_feeder=request.getParameterValues("incoming_feeder");
    String substation_id = request.getParameter("dcu_id1");

    PreparedStatement pstmt,ps = null;
    ResultSet rs = null;
    System.out.println("DCU ID :"+substation_id);
    for(int i=0;i<feeder_id.length;i++)
    {
        pstmt = con.prepareStatement("update feeder set feeder_type=?,incoming_feeder=? where substationid=? and feederid=?");
        pstmt.setString(1, feeder_type[i]);
        pstmt.setString(2, incoming_feeder[i]);
        pstmt.setString(3, substation_id);
        pstmt.setString(4, feeder_id[i]);
        pstmt.executeUpdate();
        
        ps=con.prepareStatement("update digital_input_details set feeder_id=? where name1=? and rtu_id=?");
        ps.setString(1,feeder_id[i]);
        ps.setString(2,"DI"+DI_name[i]);
        ps.setString(3,substation_id);
        ps.executeUpdate();
    }
    System.out.println("updated successfully");
    con.close();
}
catch(Exception e)
{
    e.printStackTrace();
}
%>
<script>
    alert("updated successfully");
</script>

<jsp:forward page="electricMeters.jsp?res=Updated Successfully" />