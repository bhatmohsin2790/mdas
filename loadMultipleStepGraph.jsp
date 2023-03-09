<%@page import="in.amitech.db.DBUtil"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@page import="java.io.FileWriter"%>
<%@page import="java.io.BufferedWriter"%>
<%@page import="java.io.File"%>
<%!     PreparedStatement pstmt = null;
    ResultSet rs = null;

%>
<%          String  paramValues="";
            int tickInt=0;
			String paramNames="";
        	 String datesString = "dates,";
            Connection con = new DBUtil().getConnection();
            try {

                System.out.println();
                System.out.println("***********************Loading Multiple Step Graph Data Start*****************************************");
                String meter_id = "", sql = null, data = "";
                double mf = 1.0,vmf=1.0,cmf=1.0;
                String string_data = "";
                String[] data_string2 = new String[0];
                String[] data_string = new String[0];
                String lsdate = request.getParameter("sdate");
                String ledate = request.getParameter("edate");
                //mf param
                String emf = request.getParameter("EMF");

                if (request.getParameter("meter_id") == null || request.getParameter("meter_id") == "") {
                    meter_id = (String) session.getAttribute("meter_id");
                    System.out.println("Meter ID for Same Meter :" + meter_id);
                } else {
                    meter_id = request.getParameter("meterid");
                    System.out.println("Meter ID :" + meter_id);
                }
                session.setAttribute("meter_id", meter_id);

                //mf new logic start
                Statement stmt = null;
                ResultSet rs1 = null;
                double imf = 1.0;
                String sql1 = "select *  from meter where meterid=" + meter_id;
                stmt = con.createStatement();
                rs1 = stmt.executeQuery(sql1);
                if (rs1.next()) {
                    mf = rs1.getDouble("mf") == 0 ? 1 : rs1.getDouble("mf");
                    imf = rs1.getDouble("imf") == 0 ? 1 : rs1.getDouble("imf");
                    vmf=rs1.getDouble("adopted_ptr")/rs1.getDouble("meter_ptr");
                    //cmf=rs1.getDouble("adopted_ctr")/rs1.getDouble("meter_ctr");
					String ACTR=rs1.getString("adopted_ctr");
					System.out.println("ACTR --> "+ACTR);
					if(ACTR.contains("/")){
					    String numerator = ACTR.substring(0,ACTR.indexOf("/"));
						String denominator = ACTR.substring(ACTR.indexOf("/")+1);
					    double cal_result = Double.valueOf(numerator)/Double.valueOf(denominator);
						cmf=(cal_result)/rs1.getDouble("meter_ctr");
					}else{
					    cmf=rs1.getDouble("adopted_ctr")/rs1.getDouble("meter_ctr");
					}						
                    //mf = mf * imf;
                    //mf = imf;
                }

                System.out.println("------------------------------- Single Day Graph Not Applying MF -------------------------------------");
                //applying multiplication factor

                if (emf.equals("0")) {
                    mf = imf; vmf=1.0; cmf=1.0;
                } else {
                    mf = mf * imf; vmf=vmf; cmf=cmf;
                }//end else

                System.out.println("*****************applicable multiplication factor-------" + mf);
           if(meter_id.equals("00"))
               {
                String header="Fwd.kVAh,Fwd.kWh,Fwd.kVArh Lag,Fwd.kVArh Lead,RV,YV,BV,RI,YI,VI";
                data_string2=header.split(",");
               }
              else{
                pstmt = con.prepareStatement("select * from d4_columns_header where meter_serial_no=(select meter_serial_no from meter where meterid=" + meter_id + ")");
                rs = pstmt.executeQuery();
                if (rs.next()) {
                    System.out.println("---------------------------Load survay Header Got Dynamically-----------------------------------");
                    data_string2 = rs.getString("load_columns_header").split(",");
                } else {
                    System.out.println("---------------------------Load survay Header Got Manually-----------------------------------");
                    pstmt = con.prepareStatement("select no_of_params,d4_params from metermake where metermakeid=(select metermake from meter where meterid=" + meter_id + ")");
                    rs = pstmt.executeQuery();

                    if (rs.next()) {
                        data_string2 = rs.getString("d4_params").split(",");
                    }//end if
                }//end else
               }

                /*
                //System.out.println("*****************default multiplication factor-------" + mf);
                pstmt = con.prepareStatement("select imf from meter where meterid=" + meter_id);
                rs = pstmt.executeQuery();
                if (rs.next()) {
                mf = Double.parseDouble((rs.getString("imf")));
                }
                 */

                System.out.println("------------------------------- Multiple Day Graph -------------------------------------");
%>
<%
                if (!lsdate.equals("") && !ledate.equals("")) {
                    //------------------------------
                    int MILLIS_IN_DAY = 1000 * 60 * 60 * 24;
                    SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
                    java.util.Date edate;

                    edate = (java.util.Date) dateFormat.parse(ledate);

                    Calendar cal = Calendar.getInstance();
                    cal.setTime(edate);
                    cal.add(cal.DATE, 1);
                    String afterDate = cal.get(cal.DATE) + "/" + (cal.get(cal.MONTH) + 1) + "/" + cal.get(cal.YEAR);
                    System.out.println(" after one day is ----" + afterDate);
                    // String nextDate =dateFormat.format(cal.getTime(edate)+ MILLIS_IN_DAY);
                    //------------------------------
                    if (DBUtil.getTargetDB().equals("oracle")) {
                    sql = "select distinct d4_date, data_string,TIME_DELAY from d4_data d4 where d4.cdfid in (select cdfid from meter_data_time_stamp where meterid=?)and to_date(d4_date,'dd/mm/yyyy hh24:mi:ss')>to_date('" + lsdate + " 00:00:00','dd/mm/yyyy hh24:mi:ss') and to_date(d4_date,'dd/mm/yyyy hh24:mi:ss')<=to_date('" + afterDate + " 00:00:00','dd/mm/yyyy hh24:mi:ss') and data_string is NOT NULL order by to_timestamp(d4_date,'dd/mm/yyyy hh24:mi:ss'),TIME_DELAY  ";
                    } else if (DBUtil.getTargetDB().equals("mysql")) {
                        sql="select distinct d4_date, data_string,TIME_DELAY from d4_data d4 where d4.cdfid in (select cdfid from meter_data_time_stamp where meterid=?)and str_to_date(d4_date,'%d-%m-%Y')>str_to_date('" + lsdate + " 00:00:00','%d/%m/%Y %H:%i:%S') and str_to_date(d4_date,'%d-%m-%Y')<=str_to_date('" + afterDate + " 00:00:00','%d/%m/%Y %H:%i:%S') and data_string is NOT NULL order by d4_time_stamp,TIME_DELAY  ";
                    }
                } else {
                }
                System.out.println(sql);
                pstmt = con.prepareStatement(sql);
                pstmt.setString(1, meter_id);
                rs = pstmt.executeQuery();



                String p[] = {"p1", "p2", "p3", "p4", "p5", "p6", "p7", "p8", "p9", "p10"};
                Map paramMap = new HashMap();

                for (int i = 0; i < p.length; i++) {
                    try {
                        paramMap.put(p[i], data_string2[i]);
                    } catch (Exception e) {
                        paramMap.put(p[i], p[i]);
                    }//end catch
                }//end for
                String p2 = "p2";
                String p3 = "p3";
                String p4 = "p4";
                String p5 = "p5";
                String p6 = "p6";
                List totalData = new ArrayList();
                String prevDate = null;
                String d4Date = null;
                String params[] = {"", "", "", "", "", "", "", "", "", ""};

                String paramVals[] = {"", "", "", "", "", "", "", "", "", ""};


                int timeDelay = 0;
                boolean found = false;
                String dataSep = ",";
                int count = 0;
                List d4TotalDateLs = new ArrayList();

                int headerLen = data_string2.length;
                int dataStringLen = 0;
                NumberFormat decFormat = new DecimalFormat("#0.00");
                while (rs.next()) {
                    string_data = rs.getString("data_string");

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

                    timeDelay = rs.getInt("TIME_DELAY");
                    d4TotalDateLs.add(rs.getString("d4_date"));
                    if (prevDate == null) {
                        prevDate = rs.getString("d4_date").split(" ")[0];
                        for (int i = 0; i < string_data.split(",").length; i++) {
                            paramVals[i] = "";

                        }
                        count = 0;
                    }
                    found = false;
                    d4Date = rs.getString("d4_date").split(" ")[0];

                    //old
                    /*
                    for (int i = 0; i < string_data.split(",").length; i++) {
                    //params[i] = "" + (Double.parseDouble(string_data.split(",")[i]) * mf);
                    //params[i]=string_data.split(",")[i];
                    //params[i] = decFormat.format(Double.parseDouble(string_data.split(",")[i]));
                    params[i] = decFormat.format(Double.parseDouble(string_data.split(",")[i]) * mf);

                    }//end for
                     */
                    //new logic
                    for (int i = 0; i < string_data.split(",").length; i++) {
                        if (data_string2[i].toLowerCase().equals("avg_voltage")) {
                            params[i] = "" + decFormat.format((Double.parseDouble(string_data.split(",")[i]) * vmf));
                        } else if (data_string2[i].toLowerCase().equals("avg_current")) {
                            params[i] = "" + decFormat.format((Double.parseDouble(string_data.split(",")[i]) * cmf));
                        } else if (data_string2[i].toLowerCase().equals("vr") || data_string2[i].toLowerCase().equals("vy") || data_string2[i].toLowerCase().equals("vb") ) {
                           params[i] = decFormat.format(Double.parseDouble(string_data.split(",")[i]) * vmf);
                        } 
                         else if ( data_string2[i].toLowerCase().equals("lr") || data_string2[i].toLowerCase().equals("ly") || data_string2[i].toLowerCase().equals("lb")) {
                          params[i] = decFormat.format(Double.parseDouble(string_data.split(",")[i]) * cmf);
                        } 
                        else {
                            double val = Double.parseDouble(string_data.split(",")[i]) * mf;
                            params[i] = "" + decFormat.format(val);
                        }//end else
                    }//end for

                    if (prevDate.equals(d4Date)) {
                        //System.out.println(d4Date + ":" + timeDelay);
                        for (int i = 0; i < string_data.split(",").length; i++) {
                            //paramVals[i] = "" + (Double.parseDouble(paramVals[i]) + Double.parseDouble(params[i]));
                            paramVals[i] = "" + paramVals[i] + dataSep + params[i];

                        }
                        count++;

                    } else {
                        //System.out.println("************New Date Found**************");

                        //count++;
                        found = true;
                        for (int i = 0; i < string_data.split(",").length; i++) {
                            totalData.add(p[i] + dataSep + prevDate + dataSep + paramVals[i] + dataSep + count);

                        }
                        //System.out.println(prevDate + ":" + timeDelay);
                        prevDate = rs.getString("d4_date").split(" ")[0];
                        for (int i = 0; i < string_data.split(",").length; i++) {
                            paramVals[i] = "";
                        }//end for

                        //old logic
                        /*
                        for (int i = 0; i < string_data.split(",").length; i++) {
                        //paramVals[i] = "" + (Double.parseDouble(paramVals[i]) + Double.parseDouble(params[i]));
                        //params[i] = decFormat.format(Double.parseDouble(params[i]));
                        params[i] = decFormat.format(Double.parseDouble(string_data.split(",")[i]) * mf);
                        paramVals[i] = "" + paramVals[i] + dataSep + params[i];
                        }//end for
                         */
                        for (int i = 0; i < string_data.split(",").length; i++) {
                            if (data_string2[i].toLowerCase().equals("avg_voltage")) {
                                params[i] = "" + decFormat.format((Double.parseDouble(string_data.split(",")[i]) * vmf));
                            } else if (data_string2[i].toLowerCase().equals("avg_current")) {
                                params[i] = "" + decFormat.format((Double.parseDouble(string_data.split(",")[i]) * cmf));
                            } else if (data_string2[i].toLowerCase().equals("vr") || data_string2[i].toLowerCase().equals("vy") || data_string2[i].toLowerCase().equals("vb")) {
                                params[i] = decFormat.format(Double.parseDouble(string_data.split(",")[i]) * vmf);
                            } 
                             else if (data_string2[i].toLowerCase().equals("lr") || data_string2[i].toLowerCase().equals("ly") || data_string2[i].toLowerCase().equals("lb")) {
                                params[i] = decFormat.format(Double.parseDouble(string_data.split(",")[i]) * cmf);
                            } 
                            else {
                                double val = Double.parseDouble(string_data.split(",")[i]) * mf;
                                params[i] = "" + decFormat.format(val);
                            }//end else
                            paramVals[i] = "" + paramVals[i] + dataSep + params[i];
                        }//end for
                        count = 0;
                    }//end else

                }//end while


                if (found == false) {
                    for (int i = 0; i < string_data.split(",").length; i++) {
                        totalData.add(p[i] + dataSep + prevDate + dataSep + paramVals[i] + dataSep + count);

                    }//endfor
                }//end if


%>


<%
                String str = null;
                String[] strArr = null;
                List dateLs = new ArrayList();
                String paramType = null;
                String paramsData[] = {"", "", "", "", "", "", "", "", "", ""};
                String paramVal = "0";

                //System.out.println("tatal Data is --->" + totalData);

                Map dateMap = new HashMap();
                Map totalDataMap = new HashMap();
                String mapData = null;

                List totalDataLs = new ArrayList();
                String date = null;


                for (int i = 0; i < totalData.size(); i++) {
                    str = (String) totalData.get(i);
                    //System.out.println("****************************8");
                    //System.out.println(str);
                }//end for


                String paramData = null;

                for (int i = 0; i < totalData.size(); i++) {
                    str = (String) totalData.get(i);



                    strArr = str.split(",");
                    paramType = "";
                    paramVal = "0";
                    paramData = "";
                    for (int j = 0; j < strArr.length; j++) {
                        //System.out.println(strArr[j]);

                        if (j == strArr.length - 1) {
                            //total interval count
                            count = Integer.parseInt(strArr[j]);
                            dateMap.put(date, "" + count);
                            paramData = paramData.substring(0, paramData.lastIndexOf(","));
                            if (totalDataMap.containsKey(paramType)) {
                                mapData = (String) totalDataMap.get(paramType);
                                mapData = mapData + dataSep + paramData;
                                totalDataMap.put(paramType, mapData);
                            } else {
                                totalDataMap.put(paramType, paramData);
                            }//end else
                        } else if (j == 0) {
                            paramType = strArr[j];
                        } else if (j == 1) {

                            date = strArr[j];
                            if (!dateLs.contains(strArr[j])) {
                                dateLs.add(strArr[j]);
                            }
                        } else if (j == 2) {
                            paramVal = strArr[j];
                            //paramData=paramVal+dataSep;
                        } else {
                            paramVal = strArr[j];
                            paramData = paramData + paramVal + dataSep;
                        }

                    }//end j for


                }//end for

                System.out.println("***********************Map Data End*****************************************");

                for (Iterator it = totalDataMap.keySet().iterator(); it.hasNext();) {
                    String key = (String) it.next();
                    String val = (String) totalDataMap.get(key);
                    //System.out.println(key+":"+val);
                }//end for


               
                /*
                for(Iterator it=dateMap.keySet().iterator();it.hasNext();){
                String key=(String)it.next();
                int  val=Integer.parseInt((String)dateMap.get(key));
                //System.out.println(key+":"+val);
                for(int i=0;i<val;i++){
                datesString=datesString+key+dataSep;
                }//end for

                }//end for
                 * */

                for (int i = 0; i < d4TotalDateLs.size(); i++) {
                    //System.out.println(d4TotalDateLs.get(i));
                    datesString = datesString + (String) d4TotalDateLs.get(i) + dataSep;
                }//end for

                for (Iterator it = totalDataMap.keySet().iterator(); it.hasNext();) {
                    String key = (String) it.next();
                    String val = (String) totalDataMap.get(key);
                    key = (String) paramMap.get(key);
                    datesString = datesString + ";" + key + dataSep + val;
                }//end for


                //out.println(datesString);
%>

<% } catch (Exception e) {

                e.printStackTrace();
            }
