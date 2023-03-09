<%@page import="java.sql.Connection,java.sql.ResultSet,java.sql.PreparedStatement,java.util.Map,java.util.HashMap,java.util.ArrayList"%>
<%@page import="java.util.Set,java.util.Iterator"%>
<%@page import="in.amitech.db.DBUtil"%>
<%@page import="ActionBeans.Client_Requester" %>
<%@page  import="java.io.*" %>
<%@page  import="java.net.*" %>
<style>
        .thstyle{
        background-color: #8FA1B5; 
        color:#FFFFFF;
         font-size:14px;
         border-left:1px solid #FFFFFF;
          text-decoration:none;
          font-family: monospace;
           border-bottom: 1px solid #FFFFFF;
        }
        .trbg{
            background-color: #E8EBE2;
             border-bottom: 1px solid #FFFFFF;
        }
        .tdbg{
             border-bottom: 1px solid #FFFFFF;
             border-left: 1px solid #FFFFFF;
        }
        #district_11kv_load tr  td {
             background-color: #E8EBE2;
              border-bottom: 1px solid #FFFFFF;
             border-left: 1px solid #FFFFFF;
        }
     </style> 
<%
try{
String selected = request.getParameter("meters");
String requestToModem = request.getParameter("CTM");
String requiredParams=request.getParameter("requiredParams");
     
  String responseData = "";
  String command="SEND_SOCK_OD:"+selected+";"+requestToModem+";"+requiredParams;
  System.out.println(command);
%>
<table width="100%">
    <thead>
    <tr>
        <th class="thstyle">Meter Serial No</th>
        <th class="thstyle">Static IP</th>
        <th class="thstyle">Status</th>
    </tr>
    </thead>
    <tbody>
<%

    Client_Requester cr = new Client_Requester();
    Socket sock = new Socket("172.18.2.26", 30000);

    cr.Client_Request_Thread(sock, command);
    responseData = cr.Client_Responses_Thread(sock, command);
    if(responseData.contains("$")){
    String responseString[]=responseData.split("\\$");
    for(int i=0;i<responseString.length;i++){
        //out.println(responseString[i]);
        //out.println("<br />");
        %>
        <tr class="trbg">
            <td class="tdbg"><%=responseString[i].split(",")[0]%> </td>
            <td class="tdbg"><%=responseString[i].split(",")[1]%> </td>
            <td class="tdbg"><%=responseString[i].split(",")[2]%> </td>
        </tr>
  <%  }
       }else{
        out.println("No response");
       }

    //System.out.println("response--->" + responseData);
       }catch(Exception e){
           out.println("<h4 color='red'>Error:</h4>"+e.getMessage());
       }

%>
</tbody>
</table>
