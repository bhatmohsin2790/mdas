<%@ page session="false" %>
<%@page import="in.amitech.db.DBUtil"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%
            Connection con = null;
            Statement st = null;
            String sql = null;
            String htId  = null;

            String meter_serial_no=null;


            try {
              htId = request.getParameter("htId").trim();


             meter_serial_no=request.getParameter("meterId").trim();


                if ( htId.equals("") ||    meter_serial_no.equals(""))
                {
                    System.out.println("ht or meter Should not be Empty");
                }
                          else
                          {
                    con = new DBUtil().getConnection();
                    st = con.createStatement();
                    sql = "update meter set htconsumerid=null where meter_serial_no='"+meter_serial_no+"'";
                    if (st.executeUpdate(sql) > 0) {
                        out.println("ht mapping deleted from selected meter ");
                    } else {
                        out.println("ht meter mapping deletion Failed, Try Again :"+htId);
                    }//end else
                }//end else
            } catch (Exception e) {
                if (  meter_serial_no == null ||   htId == null) {
                    out.println(" htId or meter Should Not be null");
                } else {
                    out.println(e.getMessage());
                }
            }//end catch
            finally
                    {
                con.close();
                }
%>