<%@page import="java.util.concurrent.TimeUnit"%>
<%@page import="java.util.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="in.amitech.db.DBUtil"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.*"%>
<style>
    #modem_alerts h3
    {background-color:#EEEEEE;
     border:1px solid #EEEEEE;
     color:#666666;
     width:auto;
     font-size:12px;
     padding:5px 15px;
     text-decoration:none;}

</style>

<%
    Connection con1 = null;
    Statement st = null;
    int flag = 0;
    String sql = null;
    String sql1 = null;
    ResultSet rs = null;
    ResultSet rs1 = null;
    String[] values;
    String substationName = "";
    String meterLocation = request.getParameter("location").trim();
    String substationId = request.getParameter("substationId").trim();
    String meterId = request.getParameter("meterId").trim();
    String fromDate = request.getParameter("date").trim();
    String endDate = request.getParameter("endDate").trim();
    String chkvalue = request.getParameter("values");
    System.out.println("chk value is" + chkvalue);
    int start = Integer.parseInt(request.getParameter("start"));
    System.out.println("start value is" + start);
    int limit = 0;
    int count = 0;
    if (!meterLocation.equals("feeder")) {
        limit = 20;
        System.out.println("meterid is" + meterId);
        if(con1 != null)
        {
            con1.close();
        }
        con1 = new DBUtil().getConnection();
        st = con1.createStatement();
        sql = "select meter_serial_no,modem_serial_no from meter where meter_serial_no='" + meterId + "'";
        System.out.println("sql is" + sql);
        rs1 = st.executeQuery(sql);

%>
<table border="1" class='mtable' id="modem_alerts" cellpadding="2" cellspacing="2" >
    <tbody>
        <%
            if (rs1.next()) {

        %>
        <tr><td colspan="3">&nbsp;&nbsp;&nbsp;Meter_sl_No:&nbsp;<%=meterId%>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                Modem_sl_No:&nbsp;<%=rs1.getString("modem_serial_no")%></td>
        </tr>
        <% }%>
        <tr>
            <td ><h3>ALERT DESC</h3></td>
            <td><h3>ALERT GENERATED DATE</h3></td>
        </tr>

        <%
            try {
                //-------------code to get count --------------------


                if (DBUtil.getTargetDB().equals("oracle")) {
                    if (!fromDate.equals("") && !endDate.equals("")) {
                        //getting the next date of end date
                        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
                        java.util.Date oldDate = sdf.parse(endDate);
                        java.util.Date newDate = new java.util.Date(oldDate.getTime() + 24 * 3600000);
                        String latestDate = sdf.format(newDate);
                        sql1 = "select count(*) from modem_alerts where meter_id='" + meterId + "' and alert_generated_date >= to_date('" + fromDate + "','dd/mm/yyyy') and alert_generated_date < = to_date('" + latestDate + "','dd/mm/yyyy') and ";
                    } else {
                        sql1 = "select count(*) from modem_alerts where meter_id='" + meterId + "' and ";
                    }
                } else if (DBUtil.getTargetDB().equals("mysql")) {
                    if (!fromDate.equals("") && !endDate.equals("")) {
                        //getting the next date of end date
                        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
                        java.util.Date oldDate = sdf.parse(endDate);
                        java.util.Date newDate = new java.util.Date(oldDate.getTime() + 24 * 3600000);
                        String latestDate = sdf.format(newDate);
                        //System.out.println("Latest date---->"+latestDate);
                        sql1 = "select count(*) from modem_alerts where meter_id='" + meterId + "' and alert_generated_date >= str_to_date('" + fromDate + "','%d/%m/%Y') and alert_generated_date <= str_to_date('" + latestDate + "','%d/%m/%Y') and ";

                    } else {
                        sql1 = "select count(*) from modem_alerts where meter_id='" + meterId + "' and ";
                    }
                }
                sql1 = sql1 + "substr(alert_desc ,1,3) in (";

                if (chkvalue.contains("0")) //for Meter com failed.
                {
                    sql1 = sql1 + "'Met'";
                } else {
                    sql1 = sql1 + "''";
                }
                if (chkvalue.contains("1")) // for AMR power failed.
                {
                    sql1 = sql1 + ",'AMR'";
                } else {
                    sql1 = sql1 + ",''";
                }
                if (chkvalue.contains("2")) // for DTR power failed.
                {
                    sql1 = sql1 + ",'DTR'";
                } else {
                    sql1 = sql1 + ",''";
                }
                if (chkvalue.contains("3")) // for CRC failed.
                {
                    sql1 = sql1 + ",'CRC'";
                } else {
                    sql1 = sql1 + ",''";
                }

                sql1 = sql1 + ") order by alert_generated_date desc";
                PreparedStatement psc = con1.prepareStatement(sql1);
                ResultSet rsc = psc.executeQuery();
                if (rsc.next()) {
                    count = Integer.parseInt(rsc.getString(1));
                }
                System.out.println("count -->" + sql1);
                System.out.println("tot records---->" + count);

                // ------------end of code to get count ------------

                if (DBUtil.getTargetDB().equals("oracle")) {
                    if (!fromDate.equals("") && !endDate.equals("")) {
                        //getting the next date of end date
                        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
                        java.util.Date oldDate = sdf.parse(endDate);
                        java.util.Date newDate = new java.util.Date(oldDate.getTime() + 24 * 3600000);
                        String latestDate = sdf.format(newDate);
                        sql1 = "select alert_desc,aldate,meter_id from("
                                + "select alert_desc,aldate,meter_id,rownum r from("
                                + "select alert_desc,to_char(ALERT_GENERATED_DATE,'dd/mm/yyyy hh24:mi:ss') aldate,meter_id from modem_alerts  where meter_id='" + meterId + "' and alert_generated_date >= to_date('" + fromDate + "','dd/mm/yyyy') and alert_generated_date < = to_date('" + latestDate + "','dd/mm/yyyy') and";
                    } else {
                        sql1 = "select alert_desc,aldate,meter_id from("
                                + "select alert_desc,aldate,meter_id,rownum r from("
                                + "select alert_desc,to_char(ALERT_GENERATED_DATE,'dd/mm/yyyy hh24:mi:ss') aldate,meter_id from modem_alerts  where  meter_id='" + meterId + "' and ";
                    }
                } else if (DBUtil.getTargetDB().equals("mysql")) {
                    if (!fromDate.equals("") && !endDate.equals("")) {
                        //getting the next date of end date
                        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
                        java.util.Date oldDate = sdf.parse(endDate);
                        java.util.Date newDate = new java.util.Date(oldDate.getTime() + 24 * 3600000);
                        String latestDate = sdf.format(newDate);
                        //System.out.println("Latest date---->"+latestDate);

                        sql1 = "select alert_desc,DATE_FORMAT(alert_generated_date,'%d/%m/%Y %H:%i:%S') from modem_alerts where meter_id='" + meterId + "' and alert_generated_date >= str_to_date('" + fromDate + "','%d/%m/%Y') and alert_generated_date <= str_to_date('" + latestDate + "','%d/%m/%Y') and ";

                    } else {

                        sql1 = "select alert_desc,DATE_FORMAT(alert_generated_date,'%d/%m/%Y %H:%i:%S') from modem_alerts where meter_id='" + meterId + "' and ";

                    }

                }
                sql1 = sql1 + " substr(alert_desc ,1,3) in (";

                if (chkvalue.contains("0")) //for Meter com failed.
                {
                    sql1 = sql1 + "'Met'";
                } else {
                    sql1 = sql1 + "''";
                }
                if (chkvalue.contains("1")) // for AMR power failed.
                {
                    sql1 = sql1 + ",'AMR'";
                } else {
                    sql1 = sql1 + ",''";
                }
                if (chkvalue.contains("2")) // for DTR power failed.
                {
                    sql1 = sql1 + ",'DTR'";
                } else {
                    sql1 = sql1 + ",''";
                }
                if (chkvalue.contains("3")) // for CRC failed.
                {
                    sql1 = sql1 + ",'CRC'";
                } else {
                    sql1 = sql1 + ",''";
                }

                sql1 = sql1 + ") order by alert_generated_date desc";
                if (DBUtil.getTargetDB().equals("mysql")) {
                    sql1 = sql1 + " limit " + (start - 1) + "," + limit;
                }
                if (DBUtil.getTargetDB().equals("oracle")) {
                    sql1 = sql1 + ") where rownum<" + (start + limit) + ") where r>=" + (start);
                }
                System.out.println("query is" + sql1);
                rs = st.executeQuery(sql1);
                while (rs.next()) {
                    flag = 1;

        %>

        <tr>
            <td align="center"><%=rs.getString("alert_desc")%></td>
            <td align="center"><%=rs.getString(2)%></td>

        </tr>

        <%
            }
            if (flag == 0) {%>
        <tr><td colspan="2" align="center">No Alerts</td></tr>
        <%  }

            } catch (Exception e) {
                e.printStackTrace();
            }//catch      
        %>
    </tbody></table>
    <%  }//if not feeder
    else {      //if feeder
        limit = 32;
        System.out.println("meterid is" + meterId);
        con1 = new DBUtil().getConnection();
        st = con1.createStatement();
        sql = "select substationname from substation where substationid=" + substationId;
        rs1 = st.executeQuery(sql);
        if (rs1.next()) {
            substationName = rs1.getString(1);
        }
        rs1.close();
        st.close();
        System.out.println("substationname is----->" + substationName);
        st = con1.createStatement();
        sql = "select meter_serial_no,modem_serial_no from meter where meter_serial_no='" + meterId + "'";
        System.out.println("sql is" + sql);
        rs1 = st.executeQuery(sql);

    %>
<table border="1" class='mtable' id="modem_alerts" cellpadding="2" cellspacing="2" >
    <tbody>
        <%
            if (rs1.next()) {

        %>
        <tr><td colspan="3" align="center">&nbsp;&nbsp;&nbsp;Meter Serial Number:&nbsp;<%=meterId%>


        </tr>
        <% }%>
        <tr>
            <td><h3>SUBSTATION</h3></td>
            <% if (meterId.equals("All") && chkvalue.contains("0") || chkvalue.contains("2") || chkvalue.contains("3") || chkvalue.contains("4")) {%>
            <td><h3>Feeder</h3></td> 
            <td ><h3>ALERT DESC</h3></td>
            <td><h3>ALERT GENERATED DATE</h3></td>
            <% } else {%>
            <td ><h3>ALERT DESC</h3></td>
            <td><h3> OCCURED</h3></td>
            <td><h3> RESTORED</h3></td>
            <td><h3> DURATION OF EVENT  &nbsp;(hh:mm:ss)</h3></td>
            <% }%>
        </tr>

        <%
            try {
                //-------------count of no of records----------------


                if (DBUtil.getTargetDB().equals("oracle")) {
                    if (!fromDate.equals("") && !endDate.equals("")) {
                        //getting the next date of end date
                        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
                        java.util.Date oldDate = sdf.parse(endDate);
                        java.util.Date newDate = new java.util.Date(oldDate.getTime() + 24 * 3600000);
                        String latestDate = sdf.format(newDate);
                        sql1 = "select count(*) from modem_alerts  where alert_generated_date >= to_date('" + fromDate + "','dd/mm/yyyy') and alert_generated_date < = to_date('" + latestDate + "','dd/mm/yyyy') and";
                    } else {
                        sql1 = "select count(*) from modem_alerts  where  ";
                    }
                } else if (DBUtil.getTargetDB().equals("mysql")) {
                    if (!fromDate.equals("") && !endDate.equals("")) {
                        //getting the next date of end date
                        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
                        java.util.Date oldDate = sdf.parse(endDate);
                        java.util.Date newDate = new java.util.Date(oldDate.getTime() + 24 * 3600000);
                        String latestDate = sdf.format(newDate);
                        //System.out.println("Latest date---->"+latestDate);                       
                        sql1 = "select count(*) from modem_alerts where alert_generated_date >= str_to_date('" + fromDate + "','%d/%m/%Y') and alert_generated_date <= str_to_date('" + latestDate + "','%d/%m/%Y') and ";

                    } else {
                        sql1 = "select count(*) from modem_alerts where ";
                    }
                }
                if (chkvalue.contains("0")) //for CRC failed.
                {
                    sql1 = sql1 + " alert_desc like 'CRC Failed%' and meter_id in(select meter_serial_no from meter where feederid in (select feederid from feeder where substationid=" + substationId + ")) order by alert_generated_date desc";
                }
                if (chkvalue.contains("2")) //for Invalid data failed.
                {
                    sql1 = sql1 + " alert_desc like 'INVALID%' and meter_id in(select meter_serial_no from meter where feederid in (select feederid from feeder where substationid=" + substationId + ")) order by alert_generated_date desc";
                }
                if (chkvalue.contains("1")) // for AMR power failed.
                {
                    if (Integer.parseInt(substationId) != 0) {
                        sql1 = sql1 + " meter_id like '" + substationName + "%' and ";
                    }
                    sql1 = sql1 + " substr(alert_desc ,1,3) in (";
                    sql1 = sql1 + "'DCU' ) order by alert_generated_date asc ";
                }
                if (chkvalue.contains("3")) // for ZERO NETWORK.
                {
                    if (Integer.parseInt(substationId) != 0) {
                        sql1 = sql1 + " meter_id like '" + substationName + "%' and ";
                    }
                    sql1 = sql1 + " alert_desc like '%Network%' order by alert_generated_date asc";
                }
                if (chkvalue.contains("4")) // for not communicating.
                {
                    sql1 = sql1 + " alert_desc like '%Not%' and meter_id in(select meter_serial_no from meter where feederid in (select feederid from feeder where substationid=" + substationId + ")) order by alert_generated_date desc";
                }
                System.out.println("no of records-->" + sql1);
                PreparedStatement psc = con1.prepareStatement(sql1);
                ResultSet rsc = psc.executeQuery();
                if (rsc.next()) {
                    count = Integer.parseInt(rsc.getString(1));
                }
                System.out.println("tot records-#######-->" + count);

                //-------------end of count ---------------------------

                if (DBUtil.getTargetDB().equals("oracle")) {
                    if (!fromDate.equals("") && !endDate.equals("")) {
                        //getting the next date of end date
                        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
                        java.util.Date oldDate = sdf.parse(endDate);
                        java.util.Date newDate = new java.util.Date(oldDate.getTime() + 24 * 3600000);
                        String latestDate = sdf.format(newDate);
                        sql1 = "select alert_desc,aldate,meter_id from("
                                + "select alert_desc,aldate,meter_id,rownum r from("
                                + "select alert_desc,to_char(ALERT_GENERATED_DATE,'dd/mm/yyyy hh24:mi:ss') aldate,meter_id from modem_alerts  where alert_generated_date >= to_date('" + fromDate + "','dd/mm/yyyy') and alert_generated_date < = to_date('" + latestDate + "','dd/mm/yyyy') and";
                    } else {
                        sql1 = "select alert_desc,aldate,meter_id from("
                                + "select alert_desc,aldate,meter_id,rownum r from("
                                + "select alert_desc,to_char(ALERT_GENERATED_DATE,'dd/mm/yyyy hh24:mi:ss') aldate,meter_id from modem_alerts  where  ";
                    }
                } else if (DBUtil.getTargetDB().equals("mysql")) {
                    if (!fromDate.equals("") && !endDate.equals("")) {
                        //getting the next date of end date
                        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
                        java.util.Date oldDate = sdf.parse(endDate);
                        java.util.Date newDate = new java.util.Date(oldDate.getTime() + 24 * 3600000);
                        String latestDate = sdf.format(newDate);
                        sql1 = "select alert_desc,DATE_FORMAT(alert_generated_date,'%d/%m/%Y %H:%i:%S'),meter_id from modem_alerts where alert_generated_date >= str_to_date('" + fromDate + "','%d/%m/%Y') and alert_generated_date <= str_to_date('" + latestDate + "','%d/%m/%Y') and ";
                    } else {
                        sql1 = "select alert_desc,DATE_FORMAT(alert_generated_date,'%d/%m/%Y %H:%i:%S'),meter_id from modem_alerts where ";
                    }
                }
                if (chkvalue.contains("0")) //for Meter com failed.
                {
                    sql1 = sql1 + " alert_desc like 'CRC Failed%' and meter_id in(select meter_serial_no from meter where feederid in (select feederid from feeder where substationid=" + substationId + ")) order by alert_generated_date desc";
                }
                if (chkvalue.contains("2")) //for Meter com failed.
                {
                    sql1 = sql1 + " alert_desc like 'INVALID%' and meter_id in(select meter_serial_no from meter where feederid in (select feederid from feeder where substationid=" + substationId + ")) order by alert_generated_date desc";
                }
                if (chkvalue.contains("1")) // for AMR power failed.
                {
                    if (Integer.parseInt(substationId) != 0) {
                        sql1 = sql1 + " meter_id like '" + substationName + "%' and ";
                    }
                    sql1 = sql1 + " substr(alert_desc ,1,3) in (";
                    sql1 = sql1 + "'DCU' ) order by alert_generated_date asc ";
                }
                if (chkvalue.contains("3")) // for ZERO NETWORK.
                {
                    if (Integer.parseInt(substationId) != 0) {
                        sql1 = sql1 + " meter_id like '" + substationName + "%' and ";
                    }
                    sql1 = sql1 + " alert_desc like '%Network%' order by alert_generated_date asc";
                }
                if (chkvalue.contains("4")) // for not communicating.
                {
                    sql1 = sql1 + " alert_desc like '%Not%' and meter_id in(select meter_serial_no from meter where feederid in (select feederid from feeder where substationid=" + substationId + ")) order by alert_generated_date desc";
                }
                if (DBUtil.getTargetDB().equals("mysql")) {
                    sql1 = sql1 + "limit " + (start - 1) + "," + limit;
                }
                if (DBUtil.getTargetDB().equals("oracle")) {
                    sql1 = sql1 + ") where rownum<" + (start + limit) + ") where r>=" + (start);
                }
                // sql1 = sql1 + " order by alert_generated_date asc";

                //System.out.println("query is" + sql1);
                rs = st.executeQuery(sql1);

                List<String> PFList = null;
                PFList = new ArrayList<String>();

                while (rs.next()) {

                    flag = 1;

        %>


        <%

            if (meterId.equals("All") && chkvalue.contains("1")) {    //block for DCU power failed 

                String listElement = rs.getString(3) + "," + rs.getString("alert_desc") + "," + rs.getString(2);
                PFList.add(listElement);
            }%>


        <tr>

            <% if (meterId.equals("All") && chkvalue.contains("0") || chkvalue.contains("2") || chkvalue.contains("4")) {       //for crc failed

                    String sql_feeder = "";
                    if (Integer.parseInt(substationId) != 0) {
                        sql_feeder = "select f.feedername,m.meter_serial_no from meter m,feeder f where f.feederid=m.feederid and m.meter_serial_no='" + rs.getString(3) + "' and f.substationid=" + substationId;
                    } else {
                        sql_feeder = "select f.feedername,m.meter_serial_no from meter m,feeder f where f.feederid=m.feederid and m.meter_serial_no='" + rs.getString(3) + "'";
                    }
                    // System.out.println("sql_feeder-->" + sql_feeder);
                    PreparedStatement ps = con1.prepareStatement(sql_feeder);
                    ResultSet rs_feeder = ps.executeQuery();
                    if (rs_feeder.next()) {
                        System.out.println("in if loop");
                        if (Integer.parseInt(substationId) != 0) {
            %>           
            <td align="center"><%= substationName%></td>
            <% } else {%>
            <td align="center">---</td>
            <% }%>
            <td align="center"><%=rs_feeder.getString(1)%></td>
            <td align="center"><%=rs.getString("alert_desc")%></td>
            <td align="center"><%=rs.getString(2)%></td>
            <%}
                    rs_feeder.close();
                    ps.close();
                }   //end of crc failed block

                if (meterId.equals("All") && chkvalue.contains("3")) {
            %>
            <td align="center"><%= substationName%></td>           
            <td align="center">---</td>           
            <td align="center"><%=rs.getString("alert_desc")%></td>
            <td align="center"><%=rs.getString(2)%></td>

            <% }
            %>        


        </tr>


        <%
            }//while

            if (meterId.equals("All") && chkvalue.contains("1")) {     //block for DCU power failed  
                List<String> result = new ArrayList<String>();
                //System.out.println("pflist lize---->"+PFList.size());
                for (int i = 0; i < PFList.size(); i++) {

                    String output = "";
                    if (PFList.get(i).split(",")[1].contains("FAIL")) {

                        if (i < PFList.size() - 1) {
                            if (PFList.get(i + 1).split(",")[1].toString().contains("RESTORED")) //IF NEXT ONE is power restored
                            {
                                output = PFList.get(i).split(",")[0] + "\t" + PFList.get(i).split(",")[1] + "\t";
                                output = output + PFList.get(i).split(",")[2] + "\t" + PFList.get(i + 1).split(",")[2];
                            } else { //if next one is also fail
                                output = PFList.get(i).split(",")[0] + "\t" + PFList.get(i).split(",")[1] + "\t";
                                output = output + PFList.get(i).split(",")[2] + "\t" + "......";
                            }
                        }
                    }
                    if (PFList.get(i).split(",")[1].contains("RESTORED")) {

                        if (i > 0) {
                            if (PFList.get(i - 1).split(",")[1].contains("FAIL")) {
                                // if previous one is DCU POWER FAIL then nothing to do
                            } else {

                                output = PFList.get(i).split(",")[0] + "\t" + PFList.get(i).split(",")[1] + "\t";
                                output = output + "....." + "\t" + PFList.get(i).split(",")[2];
                            }
                        } else {
                            //if the record is first record and it is DCU POWER RESTORED THEN                       
                            output = PFList.get(i).split(",")[0] + "\t" + PFList.get(i).split(",")[1] + "\t";
                            output = output + "....." + "\t" + PFList.get(i).split(",")[2];
                        }

                    }
                    //System.out.println(output);
                    //System.out.println("list size---->"+result.size());
                    result.add(output);
                }//for

                //  for (int i = result.size() - 1; i >= 0; i--) {
                for (int i = 0; i <= result.size() - 1; i++) {

                    Calendar c = Calendar.getInstance();
                    SimpleDateFormat sdf1 = new SimpleDateFormat("dd/MM/yyyy H:m:s");
                    //SimpleDateFormat sdf1 = new SimpleDateFormat("HH:mm");
                    java.util.Date occuredDate, restoredDate;
                    Long duration = 0L;
                    if (result.get(i).split("\t").length > 1 && !result.get(i).split("\t")[2].contains("...") && !result.get(i).split("\t")[3].contains("...")) {

                        occuredDate = sdf1.parse(result.get(i).split("\t")[2]);
                        restoredDate = sdf1.parse(result.get(i).split("\t")[3]);
                        if (restoredDate.getTime() < (new java.util.Date().getTime() - 1000 * 60 * 60 * 1)) {
                            //duration= (restoredDate.getTime()-occuredDate.getTime())/(1000*60);
                            Long timeInMills = restoredDate.getTime() - occuredDate.getTime();
                            if (timeInMills > (30 * 1000)) //if time difference is greater than 30 seconds
                            {
                                Long hours = TimeUnit.MILLISECONDS.toHours(timeInMills);
                                Long minutes = TimeUnit.MILLISECONDS.toMinutes(timeInMills - (hours * 1000 * 60 * 60));
                                Long seconds = TimeUnit.MILLISECONDS.toSeconds(timeInMills - ((hours * 1000 * 60 * 60) + (minutes * 1000 * 60)));

        %>
        <tr>
            <td align="center"><%= result.get(i).split("\t")[0]%></td>
            <td align="center"><%= result.get(i).split("\t")[1]%></td>
            <td align="center"><%= result.get(i).split("\t")[2]%></td>
            <td align="center"><%= result.get(i).split("\t")[3]%></td>
            <td align="center"><%= (hours < 10 ? "0" + hours : hours) + ":" + (minutes < 10 ? "0" + minutes : minutes) + ":" + (seconds < 10 ? "0" + seconds : seconds)%></td>
        </tr>   
        <%
                }//if for greater than 30 seconds
            }// displaying alerts upto before 3 hrs only
        } //if event contains both occured and restored
        else if (result.get(i).split("\t").length > 1) {
        %>
        <tr>
            <td align="center"><%= result.get(i).split("\t")[0]%></td>
            <td align="center"><%= "DCU POWER FAIL"%></td>
            <td align="center"><%= result.get(i).split("\t")[2]%></td>
            <td align="center"><%= result.get(i).split("\t")[3]%></td>
            <td align="center"><%= "...."%></td>
        </tr>   
        <%
                    }
                } //for 
            }//if

            if (flag == 0) {%>
        <tr><td colspan="2" align="center">No Alerts</td></tr>
        <%  }

            } catch (Exception e) {
                e.printStackTrace();
            }//catch      
        %>
    </tbody></table>
    <%  }//if feeder %>
