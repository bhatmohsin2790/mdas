<%@ page session="false" %>
<form name="eventScreen" >

    <table cellpadding="5" cellspacing="5">

        <tr id="line">

            <td colspan="6">
                <table><tr>
                        <td style="padding-right:20px"><input type="checkbox" name="allevent" id="select" onclick="selectall(this)"/>Select All</td>
                        <td  colspan="2" > From Date:
                            <input type="text" readonly="true" size="10" name="startingDate" id="eventsDate" style="border:1px solid #666666;"/></td>
                        <td style="padding-top:0px;padding-right:10px">
                            <a href="javascript:show_calendar('eventScreen.startingDate')"> <img src="images/cal1.gif" id="sdate"  width=24 height=22 border=0/></a></td>



                        <td colspan="2">To Date:
                            <input type="text" readonly="true" size="10" name="endingDate" id="eventeDate" style="border:1px solid #666666;"/></td>
                        <td style="padding-top:1px;" >
                            <a href="javascript:show_calendar('eventScreen.endingDate')"> <img src="images/cal1.gif" id="edate"  width=24 height=22 border=0/></a></td>

                        <td>  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" value="Get Reports" id="events" onclick="getEventsData(1)"/></td>
                        
                      <!--  <td>  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" value="Cumulative Reports" onclick="getEventsData(2)"/></td>  -->
                    </tr></table>
            </td>
        </tr>

        <tr><td colspan="7" style="height:1px;background-color:#ddd;"></td></tr>
        <tr>
            <td><input type="checkbox" name="R-Phase" value="1" onclick="deselect(this);"/> &nbsp;R-Phase Missing Pott </td>
            <td> <input type="checkbox" name="R-Phase" value="24" onclick="deselect(this);"/> &nbsp;R-Phase CT open</td>
            <td> <input type="checkbox" name="R-Phase" value="4" onclick="deselect(this);"/> &nbsp;R-Phase CT Reverse</td>
            <td> <input type="checkbox" name="R-Phase" value="23" onclick="deselect(this);"/> &nbsp;CT Open</td>
            <td> <input type="checkbox" name="R-Phase" value="27" onclick="deselect(this);"/> &nbsp;Magnetic Tamper</td>
            <td><input type="checkbox" name="R-Phase" value="28" onclick="deselect(this);"/> &nbsp;Neutral Distarbance </td>
            <td> <input type="checkbox" name="R-Phase" value="58" onclick="deselect(this);"/> &nbsp;Low Voltage</td>
        </tr>



        <tr><td> <input type="checkbox" name="R-Phase" value="2" onclick="deselect(this);"/> &nbsp;Y-Phase Missing Pott</td>
            <td> <input type="checkbox" name="R-Phase" value="25" onclick="deselect(this);"/> &nbsp;Y-Phase CT open</td>
            <td>  <input type="checkbox" name="R-Phase" value="5" onclick="deselect(this);"/> &nbsp;Y-Phase CT Reverse</td>
            <td>  <input type="checkbox" name="R-Phase" value="11" onclick="deselect(this);"/> &nbsp;Overload(Current) </td>
            <td> <input type="checkbox" name="R-Phase" value="7" onclick="deselect(this);"/> &nbsp;Load Imbalance</td>
            <td>  <input type="checkbox" name="R-Phase" value="19" onclick="deselect(this);"/> &nbsp;CT Short</td>
            <td><input type="checkbox" name="R-Phase" value="33" onclick="deselect(this);"/> &nbsp;High Voltage</td>
        </tr>



        <tr>  <td> <input type="checkbox" name="R-Phase" value="3" onclick="deselect(this);"/> &nbsp;B-Phase Missing Pott</td>
            <td> <input type="checkbox" name="R-Phase" value="26" onclick="deselect(this);"/> &nbsp;B-Phase CT open</td>
            <td> <input type="checkbox" name="R-Phase" value="6" onclick="deselect(this);"/> &nbsp;B-Phase CT Reverse</td>
            <td> <input type="checkbox" name="R-Phase" value="13" onclick="deselect(this);"/> &nbsp;Power Failed</td>
            <td> <input type="checkbox" name="R-Phase" value="14" onclick="deselect(this);"/> &nbsp;Voltage Unbalance</td>
            <td><input type="checkbox" name="R-Phase" value="12" onclick="deselect(this);"/> &nbsp;Very Low PF</td>
            <td><input type="checkbox" name="R-Phase" value="30" onclick="deselect(this);"/> &nbsp;R-Ph current missing</td>
			</tr>

			 <tr>  <td> <input type="checkbox" name="R-Phase" value="31" onclick="deselect(this);"/> &nbsp;Y-Ph current missing</td>
            <td> <input type="checkbox" name="R-Phase" value="32" onclick="deselect(this);"/> &nbsp;B-Ph current missing</td>

        
			</tr>
        
        <tr><td colspan="7" style="height:1px;background-color:#ddd;"></td></tr>

    </table></form>

