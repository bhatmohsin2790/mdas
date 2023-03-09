<%@page import="in.amitech.db.DBUtil"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.*"%>
<%
try{
            Connection con = null;
            PreparedStatement pst = null;
            ResultSet rs=null;
            String sql = null;
            int flag=0;
            String feederId  = null;
           String dtrCapacity,dtrid=null;
            String dtrname,modemno,mobileno,meterno,metermake,meterlocation=null;
            feederId=request.getParameter("feederid");
            dtrname=request.getParameter("dtrname");
            dtrCapacity=request.getParameter("dtrcapacity");
            modemno=request.getParameter("modemSlNo");
            mobileno=request.getParameter("mobile");
            meterno=request.getParameter("meterSlNo");
            metermake=request.getParameter("metermake");
            meterlocation=request.getParameter("meterlocation");
         con = new DBUtil().getConnection();
System.out.println("feederid"+feederId+"dtr"+dtrname+"capacity"+dtrCapacity+"modem"+modemno+"mobile"+mobileno+"meter"+meterno+"make"+metermake+"location"+meterlocation+"");
    
             //getting dtr id to map into meter table
              pst=con.prepareStatement("select dtrid from dtr where dtrname='"+dtrname+"'");
     rs=pst.executeQuery();
     if(rs.next()){
         dtrid=rs.getString("dtrid");
         System.out.println("dtr is"+dtrid);
         }
    
                    //updating meter with new info entered
                    pst=con.prepareStatement("update meter set metermake="+metermake+",meterlocation="+meterlocation+",modem_serial_no='"+modemno+"',dtrid="+dtrid+" where meter_serial_no='"+meterno+"'");
             if(pst.executeUpdate()>0)
                 {
                     out.println("meter is already exist and these details updated successfully");
                  }
   
}

catch(Exception e)
        {
    e.printStackTrace();
    }







%>