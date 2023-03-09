<%@ page session="false" %>
<%@ include file="getConnection.jsp"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="in.amitech.db.DBUtil"%>

<%!    PreparedStatement pstmt = null;
    ResultSet rs = null;
%>
<%
    try {
        //-----------------------------
        HttpSession sess = request.getSession(false);
        String office_type = sess.getAttribute("office_type").toString();
        String office_type_id = sess.getAttribute("office_type_id").toString();
        //-----------------------------
        String zonename = request.getParameter("emp_id").toString();
        System.out.println("Circle ID---->" + zonename);
        String data = "0_Select Circle", sql = "";
        if (office_type.equals("SDO")) {
            sql = "select * from circle where circleid in(select circleid from town where townid in(select townid from division where divisionid in(select divisionid from subdivision where subdivid=" + office_type_id + ")))";
        } else if (office_type.equals("DO")) {
            sql = "select * from circle where circleid in(select circleid from town where townid in(select townid from division where divisionid=" + office_type_id + "))";
        } else {
            sql = "select * from circle where zoneid =" + zonename;
        }

        PreparedStatement pstmt = con.prepareStatement(sql);
        rs = pstmt.executeQuery();
        while (rs.next()) {
            data = data + ":" + rs.getString("circleid") + "_" + rs.getString("circlename");
        }//end while
        // data = data +":abc:def";
        out.println(data);
        System.out.println("data is " + data);
    } catch (Exception e) {
        e.printStackTrace();
    }
    finally{
        con.close();
    }
%>