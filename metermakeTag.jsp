<%@page import="java.sql.*" %>
<%@page import="in.amitech.db.DBUtil"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>

<%
            String userNumber = request.getParameter("metermakeid");
            System.out.println("Metermake no.--->" + userNumber);
            String result="";
            Connection conumm1 = null;
            conumm1 = new DBUtil().getConnection();

            try {
                Statement stumm1 = conumm1.createStatement();
                ResultSet resumm1 = stumm1.executeQuery("SELECT * FROM  metermake where metermakeid=" + userNumber + " ");
               
                if (resumm1.next()) {
                    result=result+","+resumm1.getString("metermakename")+","+resumm1.getString("meter_series")+","+resumm1.getString("meter_version");
                     }
              System.out.println("result data is -->"+result);
              out.println(result);
            } catch (Exception e) {
                e.printStackTrace();
            }
%>