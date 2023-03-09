<%@ page session="false" %>
<%@page import="in.amitech.db.DBUtil"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%
            Connection con = null;
            PreparedStatement pst = null;
            String sql = null;
           
            String metersno = null;
            String meterMake = null;
            String meterLoc = null;
            String meterCTR = null;
            String meterPTR = null;
            String adoptedCTR = null;
            String adoptedPTR = null;
            String meter_status = null;
            String metering_points = null;
            String meterType = null;
            String accuracy = null;
            String mf = null;
            String locationCode="",consumerId="";
            double actr=0;
            String modem_Serial_No = null;
            
            try {
                
                metersno = request.getParameter("metersno").trim();
                meterMake = request.getParameter("meterMake").trim();
                meterLoc = request.getParameter("meterLoc").trim();
                meterCTR = request.getParameter("meterCTR").trim();
                meterPTR = request.getParameter("meterPTR").trim();
                adoptedCTR = request.getParameter("adoptedCTR").trim();
                adoptedPTR = request.getParameter("adoptedPTR").trim();
//                meter_status = request.getParameter("meter_status").trim();                
//                metering_points = request.getParameter("metering_points").trim();                
                meterType = request.getParameter("meterType").trim();                
                accuracy = request.getParameter("accuracy").trim();
                mf = request.getParameter("mf").trim();
                modem_Serial_No = request.getParameter("modem_Serial_No").trim();
                locationCode=request.getParameter("locationCode");
                consumerId=request.getParameter("consumerId");
               System.out.println(metersno);
                if ( metersno.equals("") || meterMake.equals("") || meterLoc.equals(""))
                {
                    out.println("Meter Serial number Should not be Empty");
                } 
                else
                    {
                    con = new DBUtil().getConnection();
                    System.out.println("coneectionection establisthed");
                     if (DBUtil.getTargetDB().equals("oracle")) {
                    sql = "insert into meter(meterid,meter_serial_no,metermake,meterlocation,"
                            + "meter_ctr,meter_ptr,adopted_ctr,adopted_ptr,location_code,"
                            + "consumerid,accuracy,mf,meter_type,modem_serial_no) "
                            + "values(meter_seq.nextval,?,?,?,?,?,?,?,?,?,?,?,?,?)";
                    } else if (DBUtil.getTargetDB().equals("mysql")) {
                         sql = "insert into meter(meter_serial_no,metermake,meterlocation,"
                            + "meter_ctr,meter_ptr,adopted_ctr,adopted_ptr,location_code,"
                            + "consumerid,accuracy,mf,meter_type,modem_serial_no) "
                            + "values(?,?,?,?,?,?,?,?,?,?,?,?,?)";
                    }
                    pst=con.prepareStatement(sql);
                    
                  
                    pst.setString(1, metersno);
                    
                    pst.setString(2, meterMake);
                   
                    pst.setString(3, meterLoc);
                   
                    pst.setString(4, meterCTR);
                   
                    pst.setString(5, meterPTR);
                   
                    pst.setString(6, adoptedCTR);
                   
                    pst.setString(7, adoptedPTR);
                   
                    pst.setString(8, locationCode);
                   
                    pst.setString(9, consumerId);               
                                     
                    pst.setString(10, accuracy);

                    //caluclate mf with meterCTR,meterPTR,adoptedCTR,adoptedPTR
					
                    try{
                    //mf=""+(Float.parseFloat(meterPTR) * Float.parseFloat(meterCTR))/(Float.parseFloat(adoptedCTR)*Float.parseFloat(adoptedPTR));
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
                    pst.setString(11, mf);
                    pst.setString(12, meterType);
                      if(modem_Serial_No.equals(""))
                            pst.setString(13,metersno);
                     else                                                            
                            pst.setString(13, modem_Serial_No);
                   
                    
                   
                   
//pstmt.setString(2, meterSerilNo);
                   int result= pst.executeUpdate();
 
                    //sql = "insert into meter(meterid,meter_serial_no,metermake,meterlocation) values(" + meterid + ",'" + metersno + "'," + meterMake + "," + meterLoc + ")";
                    if (result > 0) {
                        out.println("Meter  Added Successfully : " +metersno);
                    } else {
                        out.println("Meter  Added Failed, Try Again :" +metersno);
                    }//end else
                }//end else
            }
            catch (Exception e)
                    {
                     /*  if ( metersno == null || (meterMake == null) || (meterLoc == null))
                       {
                        out.println(" Mater Name Should Not be null");
                         }
                       else
                       {*/
                       System.out.println("Error----------------->"+e.getMessage());
                       e.printStackTrace();
                        out.println(e.getMessage());
                        //}
                      
            }//end catch
           
%>