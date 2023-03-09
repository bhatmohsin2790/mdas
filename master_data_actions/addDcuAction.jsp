<%@page import="in.amitech.db.DBUtil"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page session="false" %>
<%
            Connection con = null;
            Statement st = null;
            String sql = null;
            String substationId = null;
            
            String dcuName=null;

            try {
               substationId = request.getParameter("substationId").trim();

                
              dcuName=request.getParameter("dcu").trim();

                if (  substationId.equals("") ||    dcuName.equals(""))
                {
                    System.out.println("substation Id or dcuname Should not be Empty");
                }
                          else
                          {
                    con = new DBUtil().getConnection();
                    st = con.createStatement();
                    sql = "insert into dcuinfo(dcuname,substationid) values('" + dcuName + "',"+substationId+")";
                    if (st.executeUpdate(sql) > 0) {
                        out.println("DCU Added Successfully : "+    dcuName);
                    } else {
                        out.println("DCU Added Failed, Try Again :"+ dcuName);
                    }//end else
                }//end else
            } catch (Exception e) {
                if (   substationId == null ||    dcuName == null ) {
                    out.println(" substationId or dcuname Should Not be null");
                } else {
                    out.println(e.getMessage());
                }
            }//end catch
%>