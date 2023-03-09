<%@ page session="false" %>
<%@page import="in.amitech.db.DBUtil"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%
            Connection con = null;
            Statement st = null;
            String sql = null;
            String sdId = null;
            String sdName=null;
            String newDid=null;
            try {
            sdId = request.getParameter("sdId").trim();
            sdName=request.getParameter("sdName").trim();
            newDid=request.getParameter("dId").trim();
            //System.out.println("id"+sectionId+"name"+sectionName);

                if ( sdName.equals("")) {
                    System.out.println("Subdivision Name Should not be Empty :" +  sdName);
                } else {
                    con = new DBUtil().getConnection();
                    st = con.createStatement();
                    sql = "update subdivision set subdivname='"+sdName+"',divisionid="+newDid+" where subdivid="+sdId+"";
                    if (st.executeUpdate(sql) > 0) {
                        out.println("subdivision updated Successfully : "+  sdName);
                    } else {
                        out.println("subdivision updation Failed, Try Again :"+ sdName);
                    }//end else
                }//end else
            } catch (Exception e) {
                if ( sdName == null) {
                    out.println("subdivision Name Should Not be null");
                } else {
                    out.println(e.getMessage());
                }
            }//end catch
%>