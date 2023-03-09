<%@ page session="false" %>
<%@page import="in.amitech.db.DBUtil"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%
            Connection con = null;
            Statement st = null;
            String sql = null;
            String htName = null;
            try {
               htName = request.getParameter("htId").trim();
                System.out.println(htName);
                if (htName.equals("")) {
                    System.out.println("Consumer Name Should not be Empty :" + htName);
                } else {
                    con = new DBUtil().getConnection();
                    st = con.createStatement();
                    sql = "delete  from  ht_consumer where consumerid=" +  htName+"";
                    if (st.executeUpdate(sql) > 0) {
                        out.println("HT deleted Successfully : "+ htName);
                    } else {
                        out.println("HT deletion Failed, Try Again :"+ htName);
                    }//end else
                }//end else
            } catch (Exception e) {
                if ( htName == null) {
                    out.println("Consumer Name Should Not be null");
                } else {
                    out.println(e.getMessage());
                }
            }//end catch
%>