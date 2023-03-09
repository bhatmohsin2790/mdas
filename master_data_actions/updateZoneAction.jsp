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
            zId = request.getParameter("zId").trim();
            zName=request.getParameter("zName").trim();
            //System.out.println("id"+sectionId+"name"+sectionName);

                if ( zName.equals("")) {
                    System.out.println("zone Name Should not be Empty :" +  zName);
                } else {
                    con = new DBUtil().getConnection();
                    st = con.createStatement();
                    sql = "update zone set zonename='"+zName+"' where zoneid="+zId+"";
                    if (st.executeUpdate(sql) > 0) {
                        out.println("zone updated Successfully : "+  zName);
                    } else {
                        out.println("zone updation Failed, Try Again :"+ zName);
                    }//end else
                }//end else
            } catch (Exception e) {
                if ( zName == null) {
                    out.println("zone Name Should Not be null");
                } else {
                    out.println(e.getMessage());
                }
            }//end catch
%>