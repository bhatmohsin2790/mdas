<%@ page session="false" %>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="in.amitech.db.DBUtil"%>
<script type="text/javascript" src="date-picker.js"></script>

      <%
                               Connection con = new DBUtil().getConnection();
                                PreparedStatement pstmt = null;
                                ResultSet rs = null;
              %>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <form name="HT"  action="">
            <div id="hone">
              <table    bgcolor="#E0ECF8" cellpadding="5" cellspacing="5" width="350px">
                  <tr><th colspan="2" ><h2><u> Select HT Consumer to Change</u></h2></th></tr>&nbsp;
                  		<tr>
                      <td>Zone name:</td>
                      <td>
                       <select name="zone" id="zone" style="width:150px;height:20px;font-size:12px;font-family:verdana;" onchange="showCircles(this.value);">

                         <option value="-1">Select Zone</option>
                          <%

                                try {
                                    pstmt = con.prepareStatement("select * from zone");
                                    rs = pstmt.executeQuery();
                                    while (rs.next()) {
                    %>
                <option value="<%=rs.getString("zoneid")%>"><%=rs.getString("zonename")%></option>
          <%
                                    }

                                } catch (Exception e) {
                                    e.printStackTrace();
                                    con.close();
                                }
                    %>


                       </select>
                      </td></tr>
                                <tr>

                      <td>Circle name:</td>
                      <td>
                          <select name="circle" id="circleId" style="width:150px;height:20px;font-size:12px;font-family:verdana;" onchange="showTowns(this.value);">

                         <option value="-1">Select Circle</option>


                       </select>
                      </td>
                  </tr>
                  <tr>

                      <td>Town name:</td>
                      <td>
                          <select name="town" id="townId" style="width:150px;height:20px;font-size:12px;font-family:verdana;" onchange="showDivisions(this.value);">

                         <option value="-1">Select Town</option>


                       </select>
                      </td>
                  </tr>
 		<tr>
                      <td>Select Division : </td>



                       <td>
                       <select name="divisionname" id="divisionId" style="width:150px;height:20px;font-size:12px;font-family:verdana;" onchange="showSubDivisions(this.value);">

                         <option value="-1">Select division</option>


                       </select>
                      </td></tr>
                <tr>
                      <td>Select SubDivision : </td>
                       <td>
                           <select name="subdivisionname" id="subdivisionId" style="width:150px;height:20px;font-size:12px;font-family:verdana;" onchange="showSubstations(this.value);">

                         <option value="-1">Select subdivision</option>


                       </select>
                      </td>
                  </tr>
		
                <tr>

                      <td align="left">Select SubStation : </td>


                       <td>
                       <select name="ss" id="ssId" style="width:150px;height:20px;font-size:12px;font-family:verdana;" onchange="showFeeders(this.value);">

                         <option value="-1">Select substation</option>


                       </select>
                      </td>
                  </tr>

		<tr>
                      <td align="left">Select Feeder : </td>


                       <td>
                       <select name="feeder" id="feederId" style="width:150px;height:20px;font-size:12px;font-family:verdana;" onchange="showHT(this.value);">

                         <option value="-1">Select Feeder</option>


                       </select>
                      </td>


                  </tr>
                  <tr>
                      <td align="left">Select HT : </td>


                       <td>
                           <select name="ht" id="htId" style="width:150px;height:20px;font-size:12px;font-family:verdana;"  onchange="oldHT();">

                         <option value="-1">Select HT</option>


                       </select>
                      </td>


                  </tr>
              </table>
            </div>
                    <div id="htwo" style="visibility:hidden;position:absolute;top:250px;left:450px" >
                        <table bgcolor="#E0ECF8" >
                            <tr><th colspan="4" ><h2><u> Update HT Consumer</u></h2></th></tr>&nbsp;
                            <tr>
                                <td>ConsumerId:</td>
                                <td><input type="text" id ="newHtId" readonly></td>
                            
                                <td>Change HTName:</td>
                                <td><input type="text" id="htname"></td>
                            </tr>
                             <tr>
                                <td>Address:</td>
                                <td><input type="text" id ="newHtAddress" ></td>

                                <td>MobileNo:</td>
                                <td><input type="text" id="newMobileNo"></td>
                            </tr>
                             <tr>
                                <td>PhoneNo:</td>
                                <td><input type="text" id ="newPhoneNo" ></td>

                                <td>Email Id:</td>
                                <td><input type="text" id="newEmailId"></td>
                            </tr>
                             <tr>
                                <td>Alt Email:</td>
                                <td><input type="text" id ="newAltEmail" ></td>

                                <td>Consession:</td>
                                <td><input type="text" id="newConsession"></td>
                            </tr>
                             <tr>
                                <td>AgrmntFromDate:</td>
                                <td><input type="text" readonly="true" size="10" name="startingDate" id="startingDate"/>
		      <a href="javascript:show_calendar('HT.startingDate')"> <img src="images/cal.gif" id="sdate"  width=24 height=22 border=0/></a>
	              </td>

                                <td>AgrmntToDate:</td>
                                <td><input type="text" readonly="true" size="10" name="endingDate" id="endingDate"/>
		     <a href="javascript:show_calendar('HT.endingDate')"> <img src="images/cal.gif" id="edate"  width=24 height=22 border=0/></a>
	             </td>
                            </tr>
                             <tr>
                                <td>Conletter NO:</td>
                                <td><input type="text" id ="newConletterNo" ></td>

                                <td>Rebate:</td>
                                <td><input type="text" id="Rebate"></td>
                            </tr>
                            <tr>
                                <td>Select Feeder:</td>
                                <td>
                                    <select name="newfeeder" id="newfeeder" style="width:150px;height:20px;font-size:12px;font-family:verdana;">

                         <option value="-1">Select Feeder</option>
                                </td>
                            </tr>


                  <tr >
                      <td></td>

                      <td colspan="2"><input type="button" value="update " onclick="newHT()"  /></td>
                  </tr>


              </table>
                    </div>
          </form>
    </body>
</html>
