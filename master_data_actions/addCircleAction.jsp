<%@page import="in.amitech.db.DBUtil"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page session="false" %>
<%
            Connection con = null;
            Statement st = null;
            String sql = null;
            String zoneId = null;
            String circleName=null;
            try {
                zoneId = request.getParameter("zoneId").trim();
                circleName=request.getParameter("circleName").trim();
                if (zoneId.equals("") || circleName.equals("")) {
                    System.out.println("Zone Id or Circle Should not be Empty");
                } else {
                    con = new DBUtil().getConnection();
                    st = con.createStatement();
                    sql = "insert into circle(circlename,zoneid) values('" + circleName + "',"+zoneId+")";
                    if (st.executeUpdate(sql) > 0) {
                        out.println("Circle Added Successfully : "+circleName);
                    } else {
                        out.println("Circle Added Failed, Try Again :"+circleName);
                    }//end else
                }//end else
            } catch (Exception e) {
                if (zoneId == null || circleName == null) {
                    out.println("Zone Id or Circle Name Should Not be null");
                } else {
                    out.println(e.getMessage());
                }
            }//end catch
%>