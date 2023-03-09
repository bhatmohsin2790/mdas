<%@ page session="false" %>
<%@page import="in.amitech.db.DBUtil"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%
            Connection con = null;
            Statement st = null;
            String sql = null;
            String divisionId = null;
            String subdivisionname=null;
            try {
                divisionId = request.getParameter("divisionId").trim();
                subdivisionname=request.getParameter("subdivisionname").trim();
                if ( divisionId.equals("") ||   subdivisionname.equals(""))
                {
                    System.out.println("division Id or substation Should not be Empty");
                }
                else
                {
                    con = new DBUtil().getConnection();
                    st = con.createStatement();
                    sql = "insert into subdivision(subdivname,divisionid) values('" +   subdivisionname + "',"+ divisionId+")";
                    if (st.executeUpdate(sql) > 0) {
                        out.println("subdivision Added Successfully : "+  subdivisionname);
                    } else {
                        out.println("subdivision Added Failed, Try Again :"+  subdivisionname);
                    }//end else
                }//end else
            } catch (Exception e) {
                if ( divisionId == null ||   subdivisionname == null) {
                    out.println("Division Id or SubDivision Name Should Not be null");
                } else {
                    out.println(e.getMessage());
                }
            }//end catch
%>