<%@ page session="false" %>
<%@page import="in.amitech.db.DBUtil"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%
            Connection con = null;
            Statement st = null;
            String sql = null;
            String sectionName = null;
            try {
            sectionName = request.getParameter("sectionId").trim();
                System.out.println( sectionName);
                if ( sectionName.equals("")) {
                    System.out.println("Section Name Should not be Empty :" +  sectionName);
                } else {
                    con = new DBUtil().getConnection();
                    st = con.createStatement();
                    sql = "delete  from  section where sectionid=" +  sectionName+"";
                    if (st.executeUpdate(sql) > 0) {
                        out.println("section deleted Successfully : "+  sectionName);
                    } else {
                        out.println("section deletion Failed, Try Again :"+ sectionName);
                    }//end else
                }//end else
            } catch (Exception e) {
                if ( sectionName == null) {
                    out.println("section Name Should Not be null");
                } else {
                    out.println(e.getMessage());
                }
            }//end catch
%>