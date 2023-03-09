<%@ page session="false" %>
<%@page import="in.amitech.db.DBUtil"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%
            Connection con = null;
            Statement st = null;
            String sql = null;
            String sql1=null;
            String dcuId = null;
            String mappedModem=null;
            String newModem=null;
            try {
            dcuId = request.getParameter("dcuId").trim();
            mappedModem=request.getParameter("mappedModem").trim();
            newModem=request.getParameter("newModem").trim();
            //System.out.println("id"+sectionId+"name"+sectionName);

                if ( newModem.equals("")) {
                    System.out.println("modem Name Should not be Empty :" +  newModem);
                } else {
                    con = new DBUtil().getConnection();
                    st = con.createStatement();
                    sql = "update modem set dcu_id=null where modem_serial_no='"+mappedModem+"'";
                    st.executeUpdate(sql);
                    System.out.println("mapping deleted successfully");
                    sql1="update modem set dcu_id="+dcuId+" where modem_serial_no='"+newModem+"'";
                    if (st.executeUpdate(sql1) > 0) {
                        out.println("dcu is now mapped to : "+  newModem);
                    } else {
                        out.println("dcu mapping  Failed, Try Again :"+ newModem);
                    }//end else
                }//end else
            } catch (Exception e) {
                if ( newModem == null) {
                    out.println("dcu Name Should Not be null");
                } else {
                    out.println(e.getMessage());
                }
            }//end catch
%>