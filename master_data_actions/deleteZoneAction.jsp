<%@ page session="false" %>
<%@page import="in.amitech.db.DBUtil"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%
            Connection con = null;
            Statement st = null;
            String sql = null;
            String zoneName = null;
            try {
                zoneName = request.getParameter("zoneId").trim();
                System.out.println(zoneName);
                if (zoneName.equals("")) {
                    System.out.println("Zone Name Should not be Empty :" + zoneName);
                } else {
                    con = new DBUtil().getConnection();
                    st = con.createStatement();
                    sql = "delete  from  zone where zoneid=" + zoneName+"";
                    if (st.executeUpdate(sql) > 0) {
                        out.println("Zone deleted Successfully : "+zoneName);
                    } else {
                        out.println("Zone deletion Failed, Try Again :"+zoneName);
                    }//end else
                }//end else
            } catch (Exception e) {
                if (zoneName == null) {
                    out.println("Zone Name Should Not be null");
                } else {
                    out.println(e.getMessage());
                }
            }//end catch
%>