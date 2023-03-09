<%@ page session="false" %>
<%@page import="in.amitech.db.DBUtil"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%
            Connection con = null;
            Statement st = null;
            String sql = null;
            String ssId = null;
            String ssName=null;
            String sName=null;
            try {
            ssId = request.getParameter("ssId").trim();
            ssName=request.getParameter("ssName").trim();
            sName=request.getParameter("sName").trim();
            System.out.println("id"+ssId+"name"+ssName);

                if ( ssName.equals("")) {
                    System.out.println("substation Name Should not be Empty :" +  ssName);
                } else {
                    con = new DBUtil().getConnection();
                    st = con.createStatement();
                    sql = "update substation set substationname='"+ssName+"',sectionid="+sName+" where substationid="+ssId+"";
                    if (st.executeUpdate(sql) > 0) {
                        out.println("substation updated Successfully : "+  ssName);
                    } else {
                        out.println("substation updation Failed, Try Again :"+ ssName);
                    }//end else
                }//end else
            } catch (Exception e) {
                if ( ssName == null) {
                    out.println("substation Name Should Not be null");
                } else {
                    out.println(e.getMessage());
                }
            }//end catch
%>