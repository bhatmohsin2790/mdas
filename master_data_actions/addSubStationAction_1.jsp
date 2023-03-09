<%@ page session="false" %>
<%@page import="in.amitech.db.DBUtil"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%
            Connection con = null;
            Statement st = null;
            String sql = null;
            String sectionId = null;
            String ssname=null;

            try {
               sectionId = request.getParameter("sectionId").trim();

               ssname=request.getParameter("ssname").trim();

                if (  sectionId.equals("") ||   ssname.equals(""))
                {
                    System.out.println("section Id or substatin Should not be Empty");
                }
                          else
                          {
                    con = new DBUtil().getConnection();
                    st = con.createStatement();
                    sql = "insert into substation(substationname,sectionid) values('" +    ssname + "',"+   sectionId+")";
                    System.out.println(sql);
                    if (st.executeUpdate(sql) > 0) {
                        out.println("substation Added Successfully : "+   ssname);
                    } else {
                        out.println("substation Added Failed, Try Again :"+   ssname);
                    }//end else
                }//end else
            } catch (Exception e) {
                if (   sectionId == null ||    ssname == null) {
                    out.println(" sectionId or substation Name Should Not be null");
                } else {
                    out.println(e.getMessage());
                }
            }//end catch
%>