<%@ page session="false" %>
<%@page import="in.amitech.db.DBUtil"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%
            Connection con = null;
            PreparedStatement st = null;
            String modem_id = null;
            String modem_serial_no = null;
            String imei_no = null;
            String mobile_no = null;
            String static_ip=null;
            String is_dcu = null;
            String dcu_id = null;
            modem_id = request.getParameter("modem_id").trim();
            modem_serial_no = request.getParameter("modemSerialNo").trim();
            imei_no = request.getParameter("imei_no").trim();
            static_ip=request.getParameter("static_ip");
            mobile_no = request.getParameter("mobileNo").trim();
          //  is_dcu = request.getParameter("is_dcu").trim();
           // dcu_id = request.getParameter("dcu_id").trim();
            con = new DBUtil().getConnection();
            String query = "  update modem set modem_serial_no='" + modem_serial_no + "',mobile_no='" + mobile_no + "',imei_no='"+imei_no+"',static_ip='"+static_ip+"' where modem_id=" + modem_id + "  ";
            st = con.prepareStatement(query);
            if (st.executeUpdate() > 0) {
                out.println("Modem Updated Successfully ");
            } else {
                out.println("Modem failed to Update, Try again ");
            }//end else

%>