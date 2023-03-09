<%@ page session="false" %>
<%@page import="in.amitech.db.DBUtil"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.*"%>
<%@page import="java.text.*"%>
<%
            Connection con = null;
            Statement st = null;
            String sql = null;
           int count=0;
          double SAIFI=0;
            String meterId=request.getParameter("meter_id").trim();
            String sdate=request.getParameter("sdate");
            String edate=request.getParameter("edate").trim();
            System.out.println("before"+sdate);

             DateFormat df = new SimpleDateFormat("dd/MM/yyyy");

             java.util.Date fdate = (java.util.Date)df.parse(sdate);
             java.util.Date tdate = (java.util.Date)df.parse(edate);
             DateFormat sdf = new SimpleDateFormat("dd-MMM-yy");
             String fromdate=sdf.format(fdate);
             String todate=sdf.format(tdate);
             System.out.println("after"+fromdate);
             //to know number of days between selected days
             int datediff=(int)((tdate.getTime()-fdate.getTime())/(1000*60*60*24));
             System.out.println("no of days between"+datediff);
             con = new DBUtil().getConnection();
              sql="select count(*) from modem_alerts where alert_desc='AMR Power Failed' and meter_id="+meterId+" and " +
                      "to_date(substr(alert_generated_date,1,9),'DD-Mon-YY') between to_date('"+fromdate+"','DD-MON-YY') " +
                      "and to_date('"+todate+"','DD-MON-YY')";
              System.out.println("sql is"+sql);
              st=con.createStatement();
              ResultSet rs=st.executeQuery(sql);
              if(rs.next())
                  {
                  count=rs.getInt(1);
                  }
              else
                  out.println("No power fail in these days");
              SAIFI=count/(double)datediff;
                  con.close();
      
  %>
  <h3 align="center" style="padding-top:140px">SAIFI value :<%=SAIFI  %> (times per day)</h3>




      