
<%@ page session="false" %>
<%@page import="java.sql.Connection"%>
<%@page import="in.amitech.db.DBUtil"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%
            String meterLoc = request.getParameter("meterLoc");
            HttpSession sess=request.getSession(false);
            String office_type=sess.getAttribute("office_type").toString();
            String office_type_id=sess.getAttribute("office_type_id").toString();
            System.out.println(office_type+"\t"+office_type_id);
            String sql="";            
            if (meterLoc.equals("dtr")) 
            {
%>

<table border="0" width="150px">
   <!-- <tr>
        <td>You Have Selected <%=meterLoc.toUpperCase()%></td>
    </tr> -->
    <tr>
        <td align="left"><b>DISCOM :</b>
            <select name="discom" id ="discom" style="width:150px;height:20px;font-size:12px;font-family:verdana;"
                    onChange="">
                <option value="16">JKPDD</option>                
            </select>
        </td>
    </tr>
    <tr>
        <td align="left">
            <b>Circle :</b>
            <select name="circle" id="circle" style="width:150px;height:20px;font-size:12px;font-family:verdana;"
                    onChange="showTowns(this.value);">
                <option value="0">Select Circle</option>
                <%
                                Connection con = new DBUtil().getConnection();
                                PreparedStatement pstmt = null;
                                ResultSet rs = null;
                                try {
                                    if(office_type.equals("SDO"))
                                            sql="select circleid,circlename from circle where circleid in(select circleid from town where townid in(select townid from division where divisionid in(select divisionid from subdivision where subdivid="+office_type_id+")))";
                                        else
                                            sql="select circleid,circlename from circle";
                                    pstmt = con.prepareStatement(sql);
                                    rs = pstmt.executeQuery();
                                    while (rs.next()) {
                %>
                <option value="<%=rs.getString("circleid")%>"><%=rs.getString("circlename")%></option>
                <%
                                    }
                                } catch (Exception e) {
                                    e.printStackTrace();
                                }
                                finally{
                                    con.close();
                                }
                %>
            </select>
        </td>
    </tr>
    <tr>
        <td align="left">
            <b>Town :</b>
            <select name="town" id="townid" style="width:150px;height:20px;font-size:12px;font-family:verdana;"
                    onChange="showDivisions(this.value);">
                <option value="0">Select town</option>
            </select>
        </td>
    </tr>
    <tr>
        <td align="left">
            <b>Division :</b>
            <select name="division" id="divisionid" style="width:150px;height:20px;font-size:12px;font-family:verdana;"
                    onChange="showSubDivisions(this.value);">
                <option value="0">Select Division</option>
            </select>
        </td>
    </tr>    
    <tr>
        <td align="left">
            <b>Sub Division :</b>
            <select name="subdivision" id ="subdivision" style="width:150px;height:20px;font-size:12px;font-family:verdana;"
                    onChange="showSubStations(this.value);">
                <option value="0">Select Sub Division</option>
            </select>
        </td>
    </tr>
    <tr>
        <td align="left">
            <b>Receiving Station :</b>
            <select name="substation" id="substation" style="width:150px;height:20px;font-size:12px;font-family:verdana;"
                    onChange="showFeeders(this.value);">
                <option value="0">Select Receiving Station</option>
            </select>
        </td>
    </tr>
    <tr>
        <td align="left">
            <b>Feeder :</b>
            <!-- showDTRs(this.value,2) 2-ht 0-feeder 1-dtr -->
            <select name="feeder" id="feeder" style="width:150px;height:20px;font-size:12px;font-family:verdana;"
                    onChange="showDTRs(this.value,1);">
                <option value="0">Select Feeder</option>
            </select>
        </td>
    </tr>
    <tr>
        <td align="left">
            <b>Search By :</b>
            <select name="searchBy" id="searchBy" style="width:150px;height:20px;font-size:12px;font-family:verdana;"
                    onChange="">
                <option value="meter">Meter slno</option>
                <option value="name">Location Name</option>
                <option value="code">Location Code</option>
            </select>
        </td>
    </tr>
<tr>
        <td align="left">
            <h4><input type="text" name="meterSearchId" id="meterSearchId" maxlength="8" style="width:150px"/></h4>
        </td>
    </tr>
    <tr>
        <td align="left">
            <h4><input type="button" value="Search Meter(s)" onclick="javascript:searchForMeters('<%=meterLoc %>')"/></h4>
        </td>
    </tr>
    <tr>
        <td align="left">
            <select name="dtr" id="dtr" style="width:190px;font-size:12px;font-family:verdana;" size="12" onChange="getDataReportsInstantData(this.value);">
            </select>
        </td>
    </tr>
</table>

<%}//end of DTR
  else if (meterLoc.equals("feeder")) 
  {
%>

<table border="0" width="150px">
   <!-- <tr>
        <td>You Have Selected <%=meterLoc.toUpperCase()%></td>
    </tr> -->
    <tr>
        <td align="left"><b>DISCOM :</b>
            <select name="discom" id ="discom" style="width:150px;height:20px;font-size:12px;font-family:verdana;"
                    onChange="">
                <option value="16">JKPDD</option>
                
            </select>
        </td>
    </tr>
  
    <tr>
        <td align="left">
            <b>Circle :</b>
            <select name="circle" id="circle" style="width:150px;height:20px;font-size:12px;font-family:verdana;"
                    onChange="showTowns(this.value);">
                <option value="0">Select Circle</option>
                <%
                                Connection con = new DBUtil().getConnection();
                                PreparedStatement pstmt = null;
                                ResultSet rs = null;
                                try 
                                {
                                    if(office_type.equals("SDO"))
                                           sql="select circleid,circlename from circle where circleid in(select circleid from town where townid in(select townid from division where divisionid in(select divisionid from subdivision where subdivid="+office_type_id+")))";
                                        else
                                            sql="select circleid,circlename from circle";
                                    pstmt = con.prepareStatement(sql);
                                    rs = pstmt.executeQuery();
                                    while (rs.next()) 
                                    {
                %>
                <option value="<%=rs.getString("circleid")%>"><%=rs.getString("circlename")%></option>
                <%
                                    }
                                } 
                                catch (Exception e) 
                                {
                                    e.printStackTrace();
                                }
                                finally{
                                    con.close();
                                }
                %>
            </select>
        </td>
    </tr>
    <tr>
        <td align="left">
            <b>Town :</b>
            <select name="town" id="townid" style="width:150px;height:20px;font-size:12px;font-family:verdana;"
                    onChange="showDivisions(this.value);">
                <option value="0">Select Town</option>
            </select>
        </td>
    </tr>
    <tr>
        <td align="left">
            <b>Division :</b>
            <select name="division" id="divisionid" style="width:150px;height:20px;font-size:12px;font-family:verdana;"
                    onChange="showSubDivisions(this.value);">
                <option value="0">Select Division</option>
            </select>
        </td>
    </tr>
   <tr>
        <td align="left">
            <b>Sub Division :</b>
            <select name="subdivision" id ="subdivision" style="width:150px;height:20px;font-size:12px;font-family:verdana;"
                    onChange="showSubStations(this.value);">
                <option value="0">Select Subdivision</option>
            </select>
        </td>
    </tr>
    <tr>
        <td align="left">
            <b>Receiving Station :</b>
            <select name="substation" id="substation" style="width:150px;height:20px;font-size:12px;font-family:verdana;"
                    onChange="showDTRs(this.value,0);">
                <option value="0">Select Receiving Station</option>
            </select>
        </td>
    </tr>
     <tr>
        <td align="left">
            <b>Search By :</b>
            <select name="searchBy" id="searchBy" style="width:150px;height:20px;font-size:12px;font-family:verdana;"
                    onChange="">
                <option value="meter">Meter slno</option>
                <option value="name">Location Name</option>
                <option value="code">Location Code</option>
            </select>
        </td>
    </tr>
<tr>
        <td align="left">
            <h4><input type="text" name="meterSearchId" id="meterSearchId" maxlength="8" style="width:150px" /></h4>
        </td>
    </tr>
    <tr>
        <td align="left">
            <h4><input type="button" value="Search Meter(s)" onclick="javascript:searchForMeters('<%=meterLoc %>')"/></h4>
        </td>
    </tr>

    <tr>
        <td align="left">
            <select name="dtr" id="dtr" style="width:190px;font-size:12px;font-family:verdana;" size="12" onChange="getDataReportsInstantData(this.value);">
            </select>
        </td>
    </tr>
</table>

<%}
    else if (meterLoc.equals("ht")) 
    {
%>

<table border="0" width="150px">
   <!-- <tr>
        <td>You Have Selected <%=meterLoc.toUpperCase()%></td>
    </tr> -->
    <tr>
        <td align="left"><b>DISCOM :</b>
            <select name="discom" id ="discom" style="width:150px;height:20px;font-size:12px;font-family:verdana;">                    
                <option value="16">JKPDD</option>                
            </select>
        </td>
    </tr>
    <tr>
        <td align="left">
            <b>Circle :</b>
            <select name="circle" id="circle" style="width:150px;height:20px;font-size:12px;font-family:verdana;"
                    onChange="showTowns(this.value);">
                <option value="0">Select Circle</option>
               <%
                                Connection con = new DBUtil().getConnection();
                                PreparedStatement pstmt = null;
                                ResultSet rs = null;
                                try 
                                {
                                        if(office_type.equals("SDO"))
                                        {
                                            sql="select circleid,circlename from circle where circleid in(select circleid from town where townid in(select townid from division where divisionid in(select divisionid from subdivision where subdivid="+office_type_id+")))";
                                        }
                                        else
                                        {
                                            sql="select circleid,circlename from circle"; 
                                        }                                                  
                                        System.out.println("sql--=========->"+sql);
               							 pstmt = con.prepareStatement(sql);
                                        rs = pstmt.executeQuery();
                                        while (rs.next()) 
                                        {
                %>
                <option value="<%=rs.getString("circleid")%>"><%=rs.getString("circlename")%></option>
                <%
                                        }
                                } catch (Exception e) {
                                    e.printStackTrace();
                                }
                                finally{
                                    con.close();
                                }
                %>
            </select>
        </td>
    </tr>
    <tr>
        <td align="left">
            <b>Town :</b>
            <select name="town" id="townid" style="width:150px;height:20px;font-size:12px;font-family:verdana;"
                    onChange="showDivisions(this.value);">
                <option value="0">Select Town</option>
            </select>
        </td>
    </tr>
    <tr>
        <td align="left">
            <b>Division :</b>
            <select name="division" id="divisionid" style="width:150px;height:20px;font-size:12px;font-family:verdana;" onChange="showSubDivisions(this.value);">
                <option value="0">Select Division</option>
            </select>
        </td>
    </tr>
    <tr>
        <td align="left">
            <b>SubDivision :</b>
            <select name="subdivisions" id ="subdivision" style="width:150px;height:20px;font-size:12px;font-family:verdana;"
                    onChange="showSubStations(this.value);">
                <option value="0">Select SubDivision</option>
            </select>
        </td>
    </tr>

    <tr>
        <td align="left">
            <b>Receiving Station :</b>
            <select name="substation" id="substation" style="width:150px;height:20px;font-size:12px;font-family:verdana;"
                    onChange="showFeeders(this.value);">
                <option value="0">Select Receiving Station</option>
            </select>
        </td>
    </tr>
    <tr>
        <td align="left">
            <b>Feeder :</b>
            <!-- showDTRs(this.value,2) 2-ht 0-feeder 1-dtr -->
            <select name="feeder" id="feeder" style="width:150px;height:20px;font-size:12px;font-family:verdana;"
                    onChange="showDTRs(this.value,2);">
                <option value="0">Select Feeder</option>
            </select>
        </td>
    </tr>
     <tr>
        <td align="left">
            <b>Search By :</b>
            <select name="searchBy" id="searchBy" style="width:150px;height:20px;font-size:12px;font-family:verdana;"
                    onChange="">
                <option value="meter">Meter slno</option>
                <option value="name">Location Name</option>
                <option value="code">Location Code</option>
            </select>
        </td>
    </tr>
<tr>
        <td align="left">
            <h4><input type="text" name="meterSearchId" id="meterSearchId" maxlength="8" style="width:150px" /></h4>
        </td>
    </tr>
    <tr>
        <td align="left">
            <h4><input type="button" value="Search Meter(s)" onclick="javascript:searchForMeters('<%=meterLoc %>')"/></h4>
        </td>
    </tr>
    <tr>
        <td align="left">
            <select name="dtr" id="dtr" style="width:190px;font-size:12px;font-family:verdana;" size="12" onChange="getDataReportsInstantData(this.value);">
            </select>
        </td>
    </tr>
</table>

<%            }//end else if
%>