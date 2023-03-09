<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title></title>
        <script type="text/javascript" src="jquery.js"></script>

        <%@ page import="java.sql.*" %>
        <%@page import="in.amitech.mdas.AMI_MDAS_API" %>
        <%@page import="java.util.HashMap"%>
        <%@page import="java.util.Iterator"%>
        <%@page import="java.util.Map"%>
        <%@page import="in.amitech.mdas.AMI_MDAS_API"%>
        <%@page import="java.util.ArrayList"%>
        <%@page import="java.util.List"%>
        <%@page import="in.amitech.params.POTANotificationParams"%>
        <%@page import="java.sql.Statement"%>
        <%@page import="java.sql.ResultSet"%>
        <%@page import="java.sql.PreparedStatement"%>
        <%@page import="in.amitech.db.DBUtil"%>
        <%@page import="java.sql.Connection"%>
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
                    <%@page import="java.sql.*,in.amitech.mdas.AMI_MDAS_API,in.amitech.db.DBUtil" %>

                    <%@include file ="getConnection.jsp" %>
                    <%



                                POTANotificationParams mcp = null;
                                List l = new ArrayList();
                                Map mobileMap = new HashMap();
                                Map uiMap = new HashMap();
                                String requestType = "POTA";
                                try {
                                    String meters = request.getParameter("meterIds");
                                    String[] meterIds = meters.split(",");

                                    String date = request.getParameter("startingDate");
                                    PreparedStatement ps = null;
                                    Statement st = null;
                                    ResultSet mrs = null, rs = null;
                                    String sql2 = null;

                                    //getting mobileno for meter
                                    //String sql = "select mobileno from dtr where meter_id=?";
                                    String sql = "select mobile_no from modem where modem_serial_no=(select modem_serial_no from meter where meterid=?)";
                                    ps = con.prepareStatement(sql);
                                    mrs = null;
                                    boolean reqStatus = true;
                                    boolean uniqStatus = true;

                                    for (int i = 0; i < meterIds.length; i++) {
                                        out.println("Searching Meter :" + meterIds[i] + "<br/>");
                                        mcp = new POTANotificationParams();
                                        int meterId = Integer.parseInt(meterIds[i]);
                                        ps.setInt(1, meterId);
                                        String mobileNumber = null;

                                        mrs = ps.executeQuery();
                                        if (mrs.next()) {
                                            mobileNumber = mrs.getString("mobile_no");
                                            mobileMap.put(mobileNumber, String.valueOf(meterId));
                                            mcp.setMobilenumber(mobileNumber);
                                            mcp.setDate(date);
                                            out.println("Mobile Number :" + mobileNumber + "<br/>");
                                            //getting unique id from database
                                            st = con.createStatement();
                                            rs = null;
                                            sql2 = "select sms_config_seq.nextval from dual";
                                            String seqVal = "";
                                            rs = st.executeQuery(sql2);
                                            if (rs.next()) {
                                                seqVal = rs.getString(1);
                                                uiMap.put(mobileNumber, seqVal);
                                                mcp.setUniqueId(seqVal);
                                                l.add(mcp);
                                                out.println("Unique Id :" + seqVal + "<br/>");
                                            } else {
                                                //unique Id generation failed
                                                out.println("Unique Id getting failed");
                                                uniqStatus = false;
                                                break;
                                            }//end else


                                        } else {
                                            //getting mobilenumber failed break and stop the entire process
                                            out.println("Mobile Number getting failed");
                                            reqStatus = false;
                                            break;
                                        }//end else

                                    }//end for

                                    if (reqStatus && uniqStatus) {
                                        //all mobileNumber and unique Id fetching is success, proceed further
                                        if (l.isEmpty()) {
                                            //list is empty
                                        } else {

                                            AMI_MDAS_API mdas = new in.amitech.mdas.AMI_MDAS_API();
                                            Map m = mdas.send_Notification_For_POTA(l);
                                            for (Iterator it = m.keySet().iterator(); it.hasNext();) {
                                                //check the sms status
                                                String key = (String) it.next();
                                                String value = String.valueOf((Integer) m.get(key));
                                                int meterId = Integer.parseInt((String) mobileMap.get(key));
                                                int uniqueId = Integer.parseInt((String) uiMap.get(key));
                                                out.println("Meter ID :" + meterId + " : " + "Mobile Number :" + key + ": status :" + value + "<br/>");

                                                //insert sms sent details into db
                                                //status 0 sms sent successfully
                                                if (value.trim().equals("0")) {
                                                    out.println("SMS Sent Successfully<br/>");
                                                } else {
                                                    out.println("SMS Sending Failed<br/>");
                                                }//end else

                                                sql = "insert into sms_config(req_id,req_time_stamp,req_type,res_count,mobile_no,meter_id,sms_status) values(?,current_timestamp(6),?,?,?,?,?)";
                                                ps = con.prepareStatement(sql);
                                                ps.setInt(1, uniqueId);
                                                ps.setString(2, requestType);
                                                ps.setInt(3, 0);
                                                ps.setString(4, key);
                                                ps.setInt(5, meterId);
                                                ps.setInt(6, Integer.parseInt(value));
                                                if (ps.executeUpdate() > 0) {
                                                    out.println("Data Inserted Successfully into sms config table for MeterId :" + meterId);
                                                } else {
                                                    out.println("Data Insertion Failed into sms config table for MeterId :" + meterId);
                                                }//end else



                                            }//end for
                                        }//end else
                                    } else {
                                        if (!reqStatus) {
                                            out.println("Mobile Number getting is failed");
                                        }
                                        if (!uniqStatus) {
                                            out.println("Unique Number getting from database failed");
                                        }
                                    }//end else

                                } catch (Exception e) {
                                    e.printStackTrace();
                                } finally {
                                    con.close();
                                }
                    %>

                </td>
                <td width=13px style="background:url(images/bg-content-right.png) no-repeat;width:13px;background-color:#EDF5FA;"></td>
            </tr>
        </table>
        <div id="navigation"></div>
        <%@ include file="bottom.jsp"%>

    </body>
</html>
