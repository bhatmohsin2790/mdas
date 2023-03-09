<%@ page session="false" %>
<link rel="stylesheet" type="text/css" href="css/style.css" />
<form name="dcuDi" action="">
<div id="box_style" style="border: 1px solid #A1A1A1;
    background: #FFFFFF;padding:10px;
    width:auto;
    height:auto;
    margin: 5px;
    float:left;
    display: block;
    -moz-border-radius: 5px;
    -webkit-border-radius: 5px;
    border-radius: 5px;
    -moz-box-shadow: 0 6px 10px #A1A1A1;
    -webkit-box-shadow: 0 6px 10px #A1A1A1;">
    <table border="0" align="left">
    <tr>
                <td>From Date :</td>
                <td>
                    <input type="text" id="fromdate" name="fromdate" size="10" />

    <a href="javascript:show_calendar('dcuDi.fromdate')"> <img src="images/cal1.gif" id="sdate"  width=24 height=22 border=0 /></a>
                </td>
            </tr>
                <tr>
                    <td></td>
                    <td><font color="red">(dd-mm-yyyy)</font></td>
                </tr>
            <tr>
                <td>To Date :</td>
                <td>
                    <input type="text" id="todate" size="10" />
                     <a href="javascript:show_calendar('dcuDi.todate')"> <img src="images/cal1.gif" id="edate"  width=24 height=22 border=0 /></a>
                </td>
            </tr>
            <tr>
                <td colspan="2" align="right"><input type="button" value="Get Report" onclick="getDCU_Loss_Report()" /></td>
            </tr>
        </table></div>
    <div id="DataPart2"  align="center" style="background:#FFFFFF;clear:both;">
                        
                    </div>
</form>