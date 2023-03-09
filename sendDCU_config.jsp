<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.io.FileWriter"%>
<%@page import="java.io.*"%>
<%@page import="org.apache.commons.net.ftp.FTPClient"%>
<%@page import="org.apache.commons.net.ftp.FTP"%>
<%@ include file="getConnection1.jsp"%>
<!-- <link rel="stylesheet" type="text/css" href="css/style.css" /> -->
<%
    try {
        String sql = null;
        String substationId = null;
        String dynamicIp = null;

        
         //Class.forName("oracle.jdbc.driver.OracleDriver");
         //Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "MDAS_WP", "India123");
         //Connection con = DriverManager.getConnection("jdbc:oracle:thin:@192.168.1.51:1535:PORTALDB","MDAS_WP","India123");
         PreparedStatement ps = null;
         ResultSet rs = null;
         //substationId = "531";//request.getParameter("dcu_id");
         substationId=request.getParameter("ssId");
         String MDAS_IP = request.getParameter("mDASIP");
         String MDAS_Periodicity = request.getParameter("mDASFreq");
         String LDMS_IP = request.getParameter("lDMSIP");
         String LDMS_Periodicity = request.getParameter("lDMSFreq");
         
         String Vrl = request.getParameter("Vrl"); String Vrh = request.getParameter("Vrh");
         String Vyl = request.getParameter("Vyl"); String Vyh = request.getParameter("Vyh");
         String Vbl = request.getParameter("Vbl"); String Vbh = request.getParameter("Vbh");
         
         String Irl = request.getParameter("Irl"); String Irh = request.getParameter("Irh");
         String Iyl = request.getParameter("Iyl"); String Iyh = request.getParameter("Iyh");
         String Ibl = request.getParameter("Ibl"); String Ibh = request.getParameter("Ibh");
         
         System.out.println("Substation Id = " + substationId);
         sql = "select dynamic_ip from substation_ip where substationid=" + substationId + " order by LOG_TIME_STAMP desc";
         System.out.println("ON_DEMAND Query Configuration = " + sql);
         ps = con.prepareStatement(sql);
         rs = ps.executeQuery();
         if (rs.next()) {
         dynamicIp = rs.getString(1);
         System.out.println("dynamicIp = " + dynamicIp);
         } else {
         out.println("<h3>IP is not available for this substation </h3>");
         }

         String dataToDCU = MDAS_IP + "@" 
                          + MDAS_Periodicity + "@" 
                          + LDMS_IP + "@" 
                          + LDMS_Periodicity + "@"
                          + Vrl + "@" + Vrh + "@" + Irl + "@" + Irh + "@"
                          + Vyl + "@" + Vyh + "@" + Iyl + "@" + Iyh + "@"
                          + Vbl + "@" + Vbh + "@" + Ibl + "@" + Ibh + "@"
                          + "#";

        System.out.println("dataToDCU = " + dataToDCU);
        String dcuConfigPath = "DCUConfig/Newsettings.txt";
        String dcuConfigFileName = application.getRealPath(dcuConfigPath);

        //out.println("dcuConfigFileName :" + dcuConfigFileName);
        //System.out.println("dcuConfigFileName = " + dcuConfigFileName);

        FileWriter f = new FileWriter(dcuConfigFileName);
        f.write(dataToDCU);
        f.close();

        
            FTPClient client = new FTPClient();           
            client.connect(dynamicIp);
            client.login("root", "ami123");
            client.setFileType(FTP.BINARY_FILE_TYPE);
            if (client.changeWorkingDirectory("home/")) {
                //System.out.println("Directory switched successfully to home........!");
            } else {
                System.out.println("Failed to switch directory to home......!");
            }
        if(FTPUpload(new File(dcuConfigFileName),dynamicIp,client))
        {
            String dcuConfirmPath = "DCUConfig/ftpSendOver.txt";
            String dcuConfirmName = application.getRealPath(dcuConfirmPath);
			out.println("Configuration send to DCU Successfully...........!");    
            if(FTPUpload(new File(dcuConfirmName),dynamicIp,client))    
            {
              out.println("!");    
            }
        }
        client.logout();
        //new in.amitech.FTPUtil.FileUpload().uploadFile(dcuConfigFileName);
        
        String resp = null;
        resp = "";
        //request.setAttribute("resp",resp);
        //if(resp.contains("COMMAND SENT SUCCESSFULLY"))
        //  do_client.cmd_Status_Update(cmd_id);
        out.println(resp);
        //con.close();
    } catch (Exception e) {
        out.println("--");
        e.printStackTrace();
    }
%>
<%--<jsp:include page="./index.jsp"/> --%>
<%!
    public boolean FTPUpload(File fileName,String dynamicIp,FTPClient client) {
        String fileNameToPush = fileName.getAbsolutePath();
        String remote = fileName.getName();
        boolean status = false;
        try {
             FileInputStream fis = null;
            //System.out.println("Reached Here..........! 1 " + fileName);
            fileNameToPush = fileNameToPush;

            //System.out.println("fileName -->" + fileNameToPush);
            fis = new FileInputStream(fileNameToPush);
            if (client.storeFile(remote, fis)) {
                System.out.println("Configuration File pushed successfully to DCU...! "+fileNameToPush);
                status = true;
            } else {
                System.out.println("Pushing of Configuration File to DCU has been failed...! "+fileNameToPush);
                status = false;                
            }
            
            //client.logout();
            fis.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return status;
    }
%>


