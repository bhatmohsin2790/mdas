<%@page import="java.sql.Connection"%>
<%@page import="in.amitech.db.DBUtil"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<table id="feederstatus"  align="left" style="border:1px solid #ddd;">
    <tr bgcolor="#ddd"   >
        <td width="219px" style="height:15px"  >FeederName</td>
        <td width="100px" style="height:15px">Status</td>
        <td width="200px" style="height:15px">Date&Time</td>
        <td width="100px" style="height:15px" >History</td>
    </tr>
    <%
               String ssId=request.getParameter("ss_id").trim();
               Connection con = new DBUtil().getConnection();
                PreparedStatement pstmt = null;
                ResultSet rs = null;
                String feederMeters="";
                try {
                    // getting feeder meter serial numbers from meter table
                         //  uncomment up to feederMeters when feederMeters is mapped in the database ***
                       //            pstmt = con.prepareStatement("select meter_serial_no from meter where feederid in(select feederid from feeder where substationid="+ssId+")");
                        //           rs = pstmt.executeQuery();
                        //           int flag=0;
                          //          while (rs.next()) {
                            //        feederMeters=feederMeters+","+rs.getString(1);
                           //          flag=1;
                           //            }
                            //        if(flag==0){out.println(" No feeder meters in this substation");}
                              //      System.out.println("meters ="+feederMeters.substring(1));
                                    feederMeters="TNU00356";
                     //getting the feeder status from feeder_alerts table
                                    pstmt=con.prepareStatement("select feeder_name,feeder_state,to_char(OCCR_TIMESTAMP,'dd/mm/yyyy hh:mi:ss am') from" +
                                            " feeder_alerts where meter_serial_no in('"+feederMeters+"',0) and OCCR_TIMESTAMP in(select max(OCCR_TIMESTAMP) " +
                                            "from feeder_alerts where meter_serial_no in ('"+feederMeters+"',0))");
                                    rs = pstmt.executeQuery();
                                    while(rs.next())
                                        {
                                        %>
                                        <tr>
                                            <td align="center"><%= rs.getString("feeder_name")%></td>
                                            <% if(rs.getString("feeder_state").equalsIgnoreCase("FEEDARTRIPPED")||rs.getString("feeder_state").equalsIgnoreCase("FEEDAROFF"))
                                                                                       { %>
                                            <td align="center"><img src="images/red_1.jpeg"/></td>
                                            <%} if(rs.getString("feeder_state").equalsIgnoreCase("FEEDARRESTORED")||rs.getString("feeder_state").equalsIgnoreCase("FEEDARON"))
                                                                                          {%>
                                            <td align="center"><img src="images/green.png"/></td>
                                            <% }%>
                                            <td align="center"><%= rs.getString(3)%></td>
                                            <td align="center"><input type="button" style="width:65px;height:20px"value="view"/></td>
                                        </tr>

                       <%  }
                         }
                catch(Exception e){
                    out.println(e);
                }
                finally{
                    con.close();
                }
    %>

</table>