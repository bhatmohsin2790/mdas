<%@ page session="false" %>
<%@page import="in.amitech.db.DBUtil"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%
            Connection con = null;
            Statement st = null;
            String sql = null;
            String townId = null;
            String divisionName=null;
            try
            {
                townId = request.getParameter("townId").trim();
                divisionName=request.getParameter("divisionName").trim();
                System.out.println(townId+"\t"+divisionName);
                if (townId.equals("") || divisionName.equals("")) 
                {
                    System.out.println("Zone Id or Circle Should not be Empty");
                }
                else 
                {
                    con = new DBUtil().getConnection();
                    st = con.createStatement();
                    sql = "insert into division(divisionname,townid) values('" + divisionName + "',"+townId+")";
                    if (st.executeUpdate(sql) > 0) 
                    {
                        out.println("division Added Successfully : "+divisionName);
                    }
                    else 
                    {
                        out.println("division Added Failed, Try Again :"+divisionName);
                    }//end else
                }//end else
            }
            catch (Exception e) 
            {
                if (townId == null || divisionName == null) 
                {
                    out.println("Town Id or Division Name Should Not be null");
                }
                else 
                {
                    out.println(e.getMessage());
                }
            }//end catch
%>