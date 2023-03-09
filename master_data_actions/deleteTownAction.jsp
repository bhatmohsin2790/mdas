<%@ page session="false" %>
<%@page import="in.amitech.db.DBUtil"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%
            Connection con = null;
            Statement st = null;
            String sql = null;
            String townName = null;
            try 
            {
                townName = request.getParameter("townId").trim();
                System.out.println( townName);
                if ( townName.equals("")) 
                {
                    System.out.println("town Name Should not be Empty :" +  townName);
                }
                else 
                {
                    con = new DBUtil().getConnection();
                    st = con.createStatement();
                    sql = "delete  from  town where townid=" +  townName+"";
                    if (st.executeUpdate(sql) > 0) 
                    {
                        out.println("town deleted Successfully : "+  townName);
                    }
                    else 
                    {
                        out.println("town deletion Failed, Try Again :"+ townName);
                    }//end else
                }//end else
            }
            catch (Exception e) 
            {
                if ( townName == null) 
                {
                    out.println("town Name Should Not be null");
                }
                else 
                {
                    out.println(e.getMessage());
                }
            }//end catch
%>