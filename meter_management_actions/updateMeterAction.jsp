<%@ page session="false" %>
<%@page import="java.sql.*" %>
<%@page import="in.amitech.db.DBUtil"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>

<%
        try{
            String  mf=null;
            String meterCTR=null;
            String meterPTR=null;
            String adoptedCTR=null;
            String adoptedPTR=null;
            String  meterType=null;
            String accuracy=null;
            String modem_Serial_No=null;
            String meter_serial_no=null;
            String locationCode="",consumerId="";
            double actr=0;
           String meterid = request.getParameter("meterid").trim();
           String meterMake = request.getParameter("meterMake").trim();
           String meterLoc = request.getParameter("meterLoc").trim();
           meterCTR = request.getParameter("meterCTR").trim();
           meterPTR = request.getParameter("meterPTR").trim();
           adoptedCTR = request.getParameter("adoptedCTR").trim();
           adoptedPTR = request.getParameter("adoptedPTR").trim();
           meterType = request.getParameter("meterType").trim();
           accuracy = request.getParameter("accuracy").trim();
           mf = request.getParameter("mf").trim();
           modem_Serial_No = request.getParameter("modem_Serial_No").trim();
           locationCode = request.getParameter("locationCode");
           consumerId = request.getParameter("consumerId");
            try{
             // mf=""+(Float.parseFloat(meterPTR) * Float.parseFloat(meterCTR))/(Float.parseFloat(adoptedCTR)*Float.parseFloat(adoptedPTR));
                if(adoptedCTR.contains("/")){	
                    String numerator = adoptedCTR.substring(0,adoptedCTR.indexOf("/"));
                    String denominator = adoptedCTR.substring(adoptedCTR.indexOf("/")+1);
                    actr = Double.valueOf(numerator)/Double.valueOf(denominator);
                    }else{
                    actr = Double.parseDouble(adoptedCTR);//comm ctr
                    }
                  mf=""+(actr * Float.parseFloat(adoptedPTR))/(Float.parseFloat(meterPTR)*Float.parseFloat(meterCTR));
                  }catch(Exception e){}
              
               if(mf=="")
                       mf="1.0";
              
            Connection con = null;
            String data="";
          
          
            Statement stmt=null;
           con = new DBUtil().getConnection();
           stmt=con.createStatement();
            ResultSet rs=stmt.executeQuery("select meter_serial_no from meter where meterid="+meterid);
            if(rs.next())
                meter_serial_no=rs.getString(1);
            System.out.println("meter serial no"+meter_serial_no);
           String sql="update meter set metermake="+meterMake+",meterlocation="+meterLoc+",";
                   if(modem_Serial_No.equals(""))
                     sql=sql + "modem_serial_no='"+meter_serial_no+"',";
           else
                sql=sql + "modem_serial_no='"+modem_Serial_No+"',";
           
           sql=sql + "meter_ctr='"+meterCTR+"',meter_ptr='"+meterPTR+"',"
                   + "adopted_ctr='"+adoptedCTR+"',adopted_ptr='"+adoptedPTR+"',meter_type='"+meterType+"',mf='"+mf+"',accuracy='"+accuracy+"',location_code='"+locationCode+"',consumerid='"+consumerId+"' where meterid="+meterid+"";                
                  
           System.out.println("query is"+sql);
           
           if(stmt.executeUpdate(sql)>0)
            {
               out.println("meter  updated successfully");
               System.out.println("meter  updated successfully");
           }
           else
               {
               out.println("failed try again");
           }

           
           }
        catch(Exception e)
                {
            e.printStackTrace();
            }
%>