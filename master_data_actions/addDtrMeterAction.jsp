<%@ page session="false" %>
<%@page import="in.amitech.db.DBUtil"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%
            Connection con = null;
            Statement st = null;
            String sql = null;
            String dtrId = null;

            String meterId = null;


            try {
                dtrId = request.getParameter("dtrId").trim();


                meterId = request.getParameter("meterId").trim();


                if (dtrId.equals("") || meterId.equals("")) {
                    System.out.println("dtr or meter Should not be Empty");
                } else {
                    con = new DBUtil().getConnection();
                    st = con.createStatement();
                    sql = "update meter set dtrid=" + dtrId + " where meterid=" + meterId;
                    System.out.println("DTR Update Qry :" + sql);
                    if (st.executeUpdate(sql) > 0) {
                        out.println("dtr mapped to : " + meterId);
                    } else {
                        out.println("dtr meter mapping  Failed, Try Again :" + dtrId);
                    }//end else
                }//end else
            } catch (Exception e) {
                if (meterId == null || dtrId == null) {
                    out.println(" dtrId or meter Should Not be null");
                } else {
                    out.println(e.getMessage());
                }
            }//end catch
            finally {
                con.close();
            }
%>