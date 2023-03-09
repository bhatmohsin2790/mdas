<%@page import="in.amitech.db.DBUtil"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.*"%>

    <style type="text/css" >
        #dtr_data h3
        {background-color:#EEEEEE;
         border:1px solid #DDDDDD;
         color:#666666;
         width:auto;
         font-size:12px;
         padding:5px 15px;
         text-decoration:none;}

    </style>
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
<%
    String substationName = "";
    String meterLocation = request.getParameter("location").trim();
    String substationId = request.getParameter("substationId").trim();
    String selectedDate=null;
   SimpleDateFormat sdf=new SimpleDateFormat("dd/MM/yyyy");
  SimpleDateFormat sdf1=new SimpleDateFormat("dd-MMM-yy");
    Connection con1 = null;
    PreparedStatement pstmt = null;
    Statement st=null;
    con1 = new DBUtil().getConnection();
    String sql = null;
    ResultSet rs = null;
    int flag = 0;
    //---------------------
    String meterId = request.getParameter("meterId").trim();
    selectedDate = request.getParameter("date").trim();

	selectedDate=sdf1.format(sdf.parse(selectedDate));
    int start = Integer.parseInt(request.getParameter("start"));
    System.out.print("start value is" + start);
    
    if (!meterLocation.equals("feeder")) {
%>

    <table border="0" id="dtr_data" width="100%" >
        <thead>

            <tr>
                <th class="thstyle" align="center">MODEM_DATE_TIME</th>
               <th class="thstyle" align="center">BATTERY_VOLTAGE</th>
                <th class="thstyle" align="center">NETWORK_STRENGTH</th>              
                <th class="thstyle" align="center">MODEM_TEMPRATUR</th>
               <!-- <td align="center"><h3>MODEM_METER_COM_FAIL_COUNT</h3></td>
                <td align="center"><h3>MODEM_SERVER_COM_FAIL_COUNT</h3></td> -->
             

            </tr>
			</thead>
			<tbody>
            <% 
                     

                        System.out.println("meterid is" + meterId);
                        String meterSlNo = meterId.substring(2);
                        System.out.println(meterSlNo);
                        if (DBUtil.getTargetDB().equals("oracle")) {
                          
                            sql="select meter_id,modem_date_time,battery_voltage,network_strength,"
                                    + "Modem_temprature,MODEM_METER_COM_FAIL_COUNT, MODEM_SERVER_COM_FAIL_COUNT "
                                    + "from modemdiagnosis where meter_id='" + meterId + "' and "
                                    + "modem_date_time like '" + selectedDate + "%' order by cast(to_date(modem_date_time, 'dd-MON-YYYY hh:mi:ssam') AS TIMESTAMP) asc ";
                            pstmt = con1.prepareStatement(sql);
                           
                        } else {
                            sql = "select meter_id,DATE_FORMAT(modem_date_time,'%d/%m/%Y %H:%i:%s'),"
                                    + "battery_voltage,network_strength,network_status,Modem_temprature,"
                                    + "MODEM_METER_COM_FAIL_COUNT,MODEM_SERVER_COM_FAIL_COUNT,log_time_stamp,"
                                    + "CONSUMER_ID "
                                    + "from modem_diagnosis "
                                    + " where meter_id='" + meterId + "' and "
                                    + "date_format(modem_date_time,'%d/%m/%Y')='" + selectedDate + "' order by modem_date_time asc ";
                            pstmt = con1.prepareStatement(sql);
                          
                        }//end if

 System.out.println("Diagnosis query is--->"+sql);
                        rs = pstmt.executeQuery();
                        while (rs.next()) {
                            flag = 1;

            %>
            <tr class="trbg">
                <td class="tdbg" align="center"><%=rs.getString(2)%></td>
                <td class="tdbg" align="center"><%=rs.getString("BATTERY_VOLTAGE")%></td>
                <td class="tdbg" align="center"><%=rs.getString("NETWORK_STRENGTH")%></td>             
                <td class="tdbg" align="center"><%=rs.getString("MODEM_TEMPRATURE")%></td>
              <%--  <td align="center"><%=rs.getString("MODEM_METER_COM_FAIL_COUNT")%></td>
                <td align="center"><%=rs.getString("MODEM_SERVER_COM_FAIL_COUNT")%></td> --%>
              




            </tr>


            <%
                        }//end while
                        if (flag == 0) {
                            out.println("NO Diagnosis in this Date : " + selectedDate);
                                                       }
            %>
        </tbody></table>


<!-- code for pagination --->
<%--<table width="100%" border="0">
    <tr>
        <td width="100%" align="center">
            <table>
                <tr>
                    <%


                                                // code for previous
                                                int start_tmp = start;

                                                // code for page numbers
                                                //  start = 1;

                                                if (((Integer.parseInt(request.getParameter("start")) - 1) / 10) + 1 > 10) {
                    %>
                    <td id="pageNo" style="border:1px solid red;padding-right:5px;padding-left:5px;"><a href="#"  onclick="javascript:diagnosis(<%=((start_tmp / 100) * 100) - 9%>)" style="text-decoration:none;">Prev 10</a></td>
                    <%
                                                }
                                                int page_no_start = (start_tmp / 100) * 100 + 1;
                                                int page_no_end = ((start_tmp / 100) * 100) + 90;
                                                page_no_start = (page_no_start / 10) + 1;
                                                page_no_end = (page_no_end / 10) + 1;

                                                start = 1;
                                                if (page_no_end >= Math.ceil((double) count / (double) limit)) {
                                                    page_no_end = (int) Math.ceil((double) count / (double) limit);


                                                }
                                                for (int i = 1; i <= Math.ceil((double) count / (double) limit); i++) {
                                                    if (i >= page_no_start && i <= page_no_end) {
                                                        if (i == ((Integer.parseInt(request.getParameter("start")) - 1) / 10) + 1) {
                    %>

                    <td id="pageNo" style="border:1px solid red;padding-right:5px;padding-left:5px;"><a href="#"  onclick="javascript:diagnosis(<%=start%>)" style="text-decoration:none;"><%=i%></a></td>

                    <%
                                                                            } else {
                    %>

                    <td id="pageNo"><a href="#"  onclick="javascript:diagnosis(<%=start%>)"><%=i%></a></td>

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


                                                    start = Integer.parseInt(request.getParameter("start")) + 100;

                    %>

                    <td id="pageNo"  style="border:1px solid red;padding-right:5px;padding-left:5px;"><a href="#"  onclick="javascript:diagnosis(<%=start%>)" style="text-decoration:none;">Next 10</a></td>

                    <%
                                    }//end else
                                }//end if flag

                    %>
                </tr>
            </table>
        </td>
    </tr>
</table> --%>
<% }//if not feeder
       else{   //if feeder 
         st = con1.createStatement();
        sql = "select substationname from substation where substationid=" + substationId;
        rs = st.executeQuery(sql);
        if (rs.next()) {
            substationName = rs.getString(1);
        }
        rs.close();
        st.close();
        System.out.println("substationname is----->" + substationName);
        %>
        <div style="overflow: auto;width: 850px; ">
    <table border="0" id="dtr_data" >
        <tbody>

            <tr>
                <td align="center"><h3>SUBSTATION NAME</h3></td>
                <td align="center"><h3>DATE TIME</h3></td>               
                <td align="center"><h3>NETWORK STRENGTH</h3></td>               

            </tr>
            <% 
                        //getting the latest date from modem diagnosis table when date is not selected
                        if(selectedDate.equals(""))
                         {
                           if (DBUtil.getTargetDB().equals("mysql")) {
                               sql="select date_format(modem_date_time,'%d/%m/%Y') from modem_diagnosis  where meter_id='"+meterId+"' order by modem_date_time desc limit 1";
                               pstmt=con1.prepareStatement(sql);
                               rs=pstmt.executeQuery();
                               if(rs.next())
                                   selectedDate=rs.getString(1);
                           } else{}
                            
                        }
                        System.out.println("meterid is" + meterId);                     
                        
                        if (DBUtil.getTargetDB().equals("oracle")) {
                            sql = "select meter_id,to_char(modem_date_time,'dd/mm/yyyy hh24:mi:ss'),network_strength from modem_diagnosis where meter_id='"+substationName+"' and to_char(modem_date_time,'dd/mm/yyyy')='"+selectedDate+"' order by modem_date_time asc";
                             pstmt = con1.prepareStatement(sql);
                        } else {
                            if(meterId.equals("All") && Integer.parseInt(substationId)!=0)                                
                              sql = "select meter_id,DATE_FORMAT(modem_date_time,'%d/%m/%Y %H:%i:%s'),"
                                   +" network_strength from modem_diagnosis where meter_id like '" + substationName + "%' and "
                                    + "date_format(modem_date_time,'%d/%m/%Y')='" + selectedDate + "'";
                             if(meterId.equals("All") && Integer.parseInt(substationId)==0) 
                                 sql = "select meter_id,DATE_FORMAT(modem_date_time,'%d/%m/%Y %H:%i:%s'),"
                                   +" network_strength from modem_diagnosis where modem_temprature is null and "
                                    + "date_format(modem_date_time,'%d/%m/%Y')='" + selectedDate + "'";
                            if(!meterId.equals("All"))
                                sql="select meter_id,DATE_FORMAT(modem_date_time,'%d/%m/%Y %H:%i:%s'),"
                                   +" network_strength from modem_diagnosis where meter_id='" + meterId + "' and "
                                    + "date_format(modem_date_time,'%d/%m/%Y')='" + selectedDate + "'";
                            pstmt = con1.prepareStatement(sql);
                            
                        }//end if

 System.out.println("Diagnosis query is--->"+sql);
                        rs = pstmt.executeQuery();
                        while (rs.next()) {
                            flag = 1;

            %>
            <tr>
                <td align="center"><%=rs.getString(1)%></td>
                <td align="center"><%=rs.getString(2)%></td>
                <td align="center"><%=rs.getString(3)%></td>
            </tr>


            <%
                        }//end while
                        if (flag == 0) 
                            out.println("NO Diagnosis in this Date : " + selectedDate);
            %>
        </tbody></table>

</div>
      <%
        
       }
%>

