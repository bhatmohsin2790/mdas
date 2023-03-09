<%@ page session="false" %>
<%@page import="ami.util.DBUtil"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<select name="selfeeder">
<option value="-1">Select Feeder</option>
<%
String feeder_sel = request.getParameter("feeder");
System.out.println("feeder_sel-->"+feeder_sel);
    Connection conn = null;
        ResultSet rs = null;
        Statement stmt = null;
        try {

            conn = DBUtil.getConnection();
                        //conn = datasource.getConnection();
            stmt =  conn.createStatement();
            //rs = stmt.executeQuery("select * from rtu_di_data where rtu_id='"+request.getParameter("rtuid") +"' order by sno desc");
            rs = stmt.executeQuery("select * from digital_input_details where rtu_id='"+request.getParameter("rtuid") +"' order by srlno");
           //rs = stmt.executeQuery("select FEEDER_ID from rtu_ai_data where RTU_ID='"+request.getParameter("rtuid") +"' and FEEDER_ID!=' ' group by FEEDER_ID order by FEEDER_ID");
            int i=0;
            String strt_di ="";
            while (rs.next()) {
                i++;
                //if(i>=24) break;
                //System.out.println("fee-->"+rs.getString("FEEDER_ID"));
                String di_name = rs.getString("Name1");
                di_name = di_name.substring(2);
                if(i==1) strt_di = di_name;
                else
                    {
                        if(strt_di.equals(di_name))
                            break;
                    }
               %>
               <option <%= (feeder_sel.equals(di_name)) ? "selected=selected":"" %> value="<%= di_name %>"><%= rs.getString("DESCRIPTION") %></option>
               <%
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (conn != null) {
                conn.close();
            }
        }
%>
</select>
