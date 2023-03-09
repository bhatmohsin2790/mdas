<%@ page session="false" %>
<%@page import="in.amitech.db.DBUtil"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%
            Connection con = null;
            Statement st = null;
            String sql = null;
            String fromDate,toDate,conletterNo,rebate = null;
             String feederId=null;
             String consumername=null;
             String address=null;
             String mobileNo=null;
             String phoneNo=null;
             String emailId=null;
             String altEmail=null;
             String consession=null;
            try {
              feederId = request.getParameter("feederId").trim();           

               consumername=request.getParameter("consumerName").trim();
              
               address=request.getParameter("address").trim();
                
              mobileNo=request.getParameter("mobileno").trim();
               
               phoneNo=request.getParameter("phoneno").trim();
                
               emailId=request.getParameter("emailid").trim();
               
               altEmail=request.getParameter("altemail").trim();
               
               consession=request.getParameter("consession").trim();
               
               fromDate=request.getParameter("fromDate").trim();
               
               toDate=request.getParameter("toDate").trim();
              
               conletterNo=request.getParameter("conletterNo").trim();
               
               rebate=request.getParameter("rebate").trim();

               System.out.println("data is "+feederId+", "+consumername+", "+address+", "+mobileNo+", "+fromDate+","+toDate+" ");
                if ( feederId.equals("") ||   consumername.equals(""))
                {
                    System.out.println("feeder Id or dtr name Should not be Empty");
                }
                          else
                          {
                    con = new DBUtil().getConnection();
                    st = con.createStatement();
                   if (DBUtil.getTargetDB().equals("oracle")) {
                    sql = "insert into ht_consumer(consumername,address,mobileno,phoneno,emailid,altemailid,agrmntfromdate,agrmnttodate,concession,conletterno,rebate,feederid) values('" +consumername  + "','"+address+"'," +mobileNo+",'"+phoneNo+"','"+emailId+"','"+ altEmail+"',to_date('"+fromDate+"','dd/mm/yyyy'),to_date('"+toDate+"','dd/mm/yyyy'),'"+consession+"','"+conletterNo+"','"+rebate+"',"+feederId+")";
                     } else if (DBUtil.getTargetDB().equals("mysql")) {
                         sql="insert into ht_consumer(consumername,address,mobileno,phoneno,emailid,altemailid,agrmntfromdate,agrmnttodate,concession,conletterno,rebate,feederid) values('" +consumername  + "','"+address+"'," +mobileNo+",'"+phoneNo+"','"+emailId+"','"+ altEmail+"',str_to_date('"+fromDate+"','%d/%m/%Y'),str_to_date('"+toDate+"','%d/%m/%Y'),'"+consession+"','"+conletterNo+"','"+rebate+"',"+feederId+")";
                     }
                    System.out.println("sql query is--->"+sql);
                    if (st.executeUpdate(sql) > 0) {
                        out.println("HT Added Successfully : "+ consumername);
                    } else {
                        out.println("HT Added Failed, Try Again :"+ consumername);
                    }//end else
                }//end else
            } catch (Exception e) {
                if (   feederId == null ||   consumername == null) {
                    out.println(" feederId or consumer Name Should Not be null");
                } else {
                    out.println(e.getMessage());
                }
            }//end catch
%>