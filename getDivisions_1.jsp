<%@ page session="false" %>
<%@ include file="getConnection.jsp"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="in.amitech.db.DBUtil"%>

<%!
  PreparedStatement pstmt = null;
  ResultSet rs = null;
  String sql="";
%>
<%
    try{
        String districtname = request.getParameter("emp_id").toString();
        //System.out.println("circlename---->"+circlename);
        String data ="0_Select Division";
        //-----------------------------------
            HttpSession sess = request.getSession(false);
            String office_type = sess.getAttribute("office_type").toString();
            String office_type_id = sess.getAttribute("office_type_id").toString();
			System.out.println(office_type+"\t"+office_type_id+"\t"+districtname);
//-----------------------------------        
         if (office_type.equals("SDO")) {
                 sql = "select * from division where divisionid in(select divisionid from subdivision where subdivid=" + office_type_id + ")";
             }
          else if (office_type.equals("DO")) {
                 sql = "select * from division where divisionid=" + office_type_id + "";
             } else {
                 sql = "select * from division where townid=" + districtname + "";
             }
        PreparedStatement pstmt = con.prepareStatement(sql);
        //PreparedStatement pstmt = con.prepareStatement("select * from division where townid="+districtname+"");
        rs = pstmt.executeQuery();
        while(rs.next())
            data = data +":"+rs.getString("divisionid")+"_"+rs.getString("divisionname");

       // data = data +":abc:def";
        out.println(data);
        System.out.println("data is "+data);
    }catch(Exception e)
    {
        e.printStackTrace();
    }
    finally{
        con.close();
    }
%>