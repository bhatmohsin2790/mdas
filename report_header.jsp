<%@page import="in.amitech.db.DBUtil"%>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ page language="java" import="java.sql.*" %>
<style>
    #headerTable{
        font-size: 11px;
        margin-bottom: 10px;
    }
    #headerTable td {
        padding:0px !important;
    }
	.dt-button{
        padding:2px 6px !important;
    }
</style>    

<%
            Connection con2 = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;
            try {
                con2 = new DBUtil().getConnection();
              } catch (Exception e) {
                System.out.println(e.getMessage());
               }
%>
<%
String category="";
            try {
                String meter_id2 = "";
    if(request.getParameter("meter_id")==null ||  request.getParameter("meter_id")=="")
       {
    meter_id2 = (String)session.getAttribute("meter_id");
    }else
       meter_id2 = request.getParameter("meter_id");
    session.setAttribute("meter_id",meter_id2);
    //System.out.println("ID in header=========>"+meter_id2);
    //code to get metertype and metermake
	//System.out.println("*********************************** OLD QUERY ***************************************");
    //pstmt = con2.prepareStatement("select G15,G22 from d1 where cdfid=(select max(CDFID) from d1 where METERID=?)");
	System.out.println("*********************************** NEW QUERY ***************************************");
	  pstmt = con2.prepareStatement("select G15,G22 from d1_report_header where  METERID=?");
	  
    pstmt.setString(1, meter_id2);
    rs = pstmt.executeQuery();
    String meter_type = "";String meterLocation="";
    String g22 = ""; //previously used for meter make
    try{
    if(rs.next())
        {
        meter_type = rs.getString("G15");
        g22 = rs.getString("G22");
        }
    else
    { }
    g22 = g22.substring(g22.indexOf("_")+1);
    g22 = g22.replace("LNT", "L&T");
    g22=g22.replace("_", " ");
    }catch(Exception e){ }
  // code to get meter location (ht/dtr/feeder)
    pstmt = con2.prepareStatement("SELECT ml.locationname,meter_serial_no,category from meter m,meterlocation ml where m.meterlocation=ml.locationid and meterid=?");
    pstmt.setString(1, meter_id2);
    rs = pstmt.executeQuery();
    if(rs.next()){
        meterLocation=rs.getString(1);
        category=rs.getString("category");
               }
%>

<%
   if(meterLocation.toUpperCase().equals("FEEDER"))
   {
    String sql_4_meter_details ="select m.meter_serial_no,mk.metermakename,c.circlename,d.divisionname,sd.subdivname,t.townname,"
            + "ss.substationname,f.feedername,m.meter_ctr,m.meter_ptr,m.adopted_ctr,m.adopted_ptr,m.mf,m.location_code,m.consumerid from meter m,metermake mk,circle c,division d,subdivision sd,town t,substation ss,feeder f "
            + "where m.metermake=mk.metermakeid and m.feederid=f.feederid and  f.substationid=ss.substationid and ss.subdivid=sd.subdivid and sd.divisionid=d.divisionid and d.townid=t.townid and t.circleid=c.circleid and m.meterid="+meter_id2;
    
    pstmt = con2.prepareStatement(sql_4_meter_details);
    rs = pstmt.executeQuery();	
    if (rs.next()) {
		
%>
<table width="100%" border="0" id="headerTable">
    <tr >
        <td colspan="8" align="center" bgcolor="#e0ecf8">
            METER INFORMATION
        </td>
    </tr>
    <tr>
        <td width="120px" bgcolor="#e0ecf8"><b>Circle</b></td><td class="meter_info_td2"><%=rs.getString(3)%></td>
        <td width="120px"bgcolor="#e0ecf8" style="font-weight:bold;">Division</td><td class="meter_info_td2"><%=rs.getString(4)%></td>
        <td width="120px" bgcolor="#e0ecf8" style="font-weight:bold;">SubDivision</td><td class="meter_info_td2"><%=rs.getString(5)%></td>
        <td bgcolor="#e0ecf8" width="120px" style="font-weight:bold;">Substation</td><td class="meter_info_td2"><%=rs.getString(7)%></td>                 
    </tr><tr>
        <td width="120px" bgcolor="#e0ecf8" style="font-weight:bold;">Town</td><td class="meter_info_td2"><%=rs.getString(6)%></td> 
        <td width="120px" bgcolor="#e0ecf8" style="font-weight:bold;">Feeder Name</td><td width="200px" class="meter_info_td2"><%=rs.getString(8)%></td>
        <td width="120px" bgcolor="#e0ecf8" style="font-weight:bold;">Meter ID</td><td class="meter_info_td2"><%=rs.getString(1)%></td>
        <td width="120px" bgcolor="#e0ecf8" style="font-weight:bold;">Meter Make</td><td class="meter_info_td2"><%=category==null?" ":category%></td>  
    </tr>
    <tr>
        <td width="120px" bgcolor="#e0ecf8" style="font-weight:bold;">METER CTR,PTR</td><td class="meter_info_td2"><%=rs.getString(9)+","+rs.getString(10)%></td> 
        <td width="120px" bgcolor="#e0ecf8" style="font-weight:bold;">Adopted CTR,PTR</td><td class="meter_info_td2"><%=rs.getString(11)+","+rs.getString(12)%></td> 
        <td width="120px" bgcolor="#e0ecf8" style="font-weight:bold;">MF</td><td class="meter_info_td2"><%=rs.getString(13)%></td> 
        <td width="120px" bgcolor="#e0ecf8" style="font-weight:bold;">Loc.Code, Cons.Id</td><td class="meter_info_td2"><%=rs.getString(14)==null?" ":rs.getString(14)+","+(rs.getString(15)==null?" ":rs.getString(15))%></td> 
    </tr>
</table>

<%
          }//if
     } //FEEDER   
     if(meterLocation.toUpperCase().equals("HT"))
   {
         //System.out.println("In HT meter---->");
    String sql_4_meter_details ="select m.meter_serial_no,mk.metermakename,c.circlename,d.divisionname,sd.subdivname,t.townname,"
            + "ss.substationname,f.feedername,ht.consumername,m.meter_ctr,m.meter_ptr,m.adopted_ctr,m.adopted_ptr,m.mf,m.location_code,m.consumerid from meter m,metermake mk,circle c,division d,subdivision sd,town t,"
            + "substation ss,feeder f,ht_consumer ht where m.metermake=mk.metermakeid and m.htconsumerid=ht.consumerid and "
            + "ht.feederid=f.feederid and f.substationid=ss.substationid and ss.subdivid=sd.subdivid and"
            + " sd.divisionid=d.divisionid and d.townid=t.townid and t.circleid=c.circleid and m.meterid="+meter_id2;
    
    //System.out.println("For meter details "+sql_4_meter_details);
    pstmt = con2.prepareStatement(sql_4_meter_details);
    rs = pstmt.executeQuery();	
    if (rs.next()) {
		
%>
<table width="100%" border="0" id="headerTable">
    <tr >
        <td colspan="8" align="center" bgcolor="#e0ecf8">
            METER INFORMATION
        </td>
    </tr>
    <tr>
        <td width="120px" bgcolor="#e0ecf8"><b>Circle</b></td><td class="meter_info_td2"><%=rs.getString(3)%></td>
        <td width="120px"bgcolor="#e0ecf8" style="font-weight:bold;">Division</td><td class="meter_info_td2"><%=rs.getString(4)%></td>
        <td width="120px" bgcolor="#e0ecf8" style="font-weight:bold;">SubDivision</td><td class="meter_info_td2"><%=rs.getString(5)%></td>
        <td bgcolor="#e0ecf8" width="120px" style="font-weight:bold;">Town</td><td class="meter_info_td2"><%=rs.getString(6)%></td>                 
    </tr><tr>        
        <td width="120px" bgcolor="#e0ecf8" style="font-weight:bold;">Feeder Name</td><td width="200px" class="meter_info_td2"><%=rs.getString(8)%></td>
        <td width="120px" bgcolor="#e0ecf8" style="font-weight:bold;">Consumer Name</td><td class="meter_info_td2"><%=rs.getString(9)%></td>
        <td width="120px" bgcolor="#e0ecf8" style="font-weight:bold;">Meter ID</td><td class="meter_info_td2"><%=rs.getString(1)%></td>
        <td width="120px" bgcolor="#e0ecf8" style="font-weight:bold;">Meter Make</td><td class="meter_info_td2"><%=category==null?" ":category%></td>  
    </tr>
    <tr>
        <td width="120px" bgcolor="#e0ecf8" style="font-weight:bold;">METER CTR,PTR</td><td class="meter_info_td2"><%=rs.getString(10)+","+rs.getString(11)%></td> 
        <td width="120px" bgcolor="#e0ecf8" style="font-weight:bold;">Adopted CTR,PTR</td><td class="meter_info_td2"><%=rs.getString(12)+","+rs.getString(13)%></td> 
        <td width="120px" bgcolor="#e0ecf8" style="font-weight:bold;">MF</td><td class="meter_info_td2"><%=rs.getString(14)%></td> 
         <td width="120px" bgcolor="#e0ecf8" style="font-weight:bold;">Loc.Code,Cons.Id</td><td class="meter_info_td2"><%=rs.getString(15)==null?" ":rs.getString(15)+","+(rs.getString(16)==null?" ":rs.getString(16))%></td> 
    </tr>
</table>

<%
          }//if
     } //HT   
    if(meterLocation.toUpperCase().equals("DTR"))
   {
    String sql_4_meter_details ="select m.meter_serial_no,mk.metermakename,c.circlename,d.divisionname,sd.subdivname,t.townname,"
            + "ss.substationname,f.feedername,dt.dtrname,m.meter_ctr,m.meter_ptr,m.adopted_ctr,m.adopted_ptr,m.mf,m.location_code,m.consumerid from meter m,metermake mk,circle c,division d,subdivision sd,town t,"
            + "substation ss,feeder f,dtr dt where m.metermake=mk.metermakeid and m.dtrid=dt.dtrid and dt.feederid=f.feederid and "
            + "f.substationid=ss.substationid and ss.subdivid=sd.subdivid and sd.divisionid=d.divisionid and "
            + "d.townid=t.townid and t.circleid=c.circleid and m.meterid="+meter_id2;
    //System.out.println("dtr query--->"+sql_4_meter_details);
    pstmt = con2.prepareStatement(sql_4_meter_details);
    rs = pstmt.executeQuery();	
    if (rs.next()) {
		
%>
<table width="100%" border="0" id="headerTable">
    <tr >
        <td colspan="8" align="center" bgcolor="#e0ecf8">
            METER INFORMATION
        </td>
    </tr>
    <tr>
        <td width="120px" bgcolor="#e0ecf8"><b>Circle</b></td><td class="meter_info_td2"><%=rs.getString(3)%></td>
        <td width="120px"bgcolor="#e0ecf8" style="font-weight:bold;">Division</td><td class="meter_info_td2"><%=rs.getString(4)%></td>
        <td width="120px" bgcolor="#e0ecf8" style="font-weight:bold;">SubDivision</td><td class="meter_info_td2"><%=rs.getString(5)%></td>
        <td bgcolor="#e0ecf8" width="180px" style="font-weight:bold;">Town</td><td class="meter_info_td2"><%=rs.getString(6)%></td>                 
    </tr><tr>        
        <td width="120px" bgcolor="#e0ecf8" style="font-weight:bold;">Feeder Name</td><td width="200px" class="meter_info_td2"><%=rs.getString(8)%></td>
        <td width="120px" bgcolor="#e0ecf8" style="font-weight:bold;">DTR Name</td><td class="meter_info_td2"><%=rs.getString(9)%></td>
        <td width="120px" bgcolor="#e0ecf8" style="font-weight:bold;">Meter ID</td><td class="meter_info_td2"><%=rs.getString(1)%></td>
        <td width="180px" bgcolor="#e0ecf8" style="font-weight:bold;">Meter Make</td><td class="meter_info_td2"><%=category==null?" ":category%></td>  
    </tr> 
    <tr>
        <td width="120px" bgcolor="#e0ecf8" style="font-weight:bold;">METER CTR,PTR</td><td class="meter_info_td2"><%=rs.getString(10)+","+rs.getString(11)%></td> 
        <td width="120px" bgcolor="#e0ecf8" style="font-weight:bold;">Adopted CTR,PTR</td><td class="meter_info_td2"><%=rs.getString(12)+","+rs.getString(13)%></td> 
        <td width="120px" bgcolor="#e0ecf8" style="font-weight:bold;">MF</td><td class="meter_info_td2"><%=rs.getString(14)%></td> 
        <td width="180px" bgcolor="#e0ecf8" style="font-weight:bold;">Loc.Code,Cons.Id</td><td class="meter_info_td2"><%=rs.getString(15)==null?" ":rs.getString(15)+","+(rs.getString(16)==null ?" ":rs.getString(16))%></td> 
    </tr>
</table>

<%
          }//if
     } //DTR   
            
            } catch (Exception e) {
                
                e.printStackTrace();
            }

%>