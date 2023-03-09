<%@ page session="false" %>
<%@ include file="getConnection.jsp"%>
<%!
  PreparedStatement pstmt = null;
  ResultSet rs = null;
%>
<%
    try{
        String feederid = request.getParameter("emp_id").toString();
        int option = Integer.parseInt(request.getParameter("opt"));
        String data="";

            if(option==0)
            {
                //acutual code to fetech ht consumers
                /*
                pstmt = con.prepareStatement("select m.meterid,m.meter_serial_no,f.feederid,f.feedername,f.dcuid,f.classvoltage from meter m,feeder f where m.meterid ='"+feederid+"'");
                rs = pstmt.executeQuery();
                while(rs.next())
                    data = rs.getString("meterid")+"_"+rs.getString("meter_serial_no")+"-"+rs.getString("feedername")+":"+data;
 *
 *              */
                //test code it get dtrs only
                pstmt = con.prepareStatement("select m.meterid,m.meter_serial_no,d.dtrid,d.dtrname,d.feederid,d.mobileno from meter m,dtr d where m.meterid = d.meter_id and m.meterid in (select meterid from dtr where feederid='"+feederid+"') order by d.dtrname desc");
                rs = pstmt.executeQuery();
                while(rs.next())
                    data = rs.getString("meterid")+"_"+rs.getString("meter_serial_no")+"-"+rs.getString("dtrname")+":"+data;
            }

            if(option==1)
            {
                pstmt = con.prepareStatement("select m.meterid,m.meter_serial_no,d.dtrid,d.dtrname,d.feederid,d.mobileno from meter m,dtr d where m.meterid = d.meter_id and m.meterid in (select meterid from dtr where feederid='"+feederid+"') order by d.dtrname desc");
                rs = pstmt.executeQuery();
                while(rs.next())
                    data = rs.getString("meterid")+"_"+rs.getString("meter_serial_no")+"-"+rs.getString("dtrname")+":"+data;
            }

            if(option==2)
            {
                //acutual code to fetech ht consumers
                /*
                pstmt = con.prepareStatement("select m.meterid,m.meter_serial_no,ht.consumerid,ht.consumername,ht.feederid,ht.mobileno from meter m,ht_consumer ht where m.meterid in (select meterid from ht_consumer where feederid='"+feederid+"')");
                rs = pstmt.executeQuery();
                while(rs.next())
                    data = rs.getString("meterid")+"_"+rs.getString("meter_serial_no")+"-"+rs.getString("consumername")+":"+data;
 *              */

                //test code it get dtrs only
                pstmt = con.prepareStatement("select m.meterid,m.meter_serial_no,d.dtrid,d.dtrname,d.feederid,d.mobileno from meter m,dtr d where m.meterid = d.meter_id and m.meterid in (select meterid from dtr where feederid='"+feederid+"') order by d.dtrname desc");
                rs = pstmt.executeQuery();
                while(rs.next())
                    data = rs.getString("meterid")+"_"+rs.getString("meter_serial_no")+"-"+rs.getString("dtrname")+":"+data;
            }
        out.print(data);
    }catch(Exception e)
    {
        e.printStackTrace();
    }
    finally{
      con.close();
    }
%>