<%@page import="in.amitech.db.DBUtil"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.*"%>
<%@ page session="false" %>
<%
            Connection con = null;
          Statement pst = null;
            String sql = null;
            String dcuId = null;
            String modemId=null;
            

            try {
               dcuId = request.getParameter("dcuId").trim();

               
           modemId=request.getParameter("modemId").trim();

                if (   dcuId.equals("") ||  modemId.equals(""))
                {
                    System.out.println("dcu Id or modemId Should not be Empty");
                }
                          else
                          {
                    con = new DBUtil().getConnection();
                    pst = con.createStatement();
                    sql = "update modem set dcu_id="+dcuId+" where modem_id="+modemId+"";
                    if (pst.executeUpdate(sql) > 0) {
                        out.println("modemId mapped Successfully : "+  modemId);
                    } else {
                        out.println("modemId mapped Failed, Try Again :"+modemId);
                    }//end else
                }//end else
            } catch (Exception e) {
                if (   dcuId == null ||     modemId == null ) {
                    out.println(" dcuId or modemId Should Not be null");
                } else {
                    out.println(e.getMessage());
                }
            }//end catch
%>