<%@ page session="false" %>
<%@page import="in.amitech.db.DBUtil"%>
<%@page import="java.sql.*"%>
<%@page import="java.lang.*"%>
<%!
 Statement st,stmt = null;
  ResultSet rs,rs1 = null;
  Connection con,con1=null;
%>
<%
    try{
        String discom,zone,circle,division,subdiv,section,subs,feeder=" ";
        String sql="";
        String sql1="";
        int count=0;
        String oraclevalues=" ";
        String mysqlvalues="";
        String currentDate=null;
        discom=request.getParameter("discom").trim();
       
        zone=request.getParameter("zone").trim();
        
        circle=request.getParameter("circle").trim();
        
        division=request.getParameter("division").trim();
        
        subdiv=request.getParameter("subdiv").trim();
        
        section=request.getParameter("section").trim();
        
        subs=request.getParameter("substation").trim();
        
        feeder=request.getParameter("feeder").trim();
        currentDate=request.getParameter("date").trim();
        
        //to get the meters working in current date from mysql
                Class.forName("com.mysql.jdbc.Driver");
		con1=DriverManager.getConnection("jdbc:mysql://122.169.243.224:3306/mdas","root","system");

                sql1="select meter_serial_no,count(meter_serial_no) from mdas.FTP_FILES_INFO where " +
                        "substr(file_insert_time,1,10)=str_to_date('"+currentDate+"','%d/%m/%Y')group by meter_serial_no order by" +
                        " meter_serial_no";
                stmt=con1.createStatement();
                ResultSet  rs1=stmt.executeQuery(sql1);
              while(rs1.next())
                    {
                           mysqlvalues=mysqlvalues+rs1.getString(1)+"_"+rs1.getString(2)+";";
                             
                    }
                System.out.println("mysql"+mysqlvalues);
                //if discom is selected
        if(Integer.parseInt(discom)!=0 &&Integer.parseInt(zone)==0)
            {
             sql="select meter_serial_no from meter where dtrid in(select dtrid from dtr where feederid in" +
                     "(select feederid from feeder where substationid in(select substationid from substation where sectionid in" +
                     "(select sectionid from section where subdivid in(select subdivid from subdivision where divisionid in" +
                     "(select divisionid from division where circleid in(select circleid from circle where zoneid in" +
                     "(select zoneid from zone where discom_id="+discom+")))))))) order by meter_serial_no asc";
             
           }
        //if zone is selected
               else if(Integer.parseInt(zone)!=0 && Integer.parseInt(circle)==0)
             {
                    sql="select meter_serial_no from meter where dtrid in(select dtrid from dtr where feederid in" +
                            "(select feederid from feeder where substationid in(select substationid from substation where sectionid in" +
                            "(select sectionid from section where subdivid in(select subdivid from subdivision where divisionid in" +
                            "(select divisionid from division where circleid in(select circleid from circle where zoneid="+zone+"))))))) " +
                            "order by meter_serial_no asc";
             }
                //if circle is selected
                else if(Integer.parseInt(circle)!=0 && Integer.parseInt(division)==0)
             {
                    sql="select meter_serial_no from meter where dtrid in(select dtrid from dtr where feederid in" +
                            "(select feederid from feeder where substationid in(select substationid from substation where sectionid in" +
                            "(select sectionid from section where subdivid in(select subdivid from subdivision where divisionid in" +
                            "(select divisionid from division where circleid="+circle+")))))) order by meter_serial_no asc";
             }
         //if division is selected
           else if(Integer.parseInt(division)!=0 && Integer.parseInt(subdiv)==0)
             {
                    sql="select meter_serial_no from meter where dtrid in(select dtrid from dtr where feederid in" +
                            "(select feederid from feeder where substationid in(select substationid from substation where sectionid in" +
                            "(select sectionid from section where subdivid in(select subdivid from subdivision where divisionid="+division+")))))" +
                            " order by meter_serial_no asc";
             }
          //if subdivision is selected
                else if(Integer.parseInt(subdiv)!=0 &&Integer.parseInt(section)==0)
             {
                    sql="select meter_serial_no from meter where dtrid in(select dtrid from dtr where feederid in" +
                            "(select feederid from feeder where substationid in(select substationid from substation where sectionid in" +
                            "(select sectionid from section where subdivid ="+subdiv+")))) order by meter_serial_no asc";
             }
          //if section is selected
                else if(Integer.parseInt(section)!=0 && Integer.parseInt(subs)==0)
             {
                    sql="select meter_serial_no from meter where dtrid in(select dtrid from dtr where feederid in" +
                            "(select feederid from feeder where substationid in(select substationid from substation where" +
                            " sectionid ="+section+"))) order by meter_serial_no asc";
             }
                //if substation is selected
              else  if(Integer.parseInt(subs)!=0 && Integer.parseInt(feeder)==0)
             {
                    sql="select meter_serial_no from meter where dtrid in(select dtrid from dtr where feederid in" +
                            "(select feederid from feeder where substationid ="+subs+")) order by meter_serial_no asc";
             }
            //if feeder is selected
                  else if(Integer.parseInt(feeder)!=0)
             {
                    sql="select meter_serial_no from meter where dtrid in(select dtrid from dtr where feederid ="+feeder+") order by " +
                            "meter_serial_no asc";
             }
                //getting the meter_serial_nos from oracle db based on selected hierarchy
        con = new DBUtil().getConnection();
        st=con.createStatement();
        rs=st.executeQuery(sql);
            while(rs.next())
                 {
                  oraclevalues=oraclevalues+","+rs.getString("meter_serial_no");
                  
                 }
             System.out.println("oracle"+oraclevalues);
              //comparing the mysql meter_serial_nos with oracle meter_serial_nos
             String myvalues[]=mysqlvalues.split(";");
             
             String oravalues[]=oraclevalues.split(",");
             System.out.println("mylength="+myvalues.length);
             System.out.println("ora length="+oravalues.length);
             
             out.println(" <table><tr><td><b>Meter_serial_no</b></td><td><b>Count</b></td>");
             for(int i=0;i<myvalues.length;i++)
                 {
                 
                     for(int j=0;j<oravalues.length;j++)
                         { 
                         
                              if(myvalues[i].substring(0,myvalues[i].indexOf("_")).equals(oravalues[j]))
                              {
                                  System.out.println("meter_serial_no"+myvalues[i]);
                                  out.println("<tr><td>"+myvalues[i].substring(0,myvalues[i].indexOf("_"))+"</td>");
                                  out.println("<td>"+myvalues[i].substring(myvalues[i].indexOf("_")+1) +"</td></tr>");
                                  count++;
                              }
                           
                         }
                     

                 }
             out.println("<tr><td>Total No of Meters "+count+"</td></tr>");
              out.println("</table>");
        
          }catch(Exception e)
    {
        e.printStackTrace();
    }
    finally{
        con.close();
        con1.close();
    }
%>