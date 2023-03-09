<%@ page session="false" %><%@ include file="getConnection.jsp"%>
<%!    PreparedStatement pstmt = null;
    ResultSet rs = null;
    int counter=1;
%>
<%
            try {
                
                int feederid = Integer.parseInt(request.getParameter("emp_id"));
                System.out.println("feederid  "+feederid);
                int option = Integer.parseInt(request.getParameter("opt"));
                System.out.println("option "+option);
                String data = "";

                if (option == 0) {                   
                    //feeder
                    String sql = "select m.meterid,m.meter_serial_no,f.feederid,f.feedername,f.dcuid,f.classvoltage from meter m,feeder f where m.feederid=f.feederid "
                            + "and m.feederid in  (select feederid from feeder where substationid=?) order by f.feedername";
                    System.out.println("option 0 sql "+sql);
                    pstmt = con.prepareStatement(sql);
                    pstmt.setInt(1, feederid);
                    rs = pstmt.executeQuery();
                    while (rs.next()) {
                        data = rs.getString("meterid") + "_" + rs.getString("meter_serial_no") + "-" + rs.getString("feedername") + ":" + data;
                    }
                    //System.out.println("data string is -->"+data);
                }
                if (option == 1) {
                    //dtr
                    counter=1;
                    String sql = "select m.meterid,m.meter_serial_no,d.dtrid,d.dtrname,d.feederid,d.mobileno from meter m,dtr d where m.dtrid = d.dtrid "
                            + "and m.dtrid in (select dtrid from dtr where feederid=?) order by d.dtrname ";
                    pstmt = con.prepareStatement(sql);
                    pstmt.setInt(1, feederid);
                    System.out.println("option 1 sql----------> "+sql);
                    rs = pstmt.executeQuery();
                    
                    while (rs.next()) {
                        
                        data = data+rs.getString("meterid") + "_" + rs.getString("meter_serial_no") + "-" + counter+"-"+ rs.getString("dtrname") + ":";
                    counter++;
                    }
                }

                if (option == 2) {
                    //ht consumers
                     counter=1;
                    String sql = "select m.meterid,m.meter_serial_no,ht.consumerid,ht.consumername,ht.feederid,ht.mobileno from meter m,ht_consumer ht where m.htconsumerid=ht.consumerid "
                            + "and m.htconsumerid in (select consumerid from ht_consumer where feederid=?) order by ht.consumername";
                    pstmt = con.prepareStatement(sql);
                    pstmt.setInt(1, feederid);
                    rs = pstmt.executeQuery();
                    while (rs.next()) {
                        data = data+ rs.getString("meterid") + "_" + rs.getString("meter_serial_no") +  "-" + counter+"-" + rs.getString("consumername") + ":" ;
                    counter++;
                    }
                }//end if

                if (option == 3) {
                    //ht consumers
                    String sql = "select m.meterid,m.meter_serial_no,ht.consumerid,ht.consumername,ht.feederid,ht.mobileno from meter m,ht_consumer ht where m.htconsumerid=ht.consumerid "
                            + "and m.htconsumerid in (select consumerid from ht_consumer where feederid=?) order by ht.consumername desc";
                    pstmt = con.prepareStatement(sql);
                    pstmt.setInt(1, feederid);
                    rs = pstmt.executeQuery();
                    while (rs.next()) {
                        data = rs.getString("meterid") + "_" + rs.getString("meter_serial_no") + "-" + rs.getString("consumername") + ":" + data;
                    }//end while
                }//end if
               
                out.print(data);
                
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                con.close();
            }
%>