<%@page import="java.text.SimpleDateFormat"%>
<%@page import="in.amitech.db.DBUtil"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.*"%>
<%
    try {
        Connection con1 = null;
        Statement st = null;
        ResultSet rs = null;
        PreparedStatement pstmt = null;
        String sql = null;
        String sdate = null;
        String time = "";
        String signal = "";
		 SimpleDateFormat sdf=new SimpleDateFormat("dd/MM/yyyy");
  SimpleDateFormat sdf1=new SimpleDateFormat("dd-MMM-yy");


        String data = "";
        String meterId = request.getParameter("meter_id").trim();
        sdate = request.getParameter("sdate");
		sdate=sdf1.format(sdf.parse(sdate));

        String substationName = "";
        String meterLocation = request.getParameter("location").trim();
        String substationId = request.getParameter("substationId").trim();
        con1 = new DBUtil().getConnection();
        if (!meterLocation.equals("feeder")) {
        //getting the latest date in modem diagnosis table when user didn't select date
        if (sdate.equals("")) {
            if (DBUtil.getTargetDB().equals("mysql")) {
                sql = "select date_format(modem_date_time,'%d/%m/%Y') from modemdiagnosis  where meter_id='" + meterId + "' order by modem_date_time desc limit 1";
                pstmt = con1.prepareStatement(sql);
                rs = pstmt.executeQuery();
                if (rs.next()) {
                    sdate = rs.getString(1);
                }
            } else {
            }

        }

        if (DBUtil.getTargetDB().equals("oracle")) {
            sql = "select modem_date_time,network_strength from modemdiagnosis where meter_id='" + meterId + "' and modem_date_time like '" + sdate + "%' order by modem_date_time asc";
        } else if (DBUtil.getTargetDB().equals("mysql")) {
            sql = "select modem_date_time,network_strength from modem_diagnosis where meter_id='" + meterId + "' and date_format(modem_date_time,'%d/%m/%Y')='" + sdate + "' order by date_format(modem_date_time,'%H') asc";
        }
        System.out.println(sql);

        st = con1.createStatement();
        rs = st.executeQuery(sql);
        while (rs.next()) {
			String datetime=rs.getString("modem_date_time");
               datetime=datetime.split(" ")[1];
               datetime=datetime.substring(0,datetime.length()-2);
            time = time + datetime + ",";
            signal = signal + rs.getString("network_strength") + ",";


        }
        data = "date"+sdate+"time" + "," + time + "signal" + "," + signal;
        data = data.substring(0, data.length() - 1);
        out.println(data);
               }// for dtr and ht
        else
                       {
            st = con1.createStatement();
        sql = "select substationname from substation where substationid=" + substationId;
        rs = st.executeQuery(sql);
        if (rs.next()) {
            substationName = rs.getString(1);
        }
        rs.close();
        st.close();
        System.out.println("substationname is----->" + substationName);
            
             //getting the latest date in modem diagnosis table when user didn't select date
        if (sdate.equals("")) {
            if (DBUtil.getTargetDB().equals("mysql")) {
                
                sql = "select date_format(modem_date_time,'%d/%m/%Y') from modem_diagnosis  where meter_id='" + meterId + "' order by modem_date_time desc limit 1";
                pstmt = con1.prepareStatement(sql);
                rs = pstmt.executeQuery();
                if (rs.next()) {
                    sdate = rs.getString(1);
                }
            } else {
            }

        }

        if (DBUtil.getTargetDB().equals("oracle")) {
            sql = "select to_char(modem_date_time,'hh24:mi:ss'),network_strength from modem_diagnosis where meter_id='" + substationName + "' and to_char(modem_date_time,'dd/mm/yyyy')='" + sdate + "' order by modem_date_time asc";
        } else if (DBUtil.getTargetDB().equals("mysql")) {
            if(meterId.equals("All") && Integer.parseInt(substationId)!=0)
                sql="select modem_date_time,network_strength from modem_diagnosis where meter_id like '" + substationName + "%' and date_format(modem_date_time,'%d/%m/%Y')='" + sdate + "' order by date_format(modem_date_time,'%H') asc";
            if(meterId.equals("All") && Integer.parseInt(substationId)==0)
                sql = "select modem_date_time,network_strength from modem_diagnosis where modem_temprature is null and date_format(modem_date_time,'%d/%m/%Y')='" + sdate + "' order by date_format(modem_date_time,'%H') asc";
            if(! meterId.equals("All"))
             sql = "select modem_date_time,network_strength from modem_diagnosis where meter_id='" + meterId + "' and date_format(modem_date_time,'%d/%m/%Y')='" + sdate + "' order by date_format(modem_date_time,'%H') asc";
        }
        System.out.println(sql);

        st = con1.createStatement();
        rs = st.executeQuery(sql);
        while (rs.next()) {
            time = time + rs.getString(1) + ",";
            signal = signal + rs.getString("network_strength") + ",";


        }
        data = "date"+sdate+"time" + "," + time + "signal" + "," + signal;
        data = data.substring(0, data.length() - 1);
        out.println(data);
            
        }
    } catch (Exception e) {
        e.printStackTrace();
    }

%>




