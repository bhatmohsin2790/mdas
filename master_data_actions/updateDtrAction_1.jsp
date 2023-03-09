<%@ page session="false" %>
<%@page import="in.amitech.db.DBUtil"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%
            Connection con = null;
            Statement st = null;
            String sql = null;
            String dtrId = null;
            String dtrCapacity=null;
            String dtrName=null;
            String feederName=null;
            try {
            dtrId = request.getParameter("dtrId").trim();
            dtrName=request.getParameter("dtrName").trim();
            dtrCapacity=request.getParameter("newCapacity").trim();
            feederName=request.getParameter("feederName").trim();
            System.out.println("id"+dtrId+"name"+dtrName);

                if ( feederName.equals("")) {
                    System.out.println("feeder Name Should not be Empty :" +  feederName);
                } else {
                    con = new DBUtil().getConnection();
                    st = con.createStatement();
                    sql = "update dtr set dtrname='"+ dtrName+"',feederid="+feederName+",dtr_capacity="+dtrCapacity+" where dtrid="+ dtrId+"";
                    if (st.executeUpdate(sql) > 0) {
                        out.println("DTR updated Successfully : "+  dtrName);
                    } else {
                        out.println("DTR updation Failed, Try Again :"+dtrName);
                    }//end else
                }//end else
            } catch (Exception e) {
                if ( feederName == null) {
                    out.println("feeder Name Should Not be null");
                } else {
                    out.println(e.getMessage());
                }
            }//end catch

%>