<!-- code for pagination --->
<table width="100%" border="0">
    <tr>
        <td width="100%" align="center">
            <table> 
                <tr>
                    <%


                        // code for previous
                        int start_tmp = start;

                        // code for page numbers
                        //  start = 1;

                        if (((Integer.parseInt(request.getParameter("start")) - 1) / 10) + 1 > limit) {
                    %>
                    <td id="pageNo" style="border:1px solid red;padding-right:5px;padding-left:5px;"><a href="#"  onclick="javascript:Alerts(<%=((start_tmp / (limit * 10)) * (limit * 10)) - (limit - 1)%>)" style="text-decoration:none;">Prev 10</a></td>
                    <%
                        }
                        int page_no_start = (start_tmp / (limit * 10)) * (limit * 10) + 1;
                        int page_no_end = ((start_tmp / (limit * 10)) * (limit * 10)) + (limit * 9);
                        page_no_start = (page_no_start / limit) + 1;
                        page_no_end = (page_no_end / limit) + 1;

                        start = 1;
                        if (page_no_end >= Math.ceil((double) count / (double) limit)) {
                            page_no_end = (int) Math.ceil((double) count / (double) limit);
                        }

                        for (int i = 1; i <= Math.ceil((double) count / (double) limit); i++) {
                            if (i >= page_no_start && i <= page_no_end) {
                                if (i == ((Integer.parseInt(request.getParameter("start")) - 1) / limit) + 1) {
                    %>

                    <td id="pageNo" style="border:1px solid red;padding-right:5px;padding-left:5px;"><a href="#"  onclick="javascript:Alerts(<%=start%>)" style="text-decoration:none;"><%=i%></a></td>

                    <%
                    } else {
                    %>

                    <td id="pageNo"><a href="#"  onclick="javascript:Alerts(<%=start%>)"><%=i%></a></td>

                    <%
                                }
                            }
                            start = start + limit;
                        }
                        // code for next
                        //if((((Integer.parseInt(request.getParameter("start"))-1)/10)+1)>=1)
                        start = start_tmp;
                        if (page_no_end >= Math.ceil((double) count / (double) limit)) {
                        } else {
                            // start = Integer.parseInt(request.getParameter("start")) + 100;

                            start = (((start_tmp / (limit * 10)) * (limit * 10)) + (limit * 9)) + limit + 1;

                    %>

                    <td id="pageNo"  style="border:1px solid red;padding-right:5px;padding-left:5px;"><a href="#"  onclick="javascript:Alerts(<%=start%>)" style="text-decoration:none;">Next 10</a></td>

                    <%
                        }

                    %>
                </tr>
            </table>
        </td>
    </tr>
</table> 



