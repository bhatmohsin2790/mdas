<%@ page session="false" %>
<%@page import="in.amitech.db.DBUtil"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%
            Connection con = null;
            Statement st = null;
            String sql = null;
            String feederId = null;
            String dtrCapacity = null;
            String dtrname = null;


            try {
                feederId = request.getParameter("feederId").trim();
                System.out.println("feeder" + feederId);

                dtrname = request.getParameter("dtrName").trim();
                System.out.println("dtr" + dtrname);
                dtrCapacity = request.getParameter("dtrCapacity").trim();
                System.out.println("capacity=" + dtrCapacity);

                if (dtrCapacity.isEmpty()) {
                    dtrCapacity = "100";
                }//end if

                if (feederId.equals("") || dtrname.equals("")) {
                    System.out.println("feeder Id or dtr name Should not be Empty");
                } else {
                    con = new DBUtil().getConnection();
                    st = con.createStatement();

                    if (DBUtil.getTargetDB().equals("oracle")) {
                        sql = "insert into dtr(dtrid,dtrname,feederid,dtr_capacity) values(dtr_seq.nextval,'" + dtrname + "'," + feederId + "," + dtrCapacity + ")";
                        if (st.executeUpdate(sql) > 0) {
                            out.println("DTR Added Successfully : " + dtrname);
                        } else {
                            out.println("DTR Added Failed, Try Again :" + dtrname);
                        }//end else
                    } else if (DBUtil.getTargetDB().equals("mysql")) {
                        sql = "insert into dtr(dtrname,feederid,dtr_capacity) values('" + dtrname + "'," + feederId + "," + dtrCapacity + ")";
                        if (st.executeUpdate(sql) > 0) {
                            out.println("DTR Added Successfully : " + dtrname);
                        } else {
                            out.println("DTR Added Failed, Try Again :" + dtrname);
                        }//end else
                    } else {
                        throw new Exception("Unsupported DB Operation");
                    }//end else
                }//end else
            } catch (Exception e) {
                if (feederId == null || dtrname == null) {
                    out.println(" FeederId or DTR Name Should Not be null");
                } else {
                    out.println(e.getMessage());
                }
            }//end catch

%>