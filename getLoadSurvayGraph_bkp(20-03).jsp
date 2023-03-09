<%@ page session="false" %>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="in.amitech.db.DBUtil"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.*"%>

<%
Connection con1 = null;
            try {                
                ResultSet rs = null;
                ResultSet rs1 = null;
                PreparedStatement ps = null;
                PreparedStatement pstmt = null;
                Statement st = null;
                Statement stmt = null;
                String sql = null;
                String string_data = "";
                String[] data_string2 = new String[0];
                String params[] = {"", "", "", "", "", "", "", "", "", ""};
                String data = "";
                double mf = 1.0, imf = 1.0;
                String time = "";
                String meterId = request.getParameter("meterid").trim();
				System.out.println("meter id is"+meterId);
                String sdate = request.getParameter("sdate");
				System.out.println("sdate is "+sdate);

                //mf param
                String emf = request.getParameter("EMF");
				System.out.println("emf is"+emf);
                con1 = new DBUtil().getConnection();


                pstmt = con1.prepareStatement("select * from d4_columns_header where meter_serial_no=(select meter_serial_no from meter where meterid=" + meterId + ")");
                rs = pstmt.executeQuery();
                if (rs.next()) {
                    System.out.println("---------------------------Load survay Header Got Dynamically-----------------------------------");
                    data_string2 = rs.getString("load_columns_header").split(",");
                } else {
                    System.out.println("---------------------------Load survay Header Got Manually-----------------------------------");
                    pstmt = con1.prepareStatement("select no_of_params,d4_params from metermake where metermakeid=(select metermake from meter where meterid=" + meterId + ")");
                    rs = pstmt.executeQuery();
                    if (rs.next()) {
                        data_string2 = rs.getString("d4_params").split(",");
                    }//end if
                }//end else


                //mf new logic start

                String sql1 = "select mf,imf from meter where meterid=" + meterId;
                stmt = con1.createStatement();
                rs1 = stmt.executeQuery(sql1);
                if (rs1.next()) {
                    mf = rs1.getDouble("mf") == 0 ? 1 : rs1.getDouble("mf");
                    imf = rs1.getDouble("imf") == 0 ? 1 : rs1.getDouble("imf");
                    //mf = mf * imf;
                    //mf = imf;
                }
                //mf = 1.0;

                System.out.println("------------------------------- Single Day Graph Not Applying MF -------------------------------------");
                //not applying multiplication factor
                
                if (emf.equals("0")) {
                mf = imf;
                } else {
                mf = mf * imf;
                }
                 
                //mf new logic end

                sql = "select distinct d4_date,to_char(to_date(d4_date,'DD-MM-YYYY HH24:MI:SS'),'HH24:MI') time, data_string from d4_data d4 where d4.cdfid in (select cdfid from meter_data_time_stamp where meterid=" + meterId + ")and to_char(to_date(d4_date,'DD-MM-YYYY HH24:MI:SS'),'DD/MM/YYYY') = '" + sdate + "'  order by to_timestamp(d4_date,'dd/mm/yyyy hh24:mi:ss')";
                System.out.println("sql s" + sql);
                st = con1.createStatement();
                rs = st.executeQuery(sql);
                int headerLen = data_string2.length;
                int dataStringLen = 0;
                NumberFormat decFormat = new DecimalFormat("#0.00");
                while (rs.next()) {
                    time = time + rs.getString(2) + ",";
                    string_data = rs.getString(3);

                    //logic for proper d4 string data length
                    dataStringLen = string_data.split(",").length;
                    if (headerLen == dataStringLen) {
                        //nothing to do
                    } else if (headerLen > dataStringLen) {
                        System.out.println("Data String Len is Less than to Columns Header :" + string_data);
                        for (int i = dataStringLen; i < headerLen; i++) {
                            string_data = string_data + "0" + ",";
                        }//end for
                        System.out.println("Final Data String :" + string_data);
                    } else {
                        System.out.println("Data String Len is Greater than to Columns Header :" + string_data);
                        String[] sdArr = string_data.split(",");
                        string_data = "";
                        for (int i = 0; i < headerLen; i++) {
                            string_data = string_data + sdArr[i] + ",";
                        }//end for
                        System.out.println("Final Data String :" + string_data);
                    }//end else

					//old logic
					/*
                    for (int i = 0; i < string_data.split(",").length; i++) {
                        if (data_string2[i].toLowerCase().equals("vr") || data_string2[i].toLowerCase().equals("vy") || data_string2[i].toLowerCase().equals("vb")
                                || data_string2[i].toLowerCase().equals("lr") || data_string2[i].toLowerCase().equals("ly") || data_string2[i].toLowerCase().equals("lb")
                                || data_string2[i].toLowerCase().contains("avg") || data_string2[i].toLowerCase().contains("unknown")) {
                            //don't apply mf for these values
                            //params[i] = string_data.split(",")[i];
                            params[i] = params[i] + "," + decFormat.format((Double.parseDouble(string_data.split(",")[i])*mf));
                        } else {
                            //params[i] = params[i] + "," + Double.parseDouble(string_data.split(",")[i]) * mf;
                            //params[i] = "" + decFormat.format( (Double.parseDouble(decFormat.format( Double.parseDouble( string_data.split(",")[i] ) ) ) * mf ) );
                            params[i] = params[i] + "," + decFormat.format((Double.parseDouble(string_data.split(",")[i])*mf));
                        }//end else
                    }//end for
					*/

					//new logic
                    for (int i = 0; i < string_data.split(",").length; i++) {
                        if (data_string2[i].toLowerCase().equals("avg_voltage")) {
                            params[i] = "" + decFormat.format((Double.parseDouble(string_data.split(",")[i]) * 0.3));
                        } else if (data_string2[i].toLowerCase().equals("avg_current")) {
                            params[i] = "" + decFormat.format((Double.parseDouble(string_data.split(",")[i]) * 400));
                        } else if (data_string2[i].toLowerCase().equals("vr") || data_string2[i].toLowerCase().equals("vy") || data_string2[i].toLowerCase().equals("vb") || data_string2[i].toLowerCase().equals("lr") || data_string2[i].toLowerCase().equals("ly") || data_string2[i].toLowerCase().equals("lb")) {
                            //don't apply mf for these values
                            params[i] = string_data.split(",")[i];
                        } else {
                            double val = Double.parseDouble(string_data.split(",")[i]) * mf;
                            params[i] = "" + decFormat.format(val);
                        }//end else
                    }//end for
                }//end while

                if (time.lastIndexOf(",") > 0) {
                    time = time.substring(0, time.lastIndexOf(","));
                }
                data = "time" + "," + time;
                for (int j = 0; j <= string_data.split(",").length - 1; j++) {

                    data = data + ";" + data_string2[j] + params[j];

                }//end for
                data = data.substring(0, data.length() - 1);
                out.println(data);
                //System.out.println(" load survay graph values are------>"+data);
            } catch (Exception e) {
                e.printStackTrace();
            }
finally{
    con1.close();
}

%>