%>
<%
 for(int  i=0;i<datesString.split(";").length;i++)
            {
                  paramNames= paramNames + datesString.split(";")[i].substring(0,datesString.split(";")[i].indexOf(","))+",";

                  paramValues=paramValues + datesString.split(";")[i].substring(datesString.split(";")[i].indexOf(","))+";";
            }
			
			 if(paramValues.split(";")[0].substring(1).split(",").length<=768)
				  tickInt=48;
			 if (paramValues.split(";")[0].substring(1).split(",").length>768)
			     tickInt=48*5;
          
		 // out.println(paramNames);

		  String[] param_names_arr = paramNames.split(",");
		 // out.println(param_names_arr.length);
		 // out.println("");
		  // out.println(paramValues);
		   String[] dates_arr = paramValues.split(";")[0].substring(1).split(",");
%>

		<script type="text/javascript" src="js2/jquery.min.js"></script>
		<script type="text/javascript" src="js2/highstock.js"></script>
                <script type="text/javascript">
                    
                    
                    var chart;
                    
                    $(document).ready(function() {
                        chart = new Highcharts.Chart({
                            chart: {
                                renderTo: 'container',
                                defaultSeriesType: 'line',
                                width:window.size
                                
                            },
                            title: {
                                text: 'Graph for Multiple Days'
                                
                            },
                            
                            xAxis: {
                                tickInterval: <%= tickInt%>,
                                //tickInterval:1,
                                
                                categories: [<% for (int dates_i = 0; dates_i < dates_arr.length - 1; dates_i++) {
                                                                        out.print("'" + dates_arr[dates_i].replaceAll("-", "/") + "',");
                                                                    }%>],
                                                                                        
                                                                                        labels:
                                                                                            {
                                                                                            enabled:true
                                                                                        }
                                                                                        
                                                                                        
                                                                                    },
                                                                                    yAxis: {
                                                                                        title: {
                                                                                            text: 'Values'
                                                                                        }
                                                                                        
                                                                                        
                                                                                    },
                                                                                    plotOptions: {
                                                                                        line: {
                                                                                            lineWidth:1,
                                                                                            marker: {
                                                                                                enabled: false
                                                                                            }
                                                                                        }
                                                                                    },
                                                                                    tooltip: {
                                                                                        formatter: function() {
                                                                                            return '<b>'+this.x +'</b><br/> '+ this.y +'';
                                                                                        }
                                                                                    },
                                                                                    legend: {
                                                                                        layout: 'vertical',
                                                                                        align: 'right',
                                                                                        verticalAlign: 'middle',
                                                                                        x:10,
                                                                                        y:-10, 
                                                                                        shadow: true,
                                                                                        borderWidth: 1
                                                                                    },
                                                                                    scrollbar: {     enabled: false },             
                                                                                    series:[
                    <%
                                                                    for (int pa = 1; pa < param_names_arr.length; pa++) {
                    %>
                                        {name : <%="'" + param_names_arr[pa] + "'"%>,
                                            data:[<%
                                                                            String[] val_arr = paramValues.split(";")[pa].split(",");
                                                                            for (int k2 = 1; k2 < val_arr.length; k2++) {
                                                                                out.print(val_arr[k2] + ",");
                                                                            }
                    %>]}
                    <%
                                                                                                if (pa != paramValues.split(";").length - 1) {
                                                                                                    out.print(",");
                                                                                                }
                                                                                            }
                    %>	
                                            ]
                                        });
                                    });
                </script>
		
	</head>
	<body>
		
		<!-- 3. Add the container -->
		<div id="container" style="width: 100%; height: 400px; margin: 0;"></div>
		
				
	</body>
</html>
