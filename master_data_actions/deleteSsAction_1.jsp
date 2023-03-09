<%@ page session="false" %>
<%@page import="in.amitech.db.DBUtil"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%
            Connection con = null;
            Statement st = null;
            String sql = null;
            String ssName = null;
            try {
            ssName = request.getParameter("ssId").trim();
                System.out.println(ssName);
                if (ssName.equals("")) {
                    System.out.println("Substation Name Should not be Empty :" + ssName);
                } else {
                    con = new DBUtil().getConnection();
                    st = con.createStatement();
                    sql = "delete  from  substation where substationid=" +  ssName+"";
                    if (st.executeUpdate(sql) > 0) {
                        out.println("ss deleted Successfully : "+ ssName);
                    } else {
                        out.println("ss deletion Failed, Try Again :"+ ssName);
                    }//end else
                }//end else
            } catch (Exception e) {
                if ( ssName == null) {
                    out.println("ss Name Should Not be null");
                } else {
                    out.println(e.getMessage());
                }
            }//end catch
%>