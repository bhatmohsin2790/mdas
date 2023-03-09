<%@ page session="false" %>
<%@page import="in.amitech.db.DBUtil"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%
            Connection con = null;
            Statement st = null;
            String sql = null;
            String dtrName = null;
            try {
              dtrName = request.getParameter("dtrId").trim();
                System.out.println(dtrName);
                if (dtrName.equals("")) {
                    System.out.println("DTR Name Should not be Empty :" + dtrName);
                } else {
                    con = new DBUtil().getConnection();
                    st = con.createStatement();
                    sql = "delete  from  dtr where dtrid=" +  dtrName+"";
                    if (st.executeUpdate(sql) > 0) {
                        out.println("DTR deleted Successfully : "+ dtrName);
                    } else {
                        out.println("DTR deletion Failed, Try Again :"+ dtrName);
                    }//end else
                }//end else
            } catch (Exception e) {
                if ( dtrName == null) {
                    out.println("DTR Name Should Not be null");
                } else {
                    out.println(e.getMessage());
                }
            }//end catch
%>