<%@ page session="false" %>
<%@page import="in.amitech.db.DBUtil"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%
            Connection con = null;
            Statement st = null;
            String sql = null;
            String feederId = null;
            String feederName=null;
            String classVoltage=null;
            String ssSelect=null;
            String dcuSelect=null;
            try {
            feederId = request.getParameter("feederId").trim();
           feederName=request.getParameter("feederName").trim();
            classVoltage=request.getParameter("classVoltage").trim();
            ssSelect=request.getParameter("ssSelect").trim();
                    dcuSelect=request.getParameter("dcuSelect").trim();
            

                if ( feederName.equals("")) {
                    System.out.println("feeder Name Should not be Empty :" +  feederName);
                } else {
                    con = new DBUtil().getConnection();
                    st = con.createStatement();
                    sql = "update feeder set feedername='"+ feederName+"',classvoltage='"+classVoltage+"',dcuid="+ dcuSelect+",substationid="+ssSelect+"  where feederid="+feederId;
                      System.out.println("sql query ----->"+sql);                                              
                             if (st.executeUpdate(sql) > 0) {
                        out.println("feeder updated Successfully : "+  feederName);
                    } else {
                        out.println("feeder updation Failed, Try Again :"+feederName);
                    }//end else
                }//end else
            } catch (Exception e) {
                if ( feederName == null) {
                    out.println("feeder Name Should Not be null");
                } else {
                   e.printStackTrace();
                }
            }//end catch
%>