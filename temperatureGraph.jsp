<%@ page session="false" %>
<%@page import="in.amitech.db.DBUtil"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.*"%>

<%
    try {
        Connection con1 = null;
        Statement st = null;
        ResultSet rs = null;
        PreparedStatement ps = null;
        String sql = null;
        String time = "";
        String temp = "";

        String data = "";
        String meterId = request.getParameter("meter_id").trim();
        String sdate = request.getParameter("sdate");
        con1 = new DBUtil().getConnection();
        //getting the latest date in modem diagnosis table when user didn't select date
        if (sdate.equals("")) {
            if (DBUtil.getTargetDB().equals("mysql")) {
                sql = "select date_format(modem_date_time,'%d/%m/%Y') from modem_diagnosis  where meter_id='" + meterId + "' order by modem_date_time desc limit 1";
                ps = con1.prepareStatement(sql);
                rs = ps.executeQuery();
                if (rs.next()) {
                    sdate = rs.getString(1);
                }
            } else {
            }

        }


        if (DBUtil.getTargetDB().equals("oracle")) {
            sql = "select modem_date_time,modem_temprature from modem_diagnosis where meter_id='" + meterId + "' and to_char(modem_date_time,'dd/mm/yyyy')='" + sdate + "' order by to_char(modem_date_time,'HH24') asc";
        } else if (DBUtil.getTargetDB().equals("mysql")) {
            sql = "select modem_date_time,modem_temprature from modem_diagnosis where meter_id='" + meterId + "' and date_format(modem_date_time,'%d/%m/%Y')='" + sdate + "' order by date_format(modem_date_time,'%H') asc";
        }

        st = con1.createStatement();
        rs = st.executeQuery(sql);
        while (rs.next()) {
            time = time + rs.getTime("modem_date_time") + ",";
            temp = temp + rs.getString("modem_temprature") + ",";

        }
        data = "date"+sdate+"time" + "," + time + "temp" + "," + temp;
        data = data.substring(0, data.length() - 1);
        out.println(data);
    } catch (Exception e) {
        e.printStackTrace();
    }

%>




