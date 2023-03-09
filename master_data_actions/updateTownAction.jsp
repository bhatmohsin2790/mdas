<%@ page session="false" %>
<%@page import="in.amitech.db.DBUtil"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%
            Connection con = null;
            Statement st = null;
            String sql = null;
            String townId = null;
            String townName=null;
            String subdivisionId=null;
            try 
            {
                townId = request.getParameter("tId").trim();
                townName=request.getParameter("tName").trim();
                if ( townName.equals("")) 
                {
                    System.out.println("town Name Should not be Empty :" +  townName);
                }
                else 
                {
                    con = new DBUtil().getConnection();
                    st = con.createStatement();
                    sql = "update town set townname='"+townName+"' where townid="+townId+"";
                    System.out.println("sql\t"+sql);
                    if (st.executeUpdate(sql) > 0) 
                    {
                        out.println("town updated Successfully : "+  townName);
                    }
                    else 
                    {
                        out.println("town updation Failed, Try Again :"+ townName);
                    }//end else
                }//end else
            }
            catch (Exception e) 
            {
                   if ( townName == null) {
                       out.println("town NameShould Not be null");
                   } else {
                       out.println(e.getMessage());
                   }
            }//end catch
%>