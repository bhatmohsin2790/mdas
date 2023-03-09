<%@ page session="false" %>
<%@ include file="getConnection.jsp"%>
<%!    PreparedStatement pstmt = null;
    ResultSet rs = null;
%>
<%
            String meterId = null;
            int searchType = 0;
            try {
                int optVal = Integer.parseInt(request.getParameter("opt"));
                searchType = Integer.parseInt(request.getParameter("searchType"));
                meterId = request.getParameter("meterId");
                String data = "";

                if (searchType == -1) {
                    //nothing is selected get all discom meter/meters
                    String sql = "select * from meter m where m.feederid is null "
                            + "and m.dtrid is null "
                            + "and m.htconsumerid is null and m.meter_serial_no like ?";

                    pstmt = con.prepareStatement(sql);
                    pstmt.setString(1, meterId + "%");
                    rs = pstmt.executeQuery();
                    while (rs.next()) {
                        data = rs.getString("meterid") + "_" + rs.getString("meter_serial_no") + "-NEW:" + data;
                    }//end while
                } else if (searchType == 0) {
                    //nothing is selected get all discom meter/meters
                    String sql = "select * from meter m,dtr d where m.dtrid in ("
                            + "select dtrid from dtr where feederid in ("
                            + "select feederid from feeder where substationid in ("
                            + "select substationid from substation where sectionid in ("
                            + "select sectionid from section where subdivid in ("
                            + "select subdivid from subdivision where subdivid in ("
                            + "select divisionid from division where circleid in ("
                            + "select circleid from circle where zoneid in ("
                            + "select zoneid from zone where discom_id in (select discom_id from discom)"
                            + ")"
                            + ")"
                            + ")"
                            + ")"
                            + ")"
                            + ")"
                            + ")"
                            + ") and m.meter_serial_no like ? and m.dtrid=d.dtrid";

                    pstmt = con.prepareStatement(sql);
                    pstmt.setString(1, meterId + "%");
                    rs = pstmt.executeQuery();
                    while (rs.next()) {
                        data = rs.getString("meterid") + "_" + rs.getString("meter_serial_no") + "-" + rs.getString("dtrname") + ":" + data;
                    }//end while
                } else if (searchType == 1) {
                   
                    String sql = "select * from meter m,dtr d where m.dtrid in ("
                            + "select dtrid from dtr where feederid in ("
                            + "select feederid from feeder where substationid in ("
                            + "select substationid from substation where sectionid in ("
                            + "select sectionid from section where subdivid in ("
                            + "select subdivid from subdivision where subdivid in ("
                            + "select divisionid from division where circleid in ("
                            + "select circleid from circle where zoneid in ("
                            + "select zoneid from zone where discom_id in (select discom_id from discom where discom_id=?)"
                            + ")"
                            + ")"
                            + ")"
                            + ")"
                            + ")"
                            + ")"
                            + ")"
                          //  + ") and m.meter_serial_no like ? and m.dtrid=d.dtrid";
                            + ") and m.meter_serial_no like ?";
                 System.out.println("query--->"+sql);
                    pstmt = con.prepareStatement(sql);
                    pstmt.setInt(1, optVal);
                    pstmt.setString(2, meterId + "%");
                    rs = pstmt.executeQuery();
                    while (rs.next()) {
                        data = rs.getString("meterid") + "_" + rs.getString("meter_serial_no") + "-" + rs.getString("dtrname") + ":" + data;
                    }//end while
                } else if (searchType == 2) {
                   
                    String sql = "select * from meter m,dtr d where m.dtrid in ("
                            + "select dtrid from dtr where feederid in ("
                            + "select feederid from feeder where substationid in ("
                            + "select substationid from substation where sectionid in ("
                            + "select sectionid from section where subdivid in ("
                            + "select subdivid from subdivision where subdivid in ("
                            + "select divisionid from division where circleid in ("
                            + "select circleid from circle where zoneid in ("
                            + "select zoneid from zone where zoneid=?"
                            + ")"
                            + ")"
                            + ")"
                            + ")"
                            + ")"
                            + ")"
                            + ")"
                            + ") and m.meter_serial_no like ? and m.dtrid=d.dtrid";

                    pstmt = con.prepareStatement(sql);
                    pstmt.setInt(1, optVal);
                    pstmt.setString(2, meterId + "%");
                    rs = pstmt.executeQuery();
                    while (rs.next()) {
                        data = rs.getString("meterid") + "_" + rs.getString("meter_serial_no") + "-" + rs.getString("dtrname") + ":" + data;
                    }//end while
                } else if (searchType == 3) {
                  
                    String sql = "select * from meter m,dtr d where m.dtrid in ("
                            + "select dtrid from dtr where feederid in ("
                            + "select feederid from feeder where substationid in ("
                            + "select substationid from substation where sectionid in ("
                            + "select sectionid from section where subdivid in ("
                            + "select subdivid from subdivision where subdivid in ("
                            + "select divisionid from division where circleid in ("
                            + "select circleid from circle where circleid=?"
                            + ""
                            + ""
                            + ")"
                            + ")"
                            + ")"
                            + ")"
                            + ")"
                            + ")"
                            + ") and m.meter_serial_no like ? and m.dtrid=d.dtrid";

                    pstmt = con.prepareStatement(sql);
                    pstmt.setInt(1, optVal);
                    pstmt.setString(2, meterId + "%");
                    rs = pstmt.executeQuery();
                    while (rs.next()) {
                        data = rs.getString("meterid") + "_" + rs.getString("meter_serial_no") + "-" + rs.getString("dtrname") + ":" + data;
                    }//end while
                }

                out.print(data);
                System.out.println("searched data--->"+data);
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                con.close();
            }
%>