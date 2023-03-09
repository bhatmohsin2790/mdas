<%@ page session="false" %>
<%@page import="in.amitech.db.DBUtil"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%
            Connection con = null;
            PreparedStatement pstmtam = null;
            String sql = null;
            String metermakeId = null;
            String metermakeName = null;
            String meterSeries = null;
            String meterVersion = null;
            String noofParams = null;
            String paramNames = null;
            String b4_Tod_Params = null;
            String d4_Params = null;
            try {
                metermakeId = request.getParameter("metermakeId").trim();
                metermakeName = request.getParameter("metermakeName").trim();
                meterSeries = request.getParameter("meterSeries").trim();
                meterVersion = request.getParameter("meterVersion").trim();
                noofParams = request.getParameter("noofParams").trim();
                paramNames = request.getParameter("paramNames").trim();
                b4_Tod_Params = request.getParameter("b4_Tod_Params").trim();
                d4_Params = request.getParameter("d4_Params").trim();
                if (metermakeId.equals("") || metermakeName.equals("")) {
                    out.println("MetermakeId Id or Metermake Name Should not be Empty");
                } else {
                    con = new DBUtil().getConnection();

                    /*
                    sql = "insert into metermake values(?,?,?,?,?,?,?,?)";
                    pstmtam = con.prepareStatement(sql);
                    pstmtam.setString(1, metermakeId);
                    pstmtam.setString(2, metermakeName);
                    pstmtam.setString(3, meterSeries);
                    pstmtam.setString(4, meterVersion);
                    pstmtam.setString(5, noofParams);
                    pstmtam.setString(6, paramNames);
                    pstmtam.setString(7, b4_Tod_Params);
                    pstmtam.setString(8, d4_Params);
                     */

                    sql = "insert into metermake("
                            + "metermakename,meter_series,meter_version"
                            + ") values(?,?,?)";
                    pstmtam = con.prepareStatement(sql);
                    pstmtam.setString(1, metermakeName);
                    pstmtam.setString(2, meterSeries);
                    pstmtam.setString(3, meterVersion);

                    if (pstmtam.executeUpdate() > 0) {
                        out.println("Metermake Added Successfully : " + metermakeName);
                    } else {
                        out.println("Metermake Added Failed, Try Again :" + metermakeName);
                    }//end else
                }//end else
            } catch (Exception e) {
                if (metermakeId == null || metermakeName == null) {
                    out.println("MetermakeId Id or Metermake Name Should Not be null");
                } else {
                    out.println(e.getMessage());
                }
            }//end catch
            finally {
                con.close();
            }
%>