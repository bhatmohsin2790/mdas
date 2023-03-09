<%@page import="in.amitech.db.DBUtil"%>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ page language="java" import="java.sql.*" %>
<%

	String user=null;
	String usertype=null;
	String zones=null;
	String circles=null;
	String divisions=null;
	String subdivisions=null;
	String substations=null;
	String feeders=null;
	String dtrs=null;
	String consumers=null;
	String meters=null;
	String feedercurrentdata=null;
	String feedertotaldata=null;
	String feederreports=null;
	String dtrcurrentdata=null;
	String dtrtotaldata=null;
	String dtrreports=null;
        session=request.getSession(false);
%>

	<%
            user=(String)(session.getAttribute("userid"));
            usertype=(String)(session.getAttribute("user_type"));
        %>


<%


	Connection con=null;
	ResultSet rst=null;
	ResultSet rst1=null;
	Statement stmt=null;
	Statement stmt1=null;


	try{
                con = new DBUtil().getConnection();
		stmt=con.createStatement();
	}
	catch(Exception e){
		System.out.println(e.getMessage());
	}

		rst=stmt.executeQuery("SELECT * FROM user_privileges where user_id= '"+user+"'");
		if(rst.next()){
			zones=rst.getString("zones");
			circles=rst.getString("circles");
			divisions=rst.getString("divisions");
			subdivisions=rst.getString("subdivisions");
			substations=rst.getString("substations");
			feeders=rst.getString("feeders");
			dtrs=rst.getString("dtrs");
			consumers=rst.getString("consumers");
			meters=rst.getString("meters");
			feedercurrentdata=rst.getString("feedercurrentdata");
			feedertotaldata=rst.getString("feedertotaldata");
			feederreports=rst.getString("feederreports");
			dtrcurrentdata=rst.getString("dtrcurrentdata");
			dtrtotaldata=rst.getString("dtrtotaldata");
			dtrreports=rst.getString("dtrreports");
		}//end if
                try{
                    rst.close();
                    stmt.close();
                    con.close();
                    }catch(Exception e){
                        }//end catch
		%>

<ul id="nav">
	<li class="top"><a href="#" id="products" class="top_link"><span class="down">Master Data</span></a>
		<ul class="sub">
			<%
                        if(zones.equals("1")){
                        %>
                        <li><a href="ZonesList.do">Zones </a></li>
                        <%	}
                        else
                        {
                        %>
                        <li><a href="Noprivilege.do">Zones </a></li>
                        <%
                        }
                        if(circles.equals("1")){
                        %>
                        <li><a href="CirclesList.do">Circles </a></li>
                        <%	}
                        else
                        {
                        %>
                        <li><a href="Noprivilege.do">Circles </a></li>
                        <%
                        }
                        if(divisions.equals("1")){
                        %>
                        <li><a href="DivisionsList.do">Divisions </a></li>
                        <%	}
                        else
                        {
                        %>
                        <li><a href="Noprivilege.do">Divisions </a></li>
                        <%
                        }
                        if(subdivisions.equals("1")){
                        %>
                        <li><a href="SubDivisionsList.do">Sub Divisions </a></li>
                        <%	}
                        else
                        {
                        %>
                        <li><a href="Noprivilege.do">Sub Divisions </a></li>
<%
	}
	if(substations.equals("1")){
%>

<li><a href="SubStationsList.do">Sub Stations </a></li>
<%	}
	else
	{
%>
<li><a href="Noprivilege.do">Sub Stations </a></li>
<%
	}
	if(feeders.equals("1")){
%>

<li><a href = "FeedersList.do">Feeders </a></li>
<%	}
	else
	{
%>
<li><a href="Noprivilege.do">Feeders </a></li>
<%
	}
	if(dtrs.equals("1")){
%>

<li><a href = "DtrsList.do">DTRs </a></li>
<%	}
	else
	{
%>
<li><a href="Noprivilege.do">DTRs </a></li>
                        <%
                        }
                        if(consumers.equals("1")){
                        %>
                        <li><a href="#" class="fly">Consumers</a>
                            <ul>
				<li><a href="HTConsumersList.do">HT Consumers</a></li>
                                <li><a href="ConsumersList.do">LT Consumers</a></li>
                            </ul>
                        </li>

<%	}
	else
	{
%>
<li><a href="Noprivilege.do">Consumers </a></li>
<%
	}
	if(meters.equals("1")){
%>

<li><a href = "MetersList.do">Meters </a></li>
<%	}
	else
	{
%>
<li><a href="Noprivilege.do">Meters </a></li>
<%
	}
