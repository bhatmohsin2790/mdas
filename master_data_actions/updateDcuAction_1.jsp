<%@ page session="false" %>
<%@page import="in.amitech.db.DBUtil"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%
            Connection con = null;
            Statement st = null;
            String sql = null;
            String dcuId = null;
            String dcuName=null;
            String ssId=null;
            try {
            dcuId = request.getParameter("dcuId").trim();
            dcuName=request.getParameter("dcuName").trim();
            ssId=request.getParameter("ssId").trim();
            //System.out.println("id"+sectionId+"name"+sectionName);

                if ( dcuName.equals("")) {
                    System.out.println("dcu Name Should not be Empty :" +  dcuName);
                } else {
                    con = new DBUtil().getConnection();
                    st = con.createStatement();
                    sql = "update dcuinfo set dcuname='"+dcuName+"',substationid="+ssId+" where dcuid="+dcuId+"";
                    if (st.executeUpdate(sql) > 0) {
                        out.println("dcu updated Successfully : "+  dcuName);
                    } else {
                        out.println("dcu updation Failed, Try Again :"+ dcuName);
                    }//end else
                }//end else
            } catch (Exception e) {
                if ( dcuName == null) {
                    out.println("dcu Name Should Not be null");
                } else {
                    out.println(e.getMessage());
                }
            }//end catch
%>