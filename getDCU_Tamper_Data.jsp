<%@ page session="false" %>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ include file="getConnection1.jsp"%>
<link rel="stylesheet" type="text/css" href="css/style.css" />
<%
try{
    NumberFormat twoDecFormat = new DecimalFormat("#0.000");
    SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
    SimpleDateFormat dateFormat1 = new SimpleDateFormat("yyyy-MM-dd");
    SimpleDateFormat timeFormat = new SimpleDateFormat("HH:mm:ss");
String dcu_id = request.getParameter("dcu_id");
// pstmt = con.prepareStatement("select m.meterid,m.meter_serial_no,f.feederid,f.feedername,f.dcuid,f.classvoltage from meter m,feeder f where m.feederid=f.feederid "
         //       + "and m.feederid in  (select feederid from feeder where substationid=?)");
        String sql11 = "select m.meterid,m.meter_serial_no,f.feederid,f.feedername,f.dcuid,f.classvoltage from meter m,feeder f where m.feederid=f.feederid and m.meterid in ("+dcu_id+")";
                System.out.println("Qry==>"+sql11);
       PreparedStatement pstmt = con.prepareStatement(sql11);
        //pstmt.setString(1, dcu_id);
ResultSet rs = pstmt.executeQuery();

String f_ids = "";
String f_names = "";
String meter_ids = "";
String meter_serial_nos = "";
System.out.println("hi1");
while(rs.next())
{
    System.out.println("hi");
    f_ids = f_ids + rs.getString("feederid") + ",";
    f_names = f_names + rs.getString("feedername") + ",";
    meter_ids = meter_ids + rs.getString("meterid") + ",";
    meter_serial_nos = meter_serial_nos + rs.getString("meter_serial_no") + ",";
}

String[] f_ids_arr = f_ids.split(",");
String[] f_names_arr = f_names.split(",");
String[] meter_ids_arr = meter_ids.split(",");
String[] meter_serial_nos_arr = meter_serial_nos.split(",");

for(int i=0;i<f_ids_arr.length;i++)
{
    System.out.println(f_ids_arr[i]+"-->"+f_names_arr[i]+"--->"+meter_ids_arr[i]+"--->"+meter_serial_nos_arr[i]);
    String[] param_names = null;
    pstmt = con.prepareStatement("select * from d5_columns_header where meter_serial_no=(select meter_serial_no from meter where meterid=?)");
    pstmt.setString(1, meter_ids_arr[i]);
    rs = pstmt.executeQuery();
    if (rs.next()) 
    {
        System.out.println("---------------------------Tamper Header Got Dynamically-----------------------------------");
        param_names = rs.getString("tamper_columns_header").split(",");
    } 
    else 
    {
        System.out.println("---------------------------Tamper Header Got Manually-----------------------------------");
        pstmt = con.prepareStatement("select metermakeid,no_of_params,param_names from metermake where metermakeid=(select metermake from meter where meterid=?)");
        pstmt.setString(1, meter_ids_arr[i]);
        rs = pstmt.executeQuery();
        if (rs.next()) 
        {
            param_names = rs.getString("param_names").split(",");
        }//end if
    }//end else
    %>
    
    <table border="0" width="100%" id="table_disp" cellpadding="0" cellspacing="1px" style="float:left;margin-right: 10px;<% if(i>=2) out.println("margin-top:10px;"); %>" >
        <thead>
        <tr>
            <td colspan="20"><strong>Feeder Name : </strong><%= f_names_arr[i] %> (<%=meter_serial_nos_arr[i]%>)</td>
        </tr>        
        <tr>
            <td width="60px" align="center"><strong>DATE</strong></td>
            <td width="60px" align="center"><strong>TIME</strong></td>
            <td width="150px" align="center"><strong>EVENT TYPE</strong></td>
            <td width="110px" align="center"><strong>EVENT STATUS</strong></td>
            <%
             if(meter_serial_nos_arr[i].equals("12040485") ||meter_serial_nos_arr[i].equals("12040547") || meter_serial_nos_arr[i].equals("12040639") ||meter_serial_nos_arr[i].equals("12040560") ||meter_serial_nos_arr[i].equals("12040599") ||meter_serial_nos_arr[i].equals("12040537") ||meter_serial_nos_arr[i].equals("12040655") ||meter_serial_nos_arr[i].equals("12040585")||meter_serial_nos_arr[i].equals("12040455")||meter_serial_nos_arr[i].equals("12040513") )
               { %>
               <td width="60px" align="center">RV(V)</td>
               <TD width="60px" align="center">YV(V)</td>
               <td width="60px" align="center">BV(V)</td>
               <td width="60px" align="center">RI(A) </td>
               <td width="60px" align="center">YI(A)</td>
               <TD width="60px" align="center">BI(A)</td>
               <TD width="60px" align="center">RPF</TD>
               <TD width="60px" align="center">YPF</TD>
               <TD width="60px" align="center">BPF</TD>
               <TD width="60px" align="center">Fwd.kWh</TD>
          <%     }
                       else{
            for(int j=0;j<param_names.length;j++)
            {
            %>
              <td align="center"><%=param_names[j] %></td>
              <%
            }
                       }
            %>
        </tr>
        </thead>
        <tbody>
            <%
            System.out.println("meter_ids_arr[i]  "+meter_ids_arr[i]);
            if (DBUtil.getTargetDB().equals("mysql")) {
            pstmt = con.prepareStatement("select d5.event_type,e.event_type,d5.event_date,d5.event_status,d5.data_string,d5.d5_time_stamp from d5_data d5,events e where d5.cdfid in (select cdfid from  meter_data_time_stamp where meterid=?) and d5.event_type=e.event_code order by d5.d5_time_stamp desc limit 10");
                       }
            if (DBUtil.getTargetDB().equals("oracle")) {
            pstmt = con.prepareStatement("select event_type,event_name,event_date,event_status,data_string,d5_time_stamp "
                    + "from (select d5.event_type,(e.event_type)event_name,d5.event_date,d5.event_status,d5.data_string,"
                    + "d5.d5_time_stamp,rownum from d5_data d5,events e where d5.cdfid in (select cdfid from  "
                    + "meter_data_time_stamp where meterid=?) and d5.event_type=e.event_code order by d5.d5_time_stamp desc)where rownum<=10");
            }
            pstmt.setString(1, meter_ids_arr[i]);
            rs = pstmt.executeQuery();
            int data_available_flag = 0;
			String[] data_string_arr = null;
            while(rs.next())
            {
				if(!rs.getString("event_type").equals("13"))
	                data_string_arr = rs.getString("data_string").split(",");
                out.println("<tr>");
                out.println("<td align='left' width='60px'>"+rs.getString("event_date").substring(0, 10) +"</td>");
                out.println("<td align='left' width='60px'>"+rs.getString("event_date").substring(10) +"</td>");
               // out.println("<td>"+rs.getString("e.event_type") +"</td>");//mysql
                out.println("<td>"+rs.getString(2) +"</td>");
                String status=(rs.getString("event_status").contains("restored"))? "Restored":"Occured";
                out.println("<td>"+ status +"</td>");
                //if(rs.getString("d5.event_type").equals("13"))//mysql
                if(rs.getString("event_type").equals("13"))
                        out.println("<td colspan='"+param_names.length+"' align='right'> &nbsp; </td>");
                else
                for(int j=0;j<data_string_arr.length;j++)
                {
                    if(j==9)
                     out.println("<td align='right'>"+twoDecFormat.format(Double.parseDouble(data_string_arr[j]))+"</td>");
                    else
                     out.println("<td align='right'>"+twoDecFormat.format(Double.parseDouble(data_string_arr[j]))+"</td>");
                }
                out.println("<tr>");
                data_available_flag = 1;
            }
            if(data_available_flag == 0)
            {
                out.println("<tr><td  colspan='12' align='center'>Data Not Available.</td></tr>");
            }
            %>
        </tbody>
    </table>
    <%
}

}
catch(Exception e)
           {
    e.printStackTrace();
}
finally{
    con.close();
}
%>


 