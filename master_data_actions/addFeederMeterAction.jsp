<%@ page session="false" %>
<%@page import="in.amitech.db.DBUtil"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%
            Connection con = null;
            Statement st = null;
            String sql = null;
            String feederid  = null;

            String meterId=null;


            try {
               feederid = request.getParameter("feederId").trim();
             meterId=request.getParameter("meterId").trim();
                if ( feederid.equals("") ||    meterId.equals(""))
                {
                    System.out.println("feeder or meter Should not be Empty");
                }
                          else
                          {
                    con = new DBUtil().getConnection();
                    st = con.createStatement();
                    sql = "update meter set feederid="+feederid+ " where meterid="+meterId;
                    if (st.executeUpdate(sql) > 0) {
                        out.println("substation mapped to : "+ meterId);
                    } else {
                        out.println(" meter mapping  Failed, Try Again :"+feederid);
                    }//end else
                }//end else
            } catch (Exception e) {
                if (  meterId == null ||    feederid == null) {
                    out.println("  meter Should Not be null");
                } else {
                    out.println(e.getMessage());
                }
            }//end catch
           
%>