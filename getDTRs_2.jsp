<%@ page session="false" %>
<%@ include file="getConnection.jsp"%>
<%!
  PreparedStatement pstmt = null;
  ResultSet rs = null;
%>
<%
    try{
        System.out.println("dtr");
        String substationid=request.getParameter("substation");
        System.out.println("substationid  "+substationid);
        String feederid = request.getParameter("emp_id").toString();
        System.out.println("feeder is"+feederid);
        int option = Integer.parseInt(request.getParameter("opt"));
        System.out.println("option   "+option);
        String data="";

            if(option==0)
            {

                pstmt = con.prepareStatement("select m.meterid,m.meter_serial_no from meter m,feeder f where m.feederid ='"+feederid+"'and m.feederid=f.feederid");
                rs = pstmt.executeQuery();
                while(rs.next())
                    data = rs.getString("meterid")+"_"+rs.getString("meter_serial_no")+":"+data;
            }

            if(option==1)
            {
                pstmt = con.prepareStatement("select m.meterid,m.meter_serial_no from meter m,dtr d where m.dtrid = d.dtrid and d.dtrid in (select dtrid from dtr where feederid='"+feederid+"')");
                rs = pstmt.executeQuery();
                while(rs.next())
                    
                    data = rs.getString("meterid")+"_"+rs.getString("meter_serial_no")+":"+data;
            }

            if(option==2)
            {
                pstmt = con.prepareStatement("select m.meterid,m.meter_serial_no from meter m,ht_consumer ht where m.htconsumerid=ht.consumerid and ht.consumerid in (select consumerid from ht_consumer where feederid='"+feederid+"')");
                rs = pstmt.executeQuery();
                while(rs.next())
                    data = rs.getString("meterid")+"_"+rs.getString("meter_serial_no")+":"+data;
            }
        out.print(data);
        System.out.println("data is"+data);
    }catch(Exception e)
    {
        e.printStackTrace();
    }
    finally{
      con.close();
    }
%>