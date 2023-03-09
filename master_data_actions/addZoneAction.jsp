<%@ page session="false" %>
<%@page import="in.amitech.db.DBUtil"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%
            Connection con = null;
            Statement st = null;
            String sql = null;
            String zoneName = null,discomid=null;
            try {
                zoneName = request.getParameter("zoneName").trim();
                discomid=request.getParameter("discom").trim();
                if (zoneName.equals("")) {
                    System.out.println("Zone Name Should not be Empty :" + zoneName);
                } else {
                    con = new DBUtil().getConnection();
                    st = con.createStatement();
                    sql = "insert into zone(zonename,discom_id) values('" + zoneName + "','"+discomid+"')";
                    if (st.executeUpdate(sql) > 0) {
                        out.println("Zone Added Successfully : "+zoneName);
                    } else {
                        out.println("Zone Added Failed, Try Again :"+zoneName);
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