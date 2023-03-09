<%@ page session="false" %>
<%@page  import="java.util.*" %>
<%@page  import="java.sql.*" %>
<%@page  import="java.io.*" %>
<%@page  import="java.net.*" %>
<%@page import="in.amitech.db.DBUtil" %>
<%@page import="ActionBeans.Client_Requester" %>
<%!    String sql = "";
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
%>

<%
    try {
        String cmd ="DP";
        String responseData = "";
        String meterType = request.getParameter("meterLocation");
        String meters = request.getParameter("meterIds");
        String dataType=request.getParameter("dataType");
        String noOfLSDays=request.getParameter("lsDys");
        cmd=cmd+dataType.toUpperCase();
        if(dataType.toUpperCase().equals("LS"))
            cmd=cmd+noOfLSDays;
        System.out.println(meterType + "   " + meters+" "+dataType+" "+noOfLSDays);
          String[] meterNos = meters.split(",");
        // out.println("send Successfully");

        //-------------------------------------------------------

       con = new DBUtil().getConnection();
       Map messageMAP= new HashMap();
        for (int i = 0; i < meterNos.length; i++) {
               
                String unique = "";
                //getting unique id from database.....
                sql = "select sms_config_seq.nextval from dual";
                rs = con.prepareStatement(sql).executeQuery();
                if (rs.next()) {
                    unique = rs.getString(1);
                    out.println("Unique Id for "+meterNos[i]+" :" + unique + "<br/>");
                } else {
                    out.println("Unique ID getting failed...");
                    break;
                }
                messageMAP.put(meterNos[i], unique);
            }//for
       
            Iterator it=messageMAP.keySet().iterator();
            while (it.hasNext()) {
                    String msg = "SEND_SOCK_OD:";
                    String key = (String) it.next();
                    String value = messageMAP.get(key).toString();
                    msg = msg + key + ";2;0;^";
                    msg = msg + value + cmd;
                    System.out.println("message to send--->" + msg);

                    Client_Requester cr = new Client_Requester();
                    Socket sock = new Socket("192.168.2.111", 30000);

                    cr.Client_Request_Thread(sock, cmd);
                    responseData = cr.Client_Responses_Thread(sock, cmd);

                    System.out.println("response--->" + responseData);
                    if (responseData.isEmpty()) {
                        out.println("No response for "+key+"...<br />");
                    } else {
                        out.println(responseData);
                        out.println("<br/>");
                    }

                }//while 


    } catch (Exception e) {
        e.printStackTrace();
    }

%>