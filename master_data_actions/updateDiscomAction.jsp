<%@ page session="false" %>
<%@page import="in.amitech.db.DBUtil"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%
            Connection con = null;
            Statement st = null;
            String sql = null;
            String zId = null;
            String zName=null;
            try {
            zId = request.getParameter("dId").trim();
            zName=request.getParameter("dName").trim();
            //System.out.println("id"+sectionId+"name"+sectionName);

                if ( zName.equals("")) {
                    out.println("zone Name Should not be Empty :" +  zName);
                } else {
                    con = new DBUtil().getConnection();
                    st = con.createStatement();
                    sql = "update discom set discom_name='"+zName+"' where discom_id="+zId+"";
                    if (st.executeUpdate(sql) > 0) {
                        out.println("discom updated Successfully : "+  zName);
                    } else {
                        out.println("discom updation Failed, Try Again :"+ zName);
                    }//end else
                }//end else
            } catch (Exception e) {
                if ( zName == null) {
                    out.println("discom Name Should Not be null");
                } else {
                    out.println(e.getMessage());
                }
            }//end catch
%>