<%@ page session="false" %>
<%@page import="in.amitech.db.DBUtil"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%
            Connection con = null;
            Statement st = null;
            String sql = null;
            String circleId = null;
            String townname=null;

            try 
            {
                    circleId = request.getParameter("circleId").trim();
                    townname=request.getParameter("townname").trim();
                if ( circleId.equals("") ||   townname.equals(""))
                {
                    System.out.println("division Id or subdivision Should not be Empty");
                }
                else
                {
                    con = new DBUtil().getConnection();
                    st = con.createStatement();
                    sql = "insert into town(townname,circleid) values('" +   townname + "',"+  circleId+")";
                    if (st.executeUpdate(sql) > 0) 
                    {
                        out.println("town Added Successfully : "+  townname);
                    }
                    else 
                    {
                        out.println("town Added Failed, Try Again :"+  townname);
                    }//end else
                }//end else
            }
            catch (Exception e) 
            {
                if (  circleId == null ||   townname == null) 
                {
                    out.println("CircleName or town Name Should Not be null");
                }
                else 
                {
                    out.println(e.getMessage());
                }
            }//end catch
%>