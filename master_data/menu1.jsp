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
	<li class="top"><a href="<%=response.encodeRedirectURL("masterdata.jsp")%>" id="products" class="top_link"><span class="top_link">Master Data</span></a>
		
	</li>
	<li class="top"><a href="TreeStructure1.do" id="services" class="top_link"><span>Meter Management</span></a></li>
        <%
        //if usertype is admin
	if(usertype.equals("admin")){
        %>
        <li class="top"><a href="<%=response.encodeRedirectURL("userManage.jsp")%>" id="services" class="top_link"><span>User Management</span></a></li>
        <%
	}
        %>
	<li class="top"><a href="#nogo27" id="contacts" class="top_link"><span class="down">Reports</span></a>
		<ul class="sub">
			
			<li><a href="#nogo29" >Feeder</a>
				
			</li>
			<li><a href="<%=response.encodeRedirectURL("dtrReports.jsp")%>" >DTR</a>
                            
                        </li>
			<li><a href="#nogo50" >Consumer</a>
                            
                        </li>
		</ul>
	</li>
	<li class="top"><a href="<%=response.encodeRedirectURL("master_data/ModemDiagnosis.jsp")%>" id="shop" class="top_link"><span>Modem Diagnosis</span></a></li>
        
	<li class="top"><a href="#" id="privacy" class="top_link"><span class="down">Configuration</span></a>
            <ul class="sub">
                <li><a href="<%=response.encodeRedirectURL("integration.jsp")%>">DOTA & POTA Sms</a></li>
                <li><a href="<%=response.encodeRedirectURL("configurationReports.jsp")%>">SMS Tracking</a></li>
                <li><a href="<%=response.encodeRedirectURL("OnDemandIntReports.jsp")%>">OnDemand Track</a></li>
                <li><a href="<%=response.encodeRedirectURL("modemStatusReports.jsp")%>">ModemStatus Track</a></li>
                
            </ul>
        </li>
        <li class="top"><a href="ftp://122.169.243.224/" target="_blank" id="privacy" class="top_link"><span>FTP Files</span></a></li>
</ul>
