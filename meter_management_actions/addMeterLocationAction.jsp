<%@ page session="false" %>
<%@page import="in.amitech.db.DBUtil"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%
            Connection con = null;
            PreparedStatement st = null;
            String sql = null;
            String locid = null;
            String locname = null;
            try {
                locid = request.getParameter("locid").trim();
                locname = request.getParameter("locname").trim();
                if (locid.equals("") || locname.equals("")) {
                    out.println("Location Id or Locname Should not be Empty");
                } else {
                    con = new DBUtil().getConnection();
                    /*
                    st = con.prepareStatement("insert into meterlocation values(?,?)");
                    st.setString(1, locid);
                    st.setString(2, locname);
                     */
                    st = con.prepareStatement("insert into meterlocation(locationname) values(?)");
                    st.setString(1, locname);
                    if (st.executeUpdate() > 0) {
                        out.println("Location Added Successfully : " + locname);
                    } else {
                        out.println("Location Added Failed, Try Again :" + locname);
                    }//end else
                }//end else
            } catch (Exception e) {
                if (locid == null || locname == null) {
                    out.println("Location Id or Loc Name Should Not be null");
                } else {
                    out.println(e.getMessage());
                }
            }//end catch
            finally {
                if (con != null) {
                    con.close();
                }
            }
%>






