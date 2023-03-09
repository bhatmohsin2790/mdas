<%@ page session="false" %>
<%@page import="in.amitech.db.DBUtil"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%
            Connection con = null;
            Statement st = null;
            String sql = null;
            String sectionId = null;
            String sectionName=null;
            String subdivisionId=null;
            try {
            sectionId = request.getParameter("sId").trim();
            sectionName=request.getParameter("sName").trim();
           subdivisionId=request.getParameter("sdId").trim();
               
                if ( sectionName.equals("")) {
                    System.out.println("Section Name Should not be Empty :" +  sectionName);
                } else {
                    con = new DBUtil().getConnection();
                    st = con.createStatement();
                    sql = "update section set sectionname='"+sectionName+"',subdivid="+subdivisionId+" where sectionid="+sectionId+"";
                    if (st.executeUpdate(sql) > 0) {
                        out.println("section updated Successfully : "+  sectionName);
                    } else {
                        out.println("section updation Failed, Try Again :"+ sectionName);
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