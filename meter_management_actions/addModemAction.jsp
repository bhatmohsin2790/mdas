<%@ page session="false" %>
<%@page import="in.amitech.db.DBUtil"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%
            Connection con = null;
            PreparedStatement st = null;
            String sql = null;
            String modem_id = null;
            String modem_serial_no = null;
            String imei_no = null;
            String static_ip=null;
            String mobile_no = null;
            String is_dcu=null;
            String dcu_id = null;
            String fal = "FALSE";

            try {
                
                modem_serial_no = request.getParameter("modem_serial_no").trim();
                imei_no = request.getParameter("imei_no").trim();
                mobile_no = request.getParameter("mobile_no").trim();
                static_ip=request.getParameter("static_ip").trim();
              //  is_dcu = request.getParameter("is_dcu").trim();
    
                if ( modem_serial_no.equals("")) {
                    out.println("modem_sl_no  Should not be Empty");
                } else {
                    con = new DBUtil().getConnection();
                    st = con.prepareStatement("insert into modem(modem_serial_no,mobile_no,imei_no,static_ip,is_dcu) values(?,?,?,?,?)");
                   
                      st.setString(1, modem_serial_no);
                     st.setString(2, mobile_no);                    
                     st.setString(3,imei_no);
                     st.setString(4,static_ip);
                     st.setInt(5,0);
                   
                   
                    if (st.executeUpdate() > 0) {
                        out.println("Modem Added Successfully : " + modem_serial_no);

                    } else {
                        out.println("Modem Added Failed, Try Again :" + modem_serial_no);
                    }//end else
                }//end else
            } catch (Exception e) {
                if ( modem_serial_no == null) {
                    out.println("modem_sl_no Should Not be null");
                } else {
                    out.println(e.getMessage());
                }
            }//end catch
            finally
                    {
                con.close();
                }
%>






