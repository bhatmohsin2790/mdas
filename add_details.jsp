<%@page import="in.amitech.db.DBUtil"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.*"%>
<%
    Connection con = null;
    try {
        PreparedStatement pst = null;
        ResultSet rs = null;
        String sql = null;
        int flag = 0;
        String feederId = null;
        String dtrCapacity = null;
        String dtrname, modemno, mobileno, meterno, metermake, meterlocation = null;
        feederId = request.getParameter("feederid");
        dtrname = request.getParameter("dtrname");
        dtrCapacity = request.getParameter("dtrcapacity");
        modemno = request.getParameter("modemSlNo");
        mobileno = request.getParameter("mobile");
        meterno = request.getParameter("meterSlNo");
        metermake = request.getParameter("metermake");
        meterlocation = request.getParameter("meterlocation");
        con = new DBUtil().getConnection();
        System.out.println("feederid" + feederId + "dtr" + dtrname + "capacity" + dtrCapacity + "modem" + modemno + "mobile" + mobileno + "meter" + meterno + "make" + metermake + "location" + meterlocation + "");
//to test modem serial number is already exist or not
        sql = "select modem_serial_no from modem where modem_serial_no='" + modemno + "'";
        pst = con.prepareStatement(sql);
        rs = pst.executeQuery();
        if (rs.next()) {
            out.println("<font color=red>modem serial no is already exist in database</font>");
            System.out.println("modem serial no is already exist in database");
            flag = 1;
        }
        if (flag == 1) {
        } else {
            //to test whether mobile number is already mapped to any modem or not
            pst = con.prepareStatement("select modem_serial_no from modem where mobile_no='" + mobileno + "'");
            rs = pst.executeQuery();
            if (rs.next()) {
                out.println("mobile number already mapped to modem " + rs.getString("modem_serial_no"));
                System.out.println("mobile number already mapped to modem" + rs.getString("modem_serial_no"));
                flag = 1;
            }
            if (flag == 1) {
            } else {
                //code to insert modem no,mobile no into modem if modem no and mobile no are not existing
                pst = con.prepareStatement("insert into modem(modem_serial_no,mobile_no,is_dcu) values(?,?,?)");
                pst.setString(1, modemno);
                pst.setString(2, mobileno);
                pst.setInt(3, 0);
                if (pst.executeUpdate() > 0) {
                    System.out.println("Modem Added Successfully : " + modemno);

                }

                Statement stmt = con.createStatement();;
                int dtrId = 0;
                sql = "select dtr_seq.nextval from dual";
                rs = stmt.executeQuery(sql);
                if (rs.next()) {
                    dtrId = rs.getInt(1);
                    System.out.println("DTRId from db:" + dtrId);
                }//end if



                //inserting dtr info into dtr table
                sql = "insert into dtr(dtrid,dtrname,feederid,dtr_capacity) values(" + dtrId + ",'" + dtrname + "'," + feederId + "," + dtrCapacity + ")";


                //pst=con.prepareStatement("insert into dtr(dtrname,feederid,dtr_capacity) values('" +dtrname  + "',"+feederId+","+dtrCapacity+")");
                if (stmt.executeUpdate(sql) > 0) {
                    System.out.println("dtr Added Successfully : " + dtrname);
                }

                //testing whether meter details are already exist or not
                pst = con.prepareStatement("select d.dtrname,d.dtr_capacity,m.modem_serial_no,md.mobile_no,m.meter_serial_no,mk.metermakename,ml.locationname from meter m,metermake mk,meterlocation ml,dtr d,modem md where m.meter_serial_no='" + meterno + "' and m.metermake=mk.metermakeid and m.meterlocation=ml.locationid and d.dtrid=m.dtrid and m.modem_serial_no=md.modem_serial_no");
                rs = pst.executeQuery();
                if (rs.next()) {
                    System.out.println("before");
                    out.println("$143:dtrname is" + rs.getString("dtrname") + "dtrcapacity is" + rs.getString("dtr_capacity") + "modemSlNo is" + rs.getString("modem_serial_no") + "mobile is" + rs.getString("mobile_no") + "meter is" + rs.getString("meter_serial_no") + "meter make is" + rs.getString("metermakename") + "meter location is" + rs.getString("locationname") + "");
                    System.out.println("$143:dtrname is" + rs.getString("dtrname") + "dtrcapacity is" + rs.getString("dtr_capacity") + "modemSlNo is" + rs.getString("modem_serial_no") + "mobile is" + rs.getString("mobile_no") + "meter is" + rs.getString("meter_serial_no") + "meter make is" + rs.getString("metermakename") + "meter location is" + rs.getString("locationname") + "");
                    flag = 1;
                }
                if (flag == 1) {
                } else {
                    //getting meter no if it is already exist and remaining(make,location,modem no,dtrid) are not mapped
                    pst = con.prepareStatement("select meter_serial_no from meter where meter_serial_no='" + meterno + "'and metermake is null and meterlocation is null and modem_serial_no is null and dtrid is null");
                    rs = pst.executeQuery();
                    if (rs.next()) {
                        System.out.println("meter is already exist in database");
                        //if exist update that meter with these details
                        pst = con.prepareStatement("update meter set metermake=" + metermake + ",meterlocation=" + meterlocation + ",modem_serial_no='" + modemno + "',dtrid=" + dtrId + " where meter_serial_no='" + meterno + "'");
                        if (pst.executeUpdate() > 0) {
                            out.println("meter is already exist and these details updated successfully");
                        }
                        flag = 1;

                    }
                    if (flag == 1) {
                    } else {
                        //if not existing insert new record
                        pst = con.prepareStatement("insert into meter(meterid,meter_serial_no,metermake,meterlocation,modem_serial_no,dtrid) "
                                + "values(meter_seq.nextval,'" + meterno + "'," + metermake + "," + meterlocation + ",'" + modemno + "'," + dtrId + ")");
                        if (pst.executeUpdate() > 0) {
                            System.out.println("meter " + meterno + " is successfully added");
                            out.println("meter " + meterno + " is successfully added");
                        }
                    }
                }
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.println(e);
    } finally {
        con.close();
    }







%>