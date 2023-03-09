<%@ page session="false" %>
<%@page import="in.amitech.db.DBUtil"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%
            Connection con = null;
            Statement st = null;
            String sql = null;
            String htId  = null;

            String meterId=null;


            try {
              htId = request.getParameter("htId").trim();


             meterId=request.getParameter("meterId").trim();


                if ( htId.equals("") ||    meterId.equals(""))
                {
                    System.out.println("ht or meter Should not be Empty");
                }
                          else
                          {
                    con = new DBUtil().getConnection();
                    st = con.createStatement();
                    sql = "update meter set htconsumerid="+htId+ " where meterid="+meterId;
                    if (st.executeUpdate(sql) > 0) {
                        out.println("ht mapped to selected meter");
                    } else {
                        out.println("ht meter mapping  Failed, Try Again :"+htId);
                    }//end else
                }//end else
            } catch (Exception e) {
                if (  meterId == null ||   htId == null) {
                    out.println(" htId or meter Should Not be null");
                } else {
                    out.println(e.getMessage());
                }
            }//end catch
            /*finally
                    {
                con.close();
                }*/
%>