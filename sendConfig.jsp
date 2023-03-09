<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Iterator"%>
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
       // String cmd = "Time";
        String cmd = "CONFIG";
        System.out.println("command ----->"+cmd);
        String responseData = "";
        String meterType = request.getParameter("meterLocation");
        String meters = request.getParameter("meterIds");
        System.out.println(meterType + "   " + meters);
        String[] meterNos = meters.split(",");
         //out.println("send Successfully");
        //-------------------------------------------------------
        con = new DBUtil().getConnection();
       Map messageMAP= new HashMap();
        for (int i = 0; i < meterNos.length; i++) {
               System.out.println("in for ");
                String unique = "";
                //getting unique id from database.....
                sql = "select sms_config_seq.nextval from dual";
                rs = con.prepareStatement(sql).executeQuery();
                if (rs.next()) {
                    unique = rs.getString(1);
                    out.println("Unique Id for "+meterNos[i]+" :" + unique + "<br/>");
                    System.out.println("Unique---->"+unique);
                } else {
                    out.println("Unique ID getting failed...");
                    System.out.println("Unique id gettting failed");
                    break;
                }
                System.out.println("unique id------>"+unique);
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