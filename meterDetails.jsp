<%@page import="java.sql.*" %>
<%@page import="in.amitech.db.DBUtil"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>

<%
            try {
               
                String meterId = request.getParameter("meter_id").trim();                
                Connection con = null;
                String data = "";
                ResultSet rs = null;
                Statement stmt = null;
                con = new DBUtil().getConnection();
               
                String sql = "select * from meter where meterid="+meterId;
                stmt = con.createStatement();
                rs = stmt.executeQuery(sql);
               
                if (rs.next()) {
                    data = data + "," + (rs.getString("metermake") == null ? "" : rs.getString("metermake"));
                    data = data + "," + (rs.getString("meterlocation") == null ? "" : rs.getString("meterlocation"));
                    data = data + "," + (rs.getString("meter_ctr") == null ? "" : rs.getString("meter_ctr"));
                    data = data + "," + (rs.getString("meter_ptr") == null ? "" : rs.getString("meter_ptr"));                  
                    data = data + "," + (rs.getString("adopted_ctr") == null ? "" : rs.getString("adopted_ctr"));
                    data = data + "," + (rs.getString("adopted_ptr") == null ? "" : rs.getString("adopted_ptr"));                 
                    data = data + "," + (rs.getString("accuracy") == null ? "" : rs.getString("accuracy"));
                    data = data + "," + (rs.getString("mf") == null ? "" : rs.getString("mf"));
                    data = data + "," + (rs.getString("meter_type") == null ? "" : rs.getString("meter_type"));
                    data = data + "," + (rs.getString("modem_serial_no") == null ? "" : rs.getString("modem_serial_no"));
                    data = data + "," + (rs.getString("location_code") == null ? "" : rs.getString("location_code"));
                    data = data + "," + (rs.getString("consumerid") == null ? "" : rs.getString("consumerid"));

                }
                out.println(data);
                System.out.println("data is" + data);
            } catch (Exception e) {
                e.printStackTrace();
            }
%>