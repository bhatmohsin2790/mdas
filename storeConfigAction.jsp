<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title></title>
        <script type="text/javascript" src="jquery.js"></script>
        <%@ page import="java.sql.*,java.io.*" %>
        <%@page import="in.amitech.mdas.AMI_MDAS_API,in.amitech.db.DBUtil" %>
    </head>


    <body>
        <div id="navigation"></div>
        <table width=100% border=0 cellpadding=0 cellspacing=0 style="background:url(images/body.png) repeat-x;">
            <%@ include file="top.jsp"%>
            <tr>

                <td width=14px style="background:url(images/bg-content-left.png) no-repeat;width:14px;background-color:#EDF5FA;"></td>
                <td height="380px"width=98% style="background:url(images/bg-content-center.png) repeat-x;padding-left:10px;padding-right:10px;padding-bottom:10px;padding-top:10px;" valign="top">

                    <%-- <%@ include file="menu2.jsp"%> --%>
                    <br /><br />
                    <%@include file ="getConnection.jsp" %>
                    <%
                                int meterId = Integer.parseInt(request.getParameter("meterIds").split(",")[0]);
                                System.out.println("Meter Id :" + meterId);

                                String sql = null;
                                String modemSerialNo = null;
                                Statement st = null;
                                ResultSet rs = null;

                                sql = "select modem_serial_no from meter where meterid=" + meterId;
                                st = con.createStatement();
                                rs = st.executeQuery(sql);
                                while (rs.next()) {
                                    modemSerialNo=rs.getString("modem_serial_no");
                                }//end while
                                String timeInterval= request.getParameter("timeInterval");
                                String masterMobileNumber = request.getParameter("masterNo");
                                String apn = request.getParameter("apn");
                                String ftpPort = request.getParameter("port");
                                String ftpUser = request.getParameter("uname");

                                String ftpPwd = request.getParameter("pwd");

                                String serverIP = request.getParameter("serverIP");

                                String socketPort = request.getParameter("socketPort");

                                String startTime = request.getParameter("startTime");

                                String endTime = request.getParameter("endTime");

                                String modemMeterRetryCount = request.getParameter("modemMeterRetryCount");

                                String modemServerRetryCount = request.getParameter("modemServerRetryCount");

                                String consumerId = request.getParameter("consumerID");

                                String discommName = request.getParameter("discommName");

                                String mobileNo1 = request.getParameter("mobile1");

                                String mobileNo2 = request.getParameter("mobile2");

                                String mobileNo3 = request.getParameter("mobile3");

                                String mobileNo4 = request.getParameter("mobile4");

                                String mobileNo5 = request.getParameter("mobile5");

                                //hyderabad
                                /*
                                String configFileData = "$CON5," + masterMobileNumber + "," + apn + "," + ftpPort + "," + ftpUser
                                + "," + ftpPwd + "," + serverIP + "," + socketPort + ",1200," + consumerId + "," + meterType
                                + ",HT(3P-4W),5,5," + mobileNo1 + "," + mobileNo2 + "," + mobileNo3 + "," + mobileNo4 + "," + mobileNo5 + ",";
                                 *                              */
                                String configFileData = "$CON"+timeInterval+"," + masterMobileNumber + "," + apn + "," + ftpPort + "," + ftpUser
                                        + "," + ftpPwd + "," + serverIP + "," + socketPort + "," + startTime + "," + endTime + "," + consumerId + "," + discommName
                                        + "," + modemMeterRetryCount + "," + modemServerRetryCount + "," + mobileNo1 + "," + mobileNo2 + "," + mobileNo3 + "," + mobileNo4 + "," + mobileNo5 + ",";
                                //out.println(configFileData);

                                //to insert configuration details into db
                                out.println("Setting Configuration for Modem Serial No :" + modemSerialNo+"<br/>");
                                if (modemSerialNo == null || modemSerialNo.trim().equals("")) {
                                    out.println("Modem Serial Number Should not be Empty or NULL<br/>");
                                } else {
                                    try {
                                        sql = "insert into modem_configuration(modem_serial_no,config_total_data,meter_id) values(?,?,?)";
                                        PreparedStatement ps = con.prepareStatement(sql);
                                        ps.setString(1, modemSerialNo);
                                        ps.setString(2, configFileData);
                                        ps.setInt(3, meterId);
                                        if (ps.executeUpdate() == 0) {
                                            out.println("Modem Configuration Data Insertion Failed into db<br/>");
                                        } else {
                                            out.println("Modem Configuration Data Insertion Successful into db<br/>");
                                        }//end else
                                    } catch (Exception e) {
                                        out.println(e.getMessage());
                                    } finally {
                                        try {
                                            con.close();
                                        } catch (Exception e) {
                                        }//end catch
                                    }//end finally
                                }//end else

                                //to insert configuration details into file
                                String dir = "/var/ftp/ConfigurationFilesDump/";
                                File f = new File(dir);
                                if (!f.exists()) {
                                    f.mkdirs();
                                }
                                dir = dir + "/" + modemSerialNo + ".txt";
                                f = new File(dir);
                                FileWriter fw = new FileWriter(f);
                                fw.write(configFileData);
                                fw.flush();
                                fw.close();
                                out.println("Config File Successfully created to Path :" + f.getAbsolutePath() + "<br/>");

                                /* String sql="select mobileno from dtr where meter_id="+meterId;
                                //Connection con=DBUtil.getDataSource().getConnection();
                                Statement st=con.createStatement();
                                ResultSet rs=st.executeQuery(sql);
                                if(rs.next()){
                                String mobileNumber=rs.getString("mobileno");
                                AMI_MDAS_API mdas=new in.amitech.mdas.AMI_MDAS_API();
                                int status=mdas.sendConfigurationSMS(mobileNumber, "");
                                if(status == 0){
                                out.println("Message Sent Successfully for the Send Modem Configuration, Mobile Number :"+mobileNumber);
                                }else{
                                out.println("Message Sending Failed for the Send Modem Configuration, Mobile Number :"+mobileNumber);
                                }//end else
                                }else{
                                out.println("Mobile Number Not Found for the Meter");
                                }//end */
                    %>



                </td>
                <td width=13px style="background:url(images/bg-content-right.png) no-repeat;width:13px;background-color:#EDF5FA;"></td>
            </tr>
        </table>
        <div id="navigation"></div>
        <%@ include file="bottom.jsp"%>

    </body>
</html>