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
             String htId=null;
            try {
              feederId = request.getParameter("feederId").trim();
             


             htId = request.getParameter("htId").trim();

               consumername=request.getParameter("htName").trim();

               address=request.getParameter("address").trim();

              mobileNo=request.getParameter("mobileNo").trim();

               phoneNo=request.getParameter("phoneNo").trim();

               emailId=request.getParameter("emailId").trim();

               altEmail=request.getParameter("altemail").trim();

               consession=request.getParameter("concession").trim();

               fromDate=request.getParameter("fromDate").trim();

               toDate=request.getParameter("toDate").trim();

               conletterNo=request.getParameter("conletterNo").trim();

               rebate=request.getParameter("rebate").trim();

               
                if ( feederId.equals("") ||   consumername.equals(""))
                {
                    System.out.println("feeder Id  Should not be Empty");
                }
                          else
                          {
                    con = new DBUtil().getConnection();
                    st = con.createStatement();
                     if (DBUtil.getTargetDB().equals("oracle")) {
                    sql = "update ht_consumer set consumername='"+consumername+"',address='"+address+"',mobileno="+mobileNo+",phoneno='"+phoneNo+"',emailid='"+emailId+"',altemailid='"+altEmail+"',agrmntfromdate=to_date('"+fromDate+"','dd/mm/yyyy'),agrmnttodate=to_date('"+toDate+"','dd/mm/yyyy'),concession='"+consession+"',conletterno='"+conletterNo+"',rebate='"+rebate+"',feederid="+feederId+" where consumerid="+htId;
                    } else if (DBUtil.getTargetDB().equals("mysql")) {
                         sql = "update ht_consumer set consumername='"+consumername+"',address='"+address+"',mobileno="+mobileNo+",phoneno='"+phoneNo+"',emailid='"+emailId+"',altemailid='"+altEmail+"',agrmntfromdate=str_to_date('"+fromDate+"','%d/%m/%Y'),agrmnttodate=str_to_date('"+toDate+"','%d/%m/%Y'),concession='"+consession+"',conletterno='"+conletterNo+"',rebate='"+rebate+"',feederid="+feederId+" where consumerid="+htId;
                    }
                    if (st.executeUpdate(sql) > 0) {
                        out.println("HT  updated Successfully : "+ consumername);
                    } else {
                        out.println("HT updation Failed, Try Again :"+ consumername);
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