<%@ page session="false" %>
<form name="loadmultiplegraphs">
    <table id="multipledate" style="vertical-align: top;">
        <tr>
            <td > From Date:
        <input type="text" readonly="true" size="10" name="startingDate" id="multiplesDate" style="border:1px solid #666666;"/></td>
        <td style="padding-top:0px;padding-right:10px">
    <a href="javascript:show_calendar('loadmultiplegraphs.startingDate')"> <img src="images/cal1.gif" id="sdate"  width=24 height=22 border=0/></a></td>



        <td colspan="2">To Date:
    <input type="text" readonly="true" size="10" name="endingDate" id="multipleeDate" style="border:1px solid #666666;"/></td>
        <td style="padding-top:1px;" >
    <a href="javascript:show_calendar('loadmultiplegraphs.endingDate')"> <img src="images/cal1.gif" id="edate"  width=24 height=22 border=0/></a></td>
    &nbsp;&nbsp;&nbsp;

    <td>
	 <input type="checkbox" name="chbMF" id="chbMF" />Apply MF
	 &nbsp;
    <input type="radio" value="1" name="loadGraph" onclick="getMultipleLoadGraph(this.value);"/>Line Graph &nbsp;&nbsp;&nbsp;
    <input type="radio"  value="2" name="loadGraph"onclick="getMultipleLoadGraph(this.value);"/>Bar Chart
            </td>
        </tr>
        <tr><td></td></tr>
        <tr><td colspan="7" style="height:1px;background-color:#ddd;" ></td></tr>
    </table></form>