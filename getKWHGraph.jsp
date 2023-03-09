<%@ page session="false" %>
<%@page import="in.amitech.db.DBUtil"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.*"%>




<%
    Connection con1 = null;
    try {
        Statement st = null;
        String sql = null;
        String kwh = "";

        String data = "";
        String time = "";
        String meterId = request.getParameter("meter_id").trim();
        String sdate = request.getParameter("sdate");


        sql = "select to_char(to_date(billing_date,'dd-mm-yyyy hh24:mi:ss'),'hh24:mi:ss'),round(substr(data_string,1,instr(data_string,',')-1)/10) from d3_b3 b3,d3_dates dd where b3.cdfid in (select cdfid from meter_data_time_stamp where meterid=" + meterId + ") and b3.cdfid=dd.cdfid and b3.billing_day=dd.billing_day and to_date(substr(billing_date,1,10),'dd/mm/yyyy')=to_date('" + sdate + "','dd/mm/yyyy') order by to_char(to_date(billing_date,'dd-mm-yyyy hh24:mi:ss'),'hh24:mi:ss') asc";
        System.out.println("query for kwh" + sql);
        con1 = new DBUtil().getConnection();
        st = con1.createStatement();
        ResultSet rs = st.executeQuery(sql);
        while (rs.next()) {
            time = time + rs.getString(1) + ",";
            kwh = kwh + rs.getString(2) + ",";

        }
        data = "time" + "," + time + "kwh" + "," + kwh;
        data = data.substring(0, data.length() - 1);
        System.out.println("output is" + data);
        out.println(data);
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        con1.close();
    }
%>




