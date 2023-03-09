<%@page import="java.io.File"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%! public static boolean backupDB(String dbName, String dbUserName, String dbPassword, String path) {

        String executeCmd = "mysqldump -u " + dbUserName + " -p" + dbPassword + " --add-drop-database -B " + dbName + " -r " + path;
        Process runtimeProcess;
        try {
            
            runtimeProcess = Runtime.getRuntime().exec(executeCmd);
           
            int processComplete = runtimeProcess.waitFor();

            if (processComplete == 0) {
                System.out.println("Backup created successfully");
              
                return true;
            } else {
                System.out.println("Could not create the backup");
              
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }

        return false;
    } %>
    
  

    
  <%
        try {
                boolean resultFlg = false;
                String dbName = "mdas_test";
                String dbUserName = "root";
                String dbPassword = "ami123";
                DateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
                Date date = new Date();
                String strDate = "";
                strDate = dateFormat.format(date);
                String fileName ="mdas_"+strDate+".sql";                
                //String path = "/root/"+fileName;
                String filePath = getServletContext().getRealPath("/") +"dbbackup/"+fileName;
                System.out.println("filepath--->"+filePath);
                
                
                resultFlg = backupDB(dbName,dbUserName,dbPassword,filePath);
               if(resultFlg){
                  out.println("Backup created successfully");
                    
               }else{
                    out.println("Could not create the backup");
                    
               }
            } catch (Exception ex) {
               ex.printStackTrace();
        }
   %>
    
   
    