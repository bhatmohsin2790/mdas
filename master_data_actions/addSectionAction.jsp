<%@ page session="false" %>
<%@page import="in.amitech.db.DBUtil"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%
            Connection con = null;
            Statement st = null;
            String sql = null;
            String subdivisionId = null;
            String sectionname=null;

            try {
                subdivisionId = request.getParameter("subdivisionId").trim();

                sectionname=request.getParameter("sectionname").trim();

                if ( subdivisionId.equals("") ||   sectionname.equals(""))
                {
                    System.out.println("division Id or subdivision Should not be Empty");
                }
                          else
                          {
                    con = new DBUtil().getConnection();
                    st = con.createStatement();
                    sql = "insert into section(sectionname,subdivid) values('" +   sectionname + "',"+  subdivisionId+")";
                    if (st.executeUpdate(sql) > 0) {
                        out.println("section Added Successfully : "+  sectionname);
                    } else {
                        out.println("section Added Failed, Try Again :"+  sectionname);
                    }//end else
                }//end else
            } catch (Exception e) {
                if (  subdivisionId == null ||   sectionname == null) {
                    out.println(" subdivisionId or section Name Should Not be null");
                } else {
                    out.println(e.getMessage());
                }
            }//end catch
%>