%>
		</ul>
	</li>
	<li class="top"><a href="TreeStructure1.do" id="services" class="top_link"><span>Meter-Tree Structure</span></a></li>
        <%
        //if usertype is admin
	if(usertype.equals("admin")){
        %>
        <li class="top"><a href="UsersList.do" id="services" class="top_link"><span>User Management</span></a></li>
        <%
	}
        %>
	<li class="top"><a href="#nogo27" id="contacts" class="top_link"><span class="down">Reports</span></a>
		<ul class="sub">
			<li><a href="#nogo28" class="fly">Sub-station</a>
                            <ul>
					<li><a href ="Hierarchy.do">Feeder wise Data Report</a></li>
                                        <li><a href="MRDs.do">Meter Details</a></li>
                                        <li><a href="PeekLoadData.do">Peek Load</a></li>
                                        <li><a href="VoltageReports.do">Voltage Data</a></li>
                            </ul>
                        </li>
			<li><a href="#nogo29" class="fly">Feeder</a>
				<ul>
					<li><a href="#nogo30">Feeder OnDemand Data</a></li>
					<li><a href="#nogo31">Total Data</a></li>
					<li><a href="#nogo32">Status Report</a></li>
					<li><a href="#nogo47">Meter Details </a></li>
					<li><a href="#nogo48">Peek Load </a></li>
                                        <li><a href="#nogo48">Demand Trends</a></li>
                                        <li><a href="#nogo48">Min Max Data</a></li>
                                        <div style="display:none;"><li><a href="#nogo48" class="fly">Periodic Reports</a>
                                            <ul>
                                                <li><a href="#nogo30">All Parameters Report</a></li>
                                                <li><a href="#nogo31">Average Load Factor</a></li>
                                                <li><a href="#nogo32">Consumption Reports</a></li>
                                                <li><a href="#nogo47">Energy Data Report</a></li>
                                                <li><a href="#nogo47">Instantaneous Data Report</a></li>
                                            </ul>
                                        </li>
                                        </div>
                                        <li><a href="#nogo48">Common Data Format</a></li>
                                        <li><a href="#nogo48">SLD</a></li>
                                        <li><a href="#nogo48">Alerts</a></li>
                                        <li><a href="#nogo48">Events</a></li>
				</ul>
			</li>
			<li><a href="#nogo29" class="fly">DTR</a>
                            <ul>
					<li><a href="#nogo30">DTR OnDemand Data</a></li>
					<li><a href="#nogo31">Total Data</a></li>
					<li><a href="#nogo47">Meter Details </a></li>
                                        <li><a href="#nogo48">Demand Trends</a></li>
                                        <li><a href="#nogo48">Peek Load </a></li>
                                        <div style="display:none;"> <li><a href="#nogo48" class="fly">Periodic Reports</a>
                                            <ul>
                                                <li><a href="#nogo30">All Parameters Report</a></li>
                                                <li><a href="#nogo31">Average Load Factor</a></li>
                                                <li><a href="#nogo32">Consumption Reports</a></li>
                                                <li><a href="#nogo47">Energy Data Report</a></li>
                                                <li><a href="#nogo47">Instantaneous Data Report</a></li>
                                            </ul>
                                        </li>
                                        </div>
                                        <li><a href="#nogo48">Common Data Format</a></li>
                                        <li><a href="#nogo48">Alerts</a></li>
                                        <li><a href="#nogo48">Events</a></li>
				</ul>
                        </li>
			<li><a href="#nogo50" class="fly">Consumer</a>
                            <ul>
					<li><a href="#">Current Data</a></li>
					<li><a href="#">Total Data</a></li>
					<li><a href="#">Peek Load</a></li>
					<li><a href="#">Common Data Format</a></li>
					<li><a href="consumeralerts.do">Alerts</a></li>
                                        <li><a href="consumerEvents.do">Events</a></li>
                                        <li><a href="ConsConsumption.do">Consumer Consumption</a></li>
                            </ul>
                        </li>
		</ul>
	</li>
	<li class="top"><a href="LoadMeterDiagnosis.do" id="shop" class="top_link"><span>Meter Diagnosis</span></a></li>
        
	<li class="top"><a href="#" id="privacy" class="top_link"><span class="down">Configuration</span></a>
            <ul class="sub">
                <li><a href="./LoadMasterNumConfig.do">Master Number</a></li>
                <li><a href="./networkConfig.do">Network</a></li>
                <li><a href="./dcunetworkConfig.do">DCU Network</a></li>
                <li><a href="./LoadLocationConfig.do">Location</a></li>
                <li><a href="./mobileConfig.do">Mobile Number</a></li>
            </ul>
        </li>
        <li class="top"><a href="ftp://122.169.243.224/" target="_blank" id="privacy" class="top_link"><span>FTP Files</span></a></li>
</ul>
