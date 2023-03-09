<%@page import="java.sql.*" %>
<%@page import="in.amitech.db.DBUtil"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>

<%
            String userNumber = request.getParameter("modemid");
            System.out.println("ModemID--->" + userNumber);

            Connection conmt = null;
            conmt = new DBUtil().getConnection();

            try {
                Statement stmt = conmt.createStatement();
                ResultSet resmt = stmt.executeQuery("SELECT * FROM  modem where modem_id='" + userNumber + "' ");
                StringBuffer responseXML = new StringBuffer();
                response.setContentType("text/xml");
                response.setHeader("Cache-Control", "no-cache");
                responseXML.append("<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?>");
                responseXML.append("<MODEM>");
                if (resmt.next()) {
                    String mODEM_ID = resmt.getString("MODEM_ID");
                    String mODEM_SERIAL_NO = resmt.getString("MODEM_SERIAL_NO");
                    String iMEI_NO = resmt.getString("IMEI_NO");
                    String mOBILE_NO = resmt.getString("MOBILE_NO");
                    String iS_DCU = resmt.getString("IS_DCU");
                    String dCU_ID = resmt.getString("DCU_ID");
                    responseXML.append("<MODEM_ID>" + mODEM_ID + "</MODEM_ID>");
                    responseXML.append("<MODEM_SERIAL_NO>" + mODEM_SERIAL_NO + "</MODEM_SERIAL_NO>");
                    responseXML.append("<IMEI_NO>" + iMEI_NO + "</IMEI_NO>");
                    responseXML.append("<MOBILE_NO>" + mOBILE_NO + "</MOBILE_NO>");
                    responseXML.append("<IS_DCU>" + iS_DCU + "</IS_DCU>");
                    responseXML.append("<DCU_ID>" + dCU_ID + "</DCU_ID>");

                }
                responseXML.append("</MODEM>");
                System.out.println("responseXML.toString()------------" + responseXML.toString());
                response.getWriter().write(responseXML.toString());


                //response.setStatus(HttpServletResponse.SC_NO_CONTENT);
            } catch (Exception e) {
                System.err.println("Ajaxrors------------" + e);
            }
%>