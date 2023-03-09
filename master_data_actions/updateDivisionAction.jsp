<%@ page session="false" %>
<%@page import="in.amitech.db.DBUtil"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%
            Connection con = null;
            Statement st = null;
            String sql = null;
            String dId = null;
            String dName=null;
            String cId=null;
            String tId=null;

            try {
            dId = request.getParameter("dId").trim();
            dName=request.getParameter("dName").trim();
            cId=request.getParameter("cId").trim();
            tId = request.getParameter("tId").trim();
            //System.out.println("id"+sectionId+"name"+sectionName);

                if ( dName.equals("")) {
                    System.out.println("division Name Should not be Empty :" +  dName);
                } else {
                    con = new DBUtil().getConnection();
                    st = con.createStatement();
                    sql = "update division set divisionname='"+dName+"',townid="+tId+",circleid="+cId+" where divisionid="+dId+"";
                    if (st.executeUpdate(sql) > 0) {
                        out.println("division updated Successfully : "+  dName);
                    } else {
                        out.println("division updation Failed, Try Again :"+ dName);
                    }//end else
                }//end else
            } catch (Exception e) {
                if ( dName == null) {
                    out.println("division Name Should Not be null");
                } else {
                    out.println(e.getMessage());
                }
            }//end catch
            
%>