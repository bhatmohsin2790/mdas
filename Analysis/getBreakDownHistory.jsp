<%@page import="java.util.concurrent.TimeUnit"%>
<%@page import="java.util.*"%>
<%@page import="java.text.*"%>
<%@page import="java.sql.*"%>
<%@page import="in.amitech.db.DBUtil"%>
<style>
        .thstyle{
        background-color: #8FA1B5; 
        color:#FFFFFF;
         font-size:14px;
         border-left:1px solid #FFFFFF;
          text-decoration:none;
          font-family: monospace;
           border-bottom: 1px solid #FFFFFF;
        }
        .trbg{
            background-color: #E8EBE2;
             border-bottom: 1px solid #FFFFFF;
        }
        .tdbg{
             border-bottom: 1px solid #FFFFFF;
             border-left: 1px solid #FFFFFF;
        }
        #district_11kv_load tr  td {
             background-color: #E8EBE2;
              border-bottom: 1px solid #FFFFFF;
             border-left: 1px solid #FFFFFF;
        }
     </style> 
<%!    PreparedStatement pstmt = null;
    ResultSet rs = null;
    String[] data_string2 = new String[0];
    int flag = 0;
%>
<%
    try {
        NumberFormat twoDecFormat = new DecimalFormat("#0.000");
        String meter_id = request.getParameter("meterNo");
        String sdate = request.getParameter("fromDate");
        String edate = request.getParameter("toDate");
        String stringToReturn = "";
%>



<table  width="100%" class="stdtable stdtablecb smallfont" id="dtable">
   <thead>
        <tr>
        <th class="thstyle">Sl No</th>
        <th class="thstyle">Down Time</th>
        <th class="thstyle">Up Time</th>
        <th class="thstyle">Non-Communication Duration  (hh:mm)</th>
 </tr>
    </thead>
    <tbody>
    <%
    Connection con=new DBUtil().getConnection();
        System.out.println("<--------------------------->");
       
        String sql = "";

//if dates are not selected
        if (sdate.equals("") && edate.equals("")) {
    }//if
    //if dates are selected
    else if (!sdate.equals("") && !edate.equals("")) {
       
            sql = "select  event_date,(e.event_type)event_name,event_status,data_string,d.event_type from "
                    + "d5_data d,events e where meter_serial_no='"+meter_id+"' "
                    + "and d.event_type=e.event_code and trunc(d5_time_stamp) >=to_date('" + sdate + "','DD/MM/YYYY') "
                    + "and trunc(d5_time_stamp) <=to_date('" + edate + "','DD/MM/YYYY')and  "
                    + "d.event_type=13 order by d5_time_stamp asc";
            pstmt = con.prepareStatement(sql);
           
            rs = pstmt.executeQuery();
         List<String> PFList= new ArrayList<String>();
        while (rs.next()) {
               String listElement =  meter_id+","+rs.getString("event_status") + "," + rs.getString(1);
                PFList.add(listElement);
            }//while
            List<String> result = new ArrayList<String>();
                for (int i = 0; i < PFList.size(); i++) {
                    String output = "";
                    if (PFList.get(i).split(",")[1].contains("occurred")) {

                        if (i < PFList.size() - 1) {
                            if (PFList.get(i + 1).split(",")[1].toString().contains("restored")) //IF NEXT ONE is power restored
                            {
                                output = PFList.get(i).split(",")[0] + "\t" + PFList.get(i).split(",")[1] + "\t";
                                output = output + PFList.get(i).split(",")[2] + "\t" + PFList.get(i + 1).split(",")[2];
                            } else { //if next one is also fail
                                output = PFList.get(i).split(",")[0] + "\t" + PFList.get(i).split(",")[1] + "\t";
                                output = output + PFList.get(i).split(",")[2] + "\t" + "......";
                            }
                        }
                    }
                    if (PFList.get(i).split(",")[1].contains("restored")) {

                        if (i > 0) {
                            if (PFList.get(i - 1).split(",")[1].contains("occurred")) {
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
                    result.add(output);
                }//for
            int sno=1;
            System.out.println("result size+++++++++++++>"+result.size());
            if(result.size()>0){
            for (int i = 0; i <= result.size() - 1; i++) {
                    Calendar c = Calendar.getInstance();
                    SimpleDateFormat sdf1 = new SimpleDateFormat("dd-MM-yyyy H:m:s");
                    //SimpleDateFormat sdf1 = new SimpleDateFormat("HH:mm");
                    java.util.Date occuredDate, restoredDate;
                    Long duration = 0L;
                    if (result.get(i).split("\t").length > 1 && !result.get(i).split("\t")[2].contains("...") && !result.get(i).split("\t")[3].contains("...")) {

                        occuredDate = sdf1.parse(result.get(i).split("\t")[2]);
                        restoredDate = sdf1.parse(result.get(i).split("\t")[3]);
                            //duration= (restoredDate.getTime()-occuredDate.getTime())/(1000*60);
                            Long timeInMills = restoredDate.getTime() - occuredDate.getTime();
                           
                                Long hours = TimeUnit.MILLISECONDS.toHours(timeInMills);
                                Long minutes = TimeUnit.MILLISECONDS.toMinutes(timeInMills - (hours * 1000 * 60 * 60));
                                Long seconds = TimeUnit.MILLISECONDS.toSeconds(timeInMills - ((hours * 1000 * 60 * 60) + (minutes * 1000 * 60)));

        %>
        <tr class="trbg">
            <td class="tdbg" align="center"><%=sno%></td>
            <td class="tdbg"  align="center"><%= result.get(i).split("\t")[2]%></td>
            <td class="tdbg"  align="center"><%= result.get(i).split("\t")[3]%></td>
            <td class="tdbg"  align="center"><%= (hours < 10 ? "0" + hours : hours) + ":" + (minutes < 10 ? "0" + minutes : minutes) %></td>
        </tr>   
        <%
        sno++;
        } //if event contains both occured and restored
        else if (result.get(i).split("\t").length > 1) {
        %>
        <tr class="trbg">
            <td class="tdbg"  align="center"><%= sno%></td>
            <td class="tdbg"  align="center"><%= result.get(i).split("\t")[2]%></td>
            <td class="tdbg"  align="center"><%= result.get(i).split("\t")[3]%></td>
            <td class="tdbg"  align="center"><%= "...."%></td>
        </tr>   
        <%
                    }
                    
                } //for 
}else{ %>
<tr class="trbg"><td class="tdbg" colspan="4" align="center">No Data Available...</td></tr>
<%}

        }//elseif


    %>
    </tbody>
</table> 

<%
    } catch (Exception e) {
        out.println("Plz Try Again....");
        e.printStackTrace();
    }
%>