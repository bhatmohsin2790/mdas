     <%@page import="java.sql.*"%>
        <%@page import="java.io.*"%>
        <%@page import="in.amitech.db.DBUtil"%>
      
    </head>
    <body>
        <div style="height:450px">
            <table style="padding-top:70px" >
           
            <tr>
                <td><form name="dayDetails">
                    
                        <table>
                            <tr>
                                    
                         <td id="rtd" >
    Select Date:</td><td style="padding-top:0px;">
    <input type="text" readonly="true" size="10" name="startingDate" id="startingDate" style="border:1px solid #666666;"/>
            
    <a href="javascript:show_calendar('dayDetails.startingDate')"> <img src="images/cal1.gif" id="sdate"  width=24 height=22 border=0/></a>
            </td></tr>
                            <tr>
                <td align="left">DISCOM :</td>
                <td >  <select name="discom" id ="discom" style="width:150px;height:20px;font-size:12px;font-family:verdana;border:1px solid #666666;"
                    onChange="showZones(this.value);">
                <option value="-1">Select DISCOM</option>
                <%
                                Connection con = new DBUtil().getConnection();
                                PreparedStatement pstmt = null;
                                ResultSet rs = null;
                                try {
                                    pstmt = con.prepareStatement("select * from discom");
                                    rs = pstmt.executeQuery();
                                    while (rs.next()) {
                %>
                <option value="<%=rs.getString("discom_id")%>"><%=rs.getString("discom_name")%></option>
                <%
                                    }

                                } catch (Exception e) {
                                    e.printStackTrace();
                                }
                %>
            </select>
        </td>
    </tr>
            <tr>
                <td align="left">Zone :</td>
                <td> <select name="zone" id ="zone" style="width:150px;height:20px;font-size:12px;font-family:verdana;border:1px solid #666666;"
                    onChange="showCircles(this.value);">
                <option value="-1">Select Zone</option>

            </select>
        </td>
    </tr>

            <tr>
                <td align="left">
                    Circle :</td>
                <td> <select name="circle" id="circle" style="width:150px;height:20px;font-size:12px;font-family:verdana;border:1px solid #666666;"
                            onChange="showDivisions(this.value);">
                        <option value="-1">Select Circle</option>

                    </select>
                </td>
            </tr>
            <tr>
                <td align="left">
                   Division :</td>
                <td> <select name="division" id="division" style="width:150px;height:20px;font-size:12px;font-family:verdana;border:1px solid #666666;"
                            onChange="showSubDivisions(this.value);">
                        <option value="-1">Select Division</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td align="left">
                    Sub Division :</td>
                <td> <select name="subdivision" id="subdivision" style="width:150px;height:20px;font-size:12px;font-family:verdana;border:1px solid #666666;"
                            onChange="showSections(this.value);">
                        <option value="-1">Select Sub_Division</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td align="left">
                    Section :</td>
                <td> <select name="section" id ="section" style="width:150px;height:20px;font-size:12px;font-family:verdana;border:1px solid #666666;"
                            onChange="showSubStations(this.value);">
                        <option value="-1">Select Section</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td align="left">
                    Substation :</td>
                <td> <select name="substation" id="substation" style="width:150px;height:20px;font-size:12px;font-family:verdana;border:1px solid #666666;"
                            onChange="showFeeders(this.value);">
                        <option value="-1">Select SubStation</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td align="left">
                    Feeder :</td>
                    <!-- showDTRs(this.value,2) 2-ht 0-feeder 1-dtr -->
                    <td> <select name="feeder" id="feeder" style="width:150px;height:20px;font-size:12px;font-family:verdana;border:1px solid #666666;"
                            onChange="showDTRs(this.value,1);">
                        <option value="-1">Select Feeder</option>
                    </select>
                </td>
            </tr>
                        </table>
                    </form>
                </td>
                <td><a href="javascript:showDayWiseDetails();"><img src="images/hand.jpeg" id="hand"  width=24 height=22 border=0/></a></td>
                <td  style="width:1px;background-color:#ddd;" height="100"></td>
            </tr>


        </table>
                   
    </div>
    </body>
</html>

      