<%@ include file="getConnection.jsp"%>
<%!
PreparedStatement pstmt=null;
  //Statement pstmt = null;
%>
  <%
String meterid=request.getParameter("meterid");
String meterSerilNo=request.getParameter("metersno");
String metermake=request.getParameter("metermake");
String meterloc=request.getParameter("meterloc");
String prog_PT_PRI=request.getParameter("prog_PT_PRI");
String prog_PT_SEC=request.getParameter("prog_PT_SEC");
String prog_CT_PRI=request.getParameter("prog_CT_PRI");
String prog_CT_SEC=request.getParameter("prog_CT_SEC");
String meterClass=request.getParameter("meterClass");
String meterRating=request.getParameter("meterRating");
String meterType=request.getParameter("meterType");
String meterScaling=request.getParameter("meterScaling");
String meterProg=request.getParameter("meterProg");
String meter_Cum_Count=request.getParameter("meter_Cum_Count");
String man_name=request.getParameter("man_name");
String man_Code=request.getParameter("man_Code");
String rst_Count=request.getParameter("rst_Count");
String mios_Mem_Id=request.getParameter("mios_Mem_Id");
String meter_Add_Info=request.getParameter("meter_Add_Info");
String meter_Timestamp=request.getParameter("meter_Timestamp");
String Log_Timestamp=request.getParameter("Log_Timestamp");
String modem_Serial_No=request.getParameter("modem_Serial_No");
String modem_Imei=request.getParameter("modem_Imei");







//pstmt=con.createStatement();
String vsql="insert into METER(METERID,METER_SERIAL_NO,PROG_PT_PRI,PROG_PT_SEC,PROG_CT_PRI,PROG_CT_SEC,METER_CLASS,METER_RATING,METER_TYPE,METER_SCALING,METER_PROG,METER_CUM_COUNT,MAN_NAME,MAN_CODE,CUM_MAX_DMD_RST_COUNT,MIOS_MEM_ID,METER_ADD_INFO,METER_TIMESTAMP,LOG_TIMESTAMP,MODEM_SERIAL_NO,MODEM_IMEI) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
//String vsql="delete from METER where METERID=44";
//String vsql="insert into METER(METERID,METER_SERIAL_NO,PROG_PT_PRI,PROG_PT_SEC,PROG_CT_PRI,PROG_CT_SEC,PROG_CT_SEC,METER_CLASS,METER_TYPE,METER_SCALING	,METER_PROG,METER_PROG,MAN_NAME,MAN_NAME,MAN_CODE,CUM_MAX_DMD_RST_COUNT,MIOS_MEM_ID,METER_ADD_INFO,METER_ADD_INFO,LOG_TIMESTAMP,MODEM_SERIAL_NO,MODEM_IMEI) values(?,?)";

pstmt=con.prepareStatement(vsql);

//MPB01157
pstmt.setString(1, meterid);
pstmt.setString(2, meterSerilNo);
pstmt.setString(3, prog_PT_PRI);
pstmt.setString(4, prog_PT_SEC);
pstmt.setString(5, prog_CT_PRI);
pstmt.setString(6, prog_CT_SEC);
pstmt.setString(7, meterClass);
pstmt.setString(8, meterRating);
pstmt.setString(9, meterType);
pstmt.setString(10, meterScaling);
pstmt.setString(11, meterProg);
pstmt.setString(12, meter_Cum_Count);
pstmt.setString(13, man_name);
pstmt.setString(14, man_Code);
pstmt.setString(15, rst_Count);
pstmt.setString(16, mios_Mem_Id);
pstmt.setString(17, meter_Add_Info);
pstmt.setString(18, meter_Timestamp);
pstmt.setString(19, Log_Timestamp);
pstmt.setString(20, modem_Serial_No);
pstmt.setString(21, modem_Imei);
//pstmt.setString(2, meterSerilNo);
pstmt.executeUpdate();
con.close();


%>
Successfully Stored Data in the Database ..........
<a href="<%=response.encodeRedirectURL("Meter.jsp")%>" style="position:absolute;top:100px;left:300px;">Back</a>