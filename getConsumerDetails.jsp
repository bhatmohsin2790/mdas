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
        String consumerId = request.getParameter("emp_id").toString();
        System.out.println("consumerId ------>" + consumerId);
        String data = null;
        String sql = "";
        if (DBUtil.getTargetDB().equals("oracle")) {
            sql = "select address,mobileno,phoneno,emailid,altemailid,to_char(agrmntfromdate,'dd/mm/yyyy') abc,to_char(agrmnttodate,'dd/mm/yyyy') cdf,concession,conletterno,rebate from ht_consumer where consumerid=" + consumerId + "";
        } else if (DBUtil.getTargetDB().equals("mysql")) {
            sql = "select address,mobileno,phoneno,emailid,altemailid,date_format(agrmntfromdate,'%d/%m/%Y') abc,date_format(agrmnttodate,'%d/%m/%Y') cdf,concession,conletterno,rebate from ht_consumer where consumerid=" + consumerId + "";
        }
        System.out.println("sql is###########>" + sql);
        PreparedStatement pstmt = con.prepareStatement(sql);
        rs = pstmt.executeQuery();
        while (rs.next()) {
            data = rs.getString("address") + "_" + rs.getString("mobileno") + "_" + rs.getString("phoneno") + "_" + rs.getString("emailid") + "_" + rs.getString("altemailid") + "_" + rs.getString("abc") + "_" + rs.getString("cdf") + "_" + rs.getString("concession") + "_" + rs.getString("conletterno") + "_" + rs.getString("rebate");
        }

        // data = data +":abc:def";
        out.println(data);
        System.out.println("data is " + data);
    } catch (Exception e) {
        e.printStackTrace();
    }
    finally
    {
        con.close();
    }
%>