<%@ page session="false" %>
<%@page import="in.amitech.db.DBUtil"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%
            Connection con = null;
            Statement st = null;
            String sql = null;
            String modemName = null;
            try {
          modemName = request.getParameter("modemSlNo").trim();
                System.out.println(modemName);
                if (modemName.equals("")) {
                    System.out.println("modem Name Should not be Empty :" + modemName);
                } else {
                    con = new DBUtil().getConnection();
                    st = con.createStatement();
                    sql = "update modem set dcu_id=null where modem_serial_no='"+modemName+"'";
                    if (st.executeUpdate(sql) > 0) {
                        out.println("modem mapping deleted Successfully : "+ modemName);
                    } else {
                        out.println("modem mapping deletion Failed, Try Again :"+modemName);
                    }//end else
                }//end else
            } catch (Exception e) {
                if (modemName == null) {
                    out.println("modem Name Should Not be null");
                } else {
                    out.println(e.getMessage());
                }
            }//end catch
            finally
                    {con.close();}
%>