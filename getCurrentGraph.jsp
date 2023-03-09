<%@ page session="false" %>
<%@page import="in.amitech.db.DBUtil"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.*"%>
<%
    Connection con1 = null;
    try {        
        Statement st = null;
        String sql = null;
        String rph = "";
        String yph = "";
        String bph = "";
        String data = "";
        String time = "";
        String meterId = request.getParameter("meter_id").trim();
        String sdate = request.getParameter("sdate");

        if (DBUtil.getTargetDB().equals("oracle")) {
            sql = "select to_char(to_date(g2,'DD-MM-YYYY HH24:MI:SS'),'HH24:MI:SS'),rph_line_current,yph_line_current,bph_line_current from D2 where meter_serial_no=(select meter_serial_no from meter where meterid='7541') and to_char(to_date(g2,'DD-MM-YYYY HH24:MI:SS'),'DD/MM/YYYY') = '" + sdate + "'order by to_char(to_date(g2,'DD-MM-YYYY HH24:MI:SS'),'HH24:MI:SS')";
        } else if (DBUtil.getTargetDB().equals("mysql")) {
            sql = "select substr(g2,11),rph_line_current,yph_line_current,bph_line_current from d2 where meterid='" + meterId + "' and str_to_date(g2,'%d-%m-%Y') = str_to_date('" + sdate + "','%d/%m/%Y')order by g2";
        }
        con1 = new DBUtil().getConnection();
        st = con1.createStatement();
        ResultSet rs = st.executeQuery(sql);
        while (rs.next()) {
            time = time + rs.getString(1) + ",";
            rph = rph + Math.abs(rs.getDouble("rph_line_current")) + ",";
            yph = yph + Math.abs(rs.getDouble("yph_line_current")) + ",";
            bph = bph + Math.abs(rs.getDouble("bph_line_current")) + ",";
        }
        data = "time" + "," + time + "rph" + "," + rph + "yph" + "," + yph + "bph" + "," + bph;
        data = data.substring(0, data.length() - 1);
        out.println(data);
    } catch (Exception e) {
        e.printStackTrace();
    }
    finally{
        con1.close();
    }
%>




