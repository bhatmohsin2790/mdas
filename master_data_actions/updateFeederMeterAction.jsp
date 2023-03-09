<%@ page session="false" %>
<%@page import="in.amitech.db.DBUtil"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%
            Connection con = null;
            Statement st = null;
            String sql,sql1 = null;
            String feederId  = null;
             String oldMeter=null;
            String meterId=null;


            try {
               feederId = request.getParameter("feederId").trim();

                     oldMeter=request.getParameter("oldmeter").trim();
             meterId=request.getParameter("meterId").trim();


                if ( feederId.equals("") ||    meterId.equals(""))
                {
                    System.out.println("feeder or meter Should not be Empty");
                }
                          else
                          {
                    con = new DBUtil().getConnection();
                    st = con.createStatement();
                    sql= "update meter set feederid=null where meter_serial_no='"+oldMeter+"'";
                    st.executeUpdate(sql);
                    sql1 = "update meter set feederid="+feederId+" where meterid="+meterId;
                    if (st.executeUpdate(sql1) > 0) {
                        out.println("feeder updated  to meter : "+ meterId);
                    } else {
                        out.println("feeder mapping updation  Failed, Try Again :"+meterId);
                    }//end else
                }//end else
            } catch (Exception e) {
                if (  meterId == null ||    feederId == null) {
                    out.println(" feederId or meter Should Not be null");
                } else {
                    out.println(e.getMessage());
                }
            }//end catch
            finally
                    {
                con.close();
                }
%>