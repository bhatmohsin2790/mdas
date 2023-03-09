<%@ page session="false" %>
<%@ include file="report_header.jsp"%>
<%@page import="in.amitech.db.DBUtil"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%!     PreparedStatement pstmt = null;
    ResultSet rs = null;

%>
<%
      try{
           String meter_id = "", sql = null,data="";
           float mf=0;
                String[] data_string2=new String[0];
                String[] data_string=new String[0];
                 String lsdate=request.getParameter("lsdate");
                 String ledate=request.getParameter("ledate");
                 
                if (request.getParameter("meter_id") == null || request.getParameter("meter_id") == "") {
                    meter_id = (String) session.getAttribute("meter_id");
                } else {
                    meter_id = request.getParameter("meter_id");
                }
                session.setAttribute("meter_id", meter_id);
                Connection con = new DBUtil().getConnection();
                 pstmt = con.prepareStatement("select no_of_params,d4_params from metermake where metermakeid=(select metermake from meter where meterid=" + meter_id + ")");
                        rs = pstmt.executeQuery();

                        while (rs.next()) {
                             data_string2 = rs.getString("d4_params").split(",");
                             }
                         String meter_sl_no = "";
                    pstmt = con.prepareStatement("select meter_serial_no from meter where meterid=" + meter_id);
                    rs = pstmt.executeQuery();
                    if (rs.next()) {
                        meter_sl_no = rs.getString("meter_serial_no");
                    }
                    session.setAttribute("meter_sl_no", meter_sl_no);
                     pstmt = con.prepareStatement("select mf from meter where meterid=" + meter_id);
                    rs = pstmt.executeQuery();
                    if (rs.next()) {
                        mf = Integer.parseInt((rs.getString("mf")));
                    }
System.out.println("multiplication factor-------"+mf);
%>
 <%
    if(!lsdate.equals("") && !ledate.equals(""))
                      {
        //------------------------------
                        int MILLIS_IN_DAY = 1000 * 60 * 60 * 24;
                        SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
                         java.util.Date  edate ;

                            edate = (java.util.Date)dateFormat.parse(ledate);

                               Calendar cal=Calendar.getInstance();
                               cal.setTime(edate);
                               cal.add(cal.DATE,1);
                               String afterDate=cal.get(cal.DATE)+"/"+(cal.get(cal.MONTH)+1)+"/"+cal.get(cal.YEAR);
                               System.out.println(" after one day is ----"+afterDate);
                           // String nextDate =dateFormat.format(cal.getTime(edate)+ MILLIS_IN_DAY);
                 //------------------------------
    sql = "select distinct substr(d4_date,1,10) d4_date, substr(data_string,1,instr(data_string, ',', 1, 1)-1) PARAM1," +
            " substr(data_string,instr(data_string, ',', 1, 1)+1,instr(data_string, ',', 1, 2)-instr(data_string, ',', 1, 1)-1) PARAM2," +
            " substr(data_string,instr(data_string, ',', 1, 2)+1,instr(data_string, ',', 1, 3)-instr(data_string, ',', 1, 2)-1) PARAM3," +
            " substr(data_string,instr(data_string, ',', 1, 3)+1,instr(data_string, ',', 1, 4)-instr(data_string, ',', 1, 3)-1) PARAM4," +
            " substr(data_string,instr(data_string, ',', 1, 4)+1,instr(data_string, ',', 1, 5)-instr(data_string, ',', 1, 4)-1) PARAM5," +
            " substr(data_string,instr(data_string, ',', 1, 5)+1,instr(data_string, ',', 1, 6)-instr(data_string, ',', 1, 5)-1) PARAM6," +
            " TIME_DELAY from d4_data d4 where d4.cdfid in (select cdfid from meter_data_time_stamp where meterid=?)and to_date(d4_date,'dd/mm/yyyy hh24:mi:ss')>to_date('"+lsdate+" 00:00:00','dd/mm/yyyy hh24:mi:ss') and to_date(d4_date,'dd/mm/yyyy hh24:mi:ss')<=to_date('"+afterDate+" 00:00:00','dd/mm/yyyy hh24:mi:ss') and data_string is NOT NULL order by to_timestamp(d4_date,'dd/mm/yyyy hh24:mi:ss'),TIME_DELAY  ";
    }
                 else
                     {
                sql="select distinct substr(d4_date,1,10) d4_date, substr(data_string,1,instr(data_string, ',', 1, 1)-1)" +
                        " PARAM1, substr(data_string,instr(data_string, ',', 1, 1)+1,instr(data_string, ',', 1, 2)-instr" +
                        "(data_string, ',', 1, 1)-1) PARAM2, substr(data_string,instr(data_string, ',', 1, 2)+1,instr(data_string, ',', 1, 3)-instr(data_string, ',', 1, 2)-1)" +
                        " PARAM3, substr(data_string,instr(data_string, ',', 1, 3)+1,instr(data_string, ',', 1, 4)-instr(data_string, ',', 1, 3)-1) PARAM4," +
                        " substr(data_string,instr(data_string, ',', 1, 4)+1,instr(data_string, ',', 1, 5)-instr(data_string, ',', 1, 4)-1) PARAM5, " +
                        "substr(data_string,instr(data_string, ',', 1, 5)+1,instr(data_string, ',', 1, 6)-instr(data_string, ',', 1, 5)-1) PARAM6," +
                        " TIME_DELAY from d4_data d4 where d4.cdfid in (select cdfid from meter_data_time_stamp where meterid=?)and  data_string is NOT NULL " +
                        "order by to_timestamp(d4_date,'dd/mm/yyyy hh24:mi:ss'),TIME_DELAY";
                 }
    System.out.println(sql);
    pstmt = con.prepareStatement(sql);
pstmt.setString(1,meter_id);
rs = pstmt.executeQuery();
    String[] dates = new String[100];
    String[] param1 = new String[100];
    String[] param2 = new String[100];
    String[] param3 = new String[100];
    String[] param4 = new String[100];
    String[] param5 = new String[100];
    String[] param6 = new String[100];
%>

<% data=data+"<table>";%>
<%
int k = 0,kk=0;
int dates_i = 0;
while(rs.next())
    {
        if(kk==0)
            dates[dates_i] = rs.getString("d4_date");
        else
            {
                if(dates[dates_i].equals(rs.getString("d4_date")))
                    {}
                    
                else
                    {
                        for(int j=0;j<6;j++)
                            {
                    %>
                 <% data=data+"<tr>" ;%>
                <% data=data+"<td>";%> <% data=data+meter_sl_no; %><% data=data+"</td>"; %>    
                <% data=data+"<td>";%> <% data=data+dates[dates_i]; %><% data=data+"</td>"; %>  
                <% data=data+"<td>";%><% data=data+data_string2[j]; %><% data=data+"</td>"; %> 
                        <%
                         for(int j2=0;j2<k;j2++)
                            {
                                                %>
                 <% data=data+"<td>";%>
                     <%
                     if(j==0)  data=data+(Float.parseFloat(param1[j2])*mf);
                     if(j==1) data=data+(Float.parseFloat(param2[j2])*mf);
                     if(j==2) data=data+(Float.parseFloat(param3[j2])*mf);
                     if(j==3) data=data+(Float.parseFloat(param4[j2])*mf);
                     if(j==4) data=data+(Float.parseFloat(param5[j2])*mf);
                     if(j==5) data=data+(Float.parseFloat(param6[j2])*mf);
                                    %><% data=data+"</td>"; %>
                        <% } %>

                    
                    <%
                    }
                    k = 0;
                    dates_i++;
                    dates[dates_i] = rs.getString("d4_date");
                    }
            }
        param1[k] = rs.getString("PARAM1");
        param2[k] = rs.getString("PARAM2");
        param3[k] = rs.getString("PARAM3");
        param4[k] = rs.getString("PARAM4");
        param5[k] = rs.getString("PARAM5");
        param6[k] = rs.getString("PARAM6");
        k++;kk++;
    }
//---------------------
for(int j=0;j<6;j++)
                            {
    
        %>
        <% data=data+"<td>";%>
                     <%

                    if(j==0)  data=data+(Float.parseFloat(param1[0])*mf);
                     if(j==1) data=data+(Float.parseFloat(param2[0])*mf);
                     if(j==2) data=data+(Float.parseFloat(param3[0])*mf);
                     if(j==3) data=data+(Float.parseFloat(param4[0])*mf);
                     if(j==4) data=data+(Float.parseFloat(param5[0])*mf);
                     if(j==5) data=data+(Float.parseFloat(param6[0])*mf);
                                    %><% data=data+"</td>"; %>
                        
                       
    
                  <% }  %>
                   <% data=data+"</tr>" ;%>
//---------------------
                  <% for(int j=0;j<6;j++)
                            {


        %>
                    <% data=data+"<tr>" ;%>
                        <% data=data+"<td>";%><% data=data+meter_sl_no; %><% data=data+"</td>"; %>
                        <% data=data+"<td>";%><% data=data+dates[dates_i]; %><% data=data+"</td>"; %>
                        <% data=data+"<td>";%><% data=data+data_string2[j]; %><% data=data+"</td>"; %>
                        <%

                         for(int j2=0;j2<k;j2++)
                            {
                                                %>
                 <% data=data+"<td>";%>
                     <%

                    if(j==0)  data=data+(Float.parseFloat(param1[j2])*mf);
                     if(j==1) data=data+(Float.parseFloat(param2[j2])*mf);
                     if(j==2) data=data+(Float.parseFloat(param3[j2])*mf);
                     if(j==3) data=data+(Float.parseFloat(param4[j2])*mf);
                     if(j==4) data=data+(Float.parseFloat(param5[j2])*mf);
                     if(j==5) data=data+(Float.parseFloat(param6[j2])*mf);
                                    %><% data=data+"</td>"; %>
                        <% } %>

                    <% data=data+"</tr>" ;%>
                    <%
                    }

%>
<% data=data+"</table>";%>


<%
//String data = request.getParameter("data");
String meterid=request.getParameter("meterid");
//System.out.println(meterid);
//System.out.println("data is ="+data);
java.io.File f = new java.io.File("/transco_reports");
f.mkdirs();
f=new java.io.File("/transco_reports/Ls_"+meterid+".xls");


java.io.FileOutputStream fos = new java.io.FileOutputStream(f);
fos.write(data.getBytes());
fos.close();
%>
<%

out.println("Load Survay Data Exported Successfully to :"+f.getAbsolutePath());
System.out.println("Load Survay Data Exported Successfully to :"+f.getAbsolutePath());
%>
<% }
      catch(Exception e)
              {
          
          e.printStackTrace();
          }
      %>