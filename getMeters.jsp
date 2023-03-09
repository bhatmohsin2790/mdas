<%@ page session="false" %>
<%@ include file="getConnection.jsp"%>
<%!    PreparedStatement pstmt = null;
    ResultSet rs = null;
%>
<%
            try {
               String ssid=request.getParameter("ssid");
               String meteringpoint=request.getParameter("meteringpoint");
               String location=request.getParameter("location");
               String status =request.getParameter("status");
                String data = "";
                String sql="select m.meterid,m.meter_serial_no,s.substationname from meter m,substation s where m.substationid=s.substationid and m.substationid="+ssid+" and TYPE_OF_METERING_POINTS="+meteringpoint+" and METERLOCATION="+location+" and METER_STATUS="+status+" order by m.meter_serial_no desc";
                System.out.println("sql is "+sql);
                        pstmt = con.prepareStatement(sql);
                    
                    rs = pstmt.executeQuery();
                    while (rs.next()) {
                        data = rs.getString("meterid") + "_" + rs.getString("meter_serial_no") + "-" + rs.getString("substationname") + ":" + data;
                    }

                
                out.print(data);
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                con.close();
            }
%>