<%@ page session="false" %>
<%@page import="in.amitech.db.DBUtil"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%
            Connection con = null;
            Statement st = null;
            String sql = null;
            String cId = null;
            String cName=null;
            String zId=null;
            try {
            cId = request.getParameter("cId").trim();
            cName=request.getParameter("cName").trim();
            zId=request.getParameter("zId").trim();
            //System.out.println("id"+sectionId+"name"+sectionName);

                if ( cName.equals("")) {
                    System.out.println("circle Name Should not be Empty :" +  cName);
                } else {
                    con = new DBUtil().getConnection();
                    st = con.createStatement();
                    sql = "update circle set circlename='"+cName+"', zoneid="+zId+" where circleid="+cId+"";
                    if (st.executeUpdate(sql) > 0) {
                        out.println("circle updated Successfully : "+  cName);
                    } else {
                        out.println("circle updation Failed, Try Again :"+ cName);
                    }//end else
                }//end else
            } catch (Exception e) {
                if ( cName == null) {
                    out.println("circle Name Should Not be null");
                } else {
                    out.println(e.getMessage());
                }
            }//end catch
%>