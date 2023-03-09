<%@ page session="false" %>
<%@page import="in.amitech.db.DBUtil"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%
            Connection con = null;
            Statement st = null;
            String sql = null;
            String substationId = null;
            String dcuId=null;
            String feedername=null;
            String cVoltage=null;

            try {
               substationId = request.getParameter("substationId").trim();
               dcuId=request.getParameter("dcuId").trim();
               feedername=request.getParameter("feedername").trim();
               cVoltage=request.getParameter("cVoltage").trim();

                if ( substationId.equals("") ||   feedername.equals(""))
                {
                    System.out.println("section Id or feeder name Should not be Empty");
                }
                          else
                          {
                    con = new DBUtil().getConnection();
                    st = con.createStatement();
                    sql = "insert into feeder(feedername,classvoltage,dcuid,substationid) values('" +feedername + "','"+cVoltage+"',"+dcuId+","+substationId+")";
                    if (st.executeUpdate(sql) > 0) {
                        out.println("Feeder Added Successfully : "+   feedername);
                    } else {
                        out.println("Feeder Added Failed, Try Again :"+   feedername);
                    }//end else
                }//end else
            } catch (Exception e) {
                if (   substationId == null ||    feedername == null) {
                    out.println(" sectionId or feeder Name Should Not be null");
                } else {
                    out.println(e.getMessage());
                }
            }//end catch
%>