<%@page import="DashBoard.Cpdcl"%>
<style>
    #board tr, #board td
    { border: 1px solid #ddd; border-top: 0;}
    
 
</style>

<div  align="left" style="padding-top:15px">
             <table >
                <tr><td  align="left">
                        <table id="discom" align="center" style="border:0px;" width="175px"><tr >
                                <td align="center" style="background-color:#D8BFD8;" >CPDCL</td>

                </tr></table>
                        </td>

                </tr>
                <tr><td><table style="border-color:#ddd;vertical-align:top" id="board" width="350"border="1" cellpadding="0"cellspacing="0" >
    <tr >
        <td></td>
        <td align="center"  style="background-color:#ddd;">Total</td>
        <td align="center"  style="background-color:#ddd;">Completed</td>
        <td align="center"  style="background-color:#ddd;">Pending</td>
    </tr>
    <tr>
        <td style="padding-left:15px">Modems Installation Report</td>
        <td align="center">500</td>
        <td align="center">300</td>
        <td align="center">200</td>
    </tr>
    <tr>
        <td style="padding-left:15px">RawData Report</td>
        <td align="center">1600</td>
        <td align="center">1500</td>
        <td align="center">100</td>
    </tr>
    <tr><td colspan="4" style="height:5px;background-color:#D8BFD8;"></td></tr>


    <tr>
        <td colspan="2" ></td>
        <td colspan="2" align="center" style="background-color:#ddd;" >Number of Meters</td>
    </tr>
    <tr>
        <td colspan="2"style="padding-left:15px" > Meter Communication Problem</td>
        <td colspan="2" align="center" ><%=DashBoard.Cpdcl.meterCommunication()%></td>
    </tr>
    <tr>
        <td colspan="2" style="padding-left:15px" > Low Voltage Detection</td>
        <td colspan="2" align="center" >50</td>
    </tr>
    <tr>
        <td colspan="2"style="padding-left:15px">Low Consumption Detection</td>
        <td colspan="2" align="center" >50</td>
    </tr>
    <tr>
        <td colspan="2" style="padding-left:15px" >Contact Demand Violation</td>
        <td colspan="2" align="center" >50</td>
    </tr>
    <tr>
        <td colspan="2" style="padding-left:15px" > Low PF Detection</td>
        <td colspan="2" align="center" >50</td>
    </tr>

</table></td></tr></table>
</div>
<div  align="" style="padding-top:15px">
             <table >
                <tr><td  align="left">
                        <table id="discom" align="center" style="border:0px;" width="175px"><tr >
                                <td align="center" style="background-color:#D8BFD8;" >EPDCL</td>

                </tr></table>
                        </td>

                </tr>
                <tr><td><table style="border-color:#ddd;vertical-align:top" id="board" width="350"border="1" cellpadding="0"cellspacing="0" >
    <tr >
        <td></td>
        <td align="center"  style="background-color:#ddd;">Total</td>
        <td align="center"  style="background-color:#ddd;">Completed</td>
        <td align="center"  style="background-color:#ddd;">Pending</td>
    </tr>
    <tr>
        <td style="padding-left:15px">Modems Installation Report</td>
        <td align="center">500</td>
        <td align="center">300</td>
        <td align="center">200</td>
    </tr>
    <tr>
        <td style="padding-left:15px">RawData Report</td>
        <td align="center">1600</td>
        <td align="center">1500</td>
        <td align="center">100</td>
    </tr>
   <tr><td colspan="4" style="height:5px;background-color:#D8BFD8;"></td></tr>


    <tr>
        <td colspan="2" ></td>
        <td colspan="2" align="center" style="background-color:#ddd;" >Number of Meters</td>
    </tr>
    <tr>
        <td colspan="2"style="padding-left:15px" > Meter Communication Problem</td>
        <td colspan="2" align="center" >50</td>
    </tr>
    <tr>
        <td colspan="2" style="padding-left:15px" >Low Voltage Detection</td>
        <td colspan="2" align="center" >50</td>
    </tr>
    <tr>
        <td colspan="2"style="padding-left:15px">Low Consumption Detection</td>
        <td colspan="2" align="center" >50</td>
    </tr>
    <tr>
        <td colspan="2" style="padding-left:15px" >Contact Demand Violation</td>
        <td colspan="2" align="center" >50</td>
    </tr>
    <tr>
        <td colspan="2" style="padding-left:15px" >Low PF Detection</td>
        <td colspan="2" align="center" >50</td>
    </tr>

</table></td></tr></table>
</div>
<div   style="position:absolute;top:138px;left:650px">
             <table >
                <tr><td  align="left">
                        <table id="discom" align="center" style="border:0px;" width="175px"><tr >
                                <td align="center" style="background-color:#D8BFD8;" >SPDCL</td>

                </tr></table>
                        </td>

                </tr>
                <tr><td><table style="border-color:#ddd;vertical-align:top" id="board" width="350"border="1" cellpadding="0"cellspacing="0" >
    <tr >
        <td></td>
        <td align="center"  style="background-color:#ddd;">Total</td>
        <td align="center"  style="background-color:#ddd;">Completed</td>
        <td align="center"  style="background-color:#ddd;">Pending</td>
    </tr>
    <tr>
        <td style="padding-left:15px">Modems Installation Report</td>
        <td align="center">500</td>
        <td align="center">300</td>
        <td align="center">200</td>
    </tr>
    <tr>
        <td style="padding-left:15px">RawData Report</td>
        <td align="center">1600</td>
        <td align="center">1500</td>
        <td align="center">100</td>
    </tr>
    <tr><td colspan="4" style="height:5px;background-color:#D8BFD8;"></td></tr>


    <tr>
        <td colspan="2" ></td>
        <td colspan="2" align="center" style="background-color:#ddd;" >Number of Meters</td>
    </tr>
    <tr>
        <td colspan="2"style="padding-left:15px" > Meter Communication Problem</td>
        <td colspan="2" align="center" >50</td>
    </tr>
    <tr>
        <td colspan="2" style="padding-left:15px" >Low Voltage Detection</td>
        <td colspan="2" align="center" >50</td>
    </tr>
    <tr>
        <td colspan="2"style="padding-left:15px">Low Consumption Detection</td>
        <td colspan="2" align="center" >50</td>
    </tr>
    <tr>
        <td colspan="2" style="padding-left:15px" >Contact Demand Violation</td>
        <td colspan="2" align="center" >50</td>
    </tr>
    <tr>
        <td colspan="2" style="padding-left:15px" >Low PF Detection</td>
        <td colspan="2" align="center" >50</td>
    </tr>

</table></td></tr></table>
</div>
<div   style="position:absolute;top:395px;left:650px">
    <table >
                <tr><td  align="left">
                        <table id="discom" align="center" style="border:0px;" width="175px"><tr >
                                <td align="center" style="background-color:#D8BFD8;" >NPDCL</td>
                    
                </tr></table>
                        </td>
                        
                </tr>
                <tr><td><table style="border-color:#ddd;vertical-align:top" id="board" width="350"border="1" cellpadding="0"cellspacing="0" >
    <tr >
        <td></td>
        <td align="center"  style="background-color:#ddd;">Total</td>
        <td align="center"  style="background-color:#ddd;">Completed</td>
        <td align="center"  style="background-color:#ddd;">Pending</td>
    </tr>
    <tr>
        <td style="padding-left:15px">Modems Installation Report</td>
        <td align="center">500</td>
        <td align="center">300</td>
        <td align="center">200</td>
    </tr>
    <tr>
        <td style="padding-left:15px">RawData Report</td>
        <td align="center">1600</td>
        <td align="center">1500</td>
        <td align="center">100</td>
    </tr>
    <tr><td colspan="4" style="height:5px;background-color:#D8BFD8;"></td></tr>


    <tr>
        <td colspan="2" ></td>
        <td colspan="2" align="center" style="background-color:#ddd;" >Number of Meters</td>
    </tr>
    <tr>
        <td colspan="2"style="padding-left:15px" > Meter Communication Problem</td>
        <td colspan="2" align="center" >50</td>
    </tr>
    <tr>
        <td colspan="2" style="padding-left:15px" >Low Voltage Detection</td>
        <td colspan="2" align="center" >50</td>
    </tr>
    <tr>
        <td colspan="2"style="padding-left:15px">Low Consumption Detection</td>
        <td colspan="2" align="center" >50</td>
    </tr>
    <tr>
        <td colspan="2" style="padding-left:15px" > Contact Demand Violation</td>
        <td colspan="2" align="center" >50</td>
    </tr>
    <tr>
        <td colspan="2" style="padding-left:15px" >Low PF Detection</td>
        <td colspan="2" align="center" >50</td>
    </tr>

</table>
                    </td></tr></table>
</div>
  