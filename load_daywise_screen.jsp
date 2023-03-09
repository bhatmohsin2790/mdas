<%@ page session="false" %>
<form name="loadgraphs">
    <table id="lsgdate" ><tr><td  >
    Select Date:
    <input type="text" readonly="true" size="10" name="startingDate" id="loadgraphDate" style="border:1px solid #666666;"/>
    <a href="javascript:show_calendar('loadgraphs.startingDate')"> <img src="images/cal1.gif" id="lsdate"  width=24 height=22 border=0/></a>
    &nbsp;
     <input type="checkbox" name="chbMF" id="chbMF" />Apply MF
	 &nbsp;

    <input type="radio" value="1" name="loadGraph" onclick="getLoadGraph(this.value);"/>Line Graph &nbsp;&nbsp;&nbsp;
    <input type="radio"  value="2" name="loadGraph" onclick="getLoadGraph(this.value);"/>Bar Chart
            </td>
        </tr>
        <tr><td></td></tr>
        <tr><td colspan="3" style="height:1px;background-color:#ddd;" ></td></tr>
    </table></form>