<%@ page session="false" %>
<%@page import="in.amitech.db.DBUtil"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%
            Connection con = null;
            Statement st = null;
            String sql,sql1 = null;
            String htId  = null;
             String oldMeter=null;
            String meterId=null;


            try {
               htId = request.getParameter("htId").trim();

                     oldMeter=request.getParameter("oldmeter").trim();
             meterId=request.getParameter("newmeter").trim();


                if ( htId.equals("") ||    meterId.equals(""))
                {
                    System.out.println("dtr or meter Should not be Empty");
                }
                          else
                          {
                    con = new DBUtil().getConnection();
                    st = con.createStatement();
                    sql= "update meter set htconsumerid=null where meter_serial_no='"+oldMeter+"'";
                    st.executeUpdate(sql);
                    sql1 = "update meter set htconsumerid="+htId+" where meterid="+meterId;
                    if (st.executeUpdate(sql1) > 0) {
                        out.println("ht updated  to meter ");
                    } else {
                        out.println("ht to meter mapping updation  Failed, Try Again :"+meterId);
                    }//end else
                }//end else
            } catch (Exception e) {
                if (  meterId == null ||    htId == null) {
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