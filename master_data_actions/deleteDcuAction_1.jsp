<%@ page session="false" %>
<%@page import="in.amitech.db.DBUtil"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%
            Connection con = null;
            Statement st = null;
            String sql = null;
            String dcuName = null;
            try {
           dcuName = request.getParameter("dcuId").trim();
                System.out.println(dcuName);
                if (dcuName.equals("")) {
                    System.out.println("DCU Name Should not be Empty :" +dcuName);
                } else {
                    con = new DBUtil().getConnection();
                    st = con.createStatement();
                    sql = "delete  from  dcuinfo where dcuid=" +dcuName+"";
                    if (st.executeUpdate(sql) > 0) {
                        out.println("DCU deleted Successfully : "+ dcuName);
                    } else {
                        out.println("DCU deletion Failed, Try Again :"+ dcuName);
                    }//end else
                }//end else
            } catch (Exception e) {
                if (dcuName == null) {
                    out.println("DCU Name Should Not be null");
                } else {
                    out.println(e.getMessage());
                }
            }//end catch
%>