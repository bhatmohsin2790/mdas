<%@ page session="false" %>
<%@page import="in.amitech.db.DBUtil"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%
            Connection con = null;
            Statement st = null;
            String sql = null;
            String feederId  = null;

            String meterId=null;


            try {
             feederId = request.getParameter("feederId").trim();


             meterId=request.getParameter("meterId").trim();


                if ( feederId.equals("") ||    meterId.equals(""))
                {
                    System.out.println("feeder or meter Should not be Empty");
                }
                          else
                          {
                    con = new DBUtil().getConnection();
                    st = con.createStatement();
                    sql = "update meter set feederid=null where meter_serial_no='"+meterId+"'";
                    if (st.executeUpdate(sql) > 0) {
                        out.println("feeder mapping deleted from meter : "+ meterId);
                    } else {
                        out.println("feeder mapping deletion  Failed, Try Again :"+meterId);
                    }//end else
                }//end else
            } catch (Exception e) {
                if (  meterId == null ||    feederId == null) {
                    out.println(" dtrId or meter Should Not be null");
                } else {
                    out.println(e.getMessage());
                }
            }//end catch
            finally
                    {
                con.close();
                }
%>