<form>
<table border="0" height="370px">
    <tr>
        <td align="left" style="line-height: 18px;">
            Circle :
            <select name="circle" id="circle" style="width:150px;height:20px;font-size:12px;font-family:verdana;"
                                                                       onChange="showDivisions(this.value);">
                <option value="0">Select Circle</option>
                <option value="1">Circle_One</option>
                <option value="2">Circle_Two</option>
            </select>
        </td>
    </tr>
    <tr>
        <td align="left">
            Division :
            <select name="division" id="division" style="width:150px;height:20px;font-size:12px;font-family:verdana;"
                                                                       onChange="showSubDivisions(this.value);">
                <option value="0">Select Division</option>
            </select>
        </td>
    </tr>
    <tr>
        <td align="left">
            Sub Division :
            <select name="subdivision" id="subdivision" style="width:150px;height:20px;font-size:12px;font-family:verdana;"
                                                                      onChange="showSections(this.value);">
                <option value="0">Select Sub_Division</option>
            </select>
        </td>
    </tr>
    <tr>
        <td align="left">
            Section :
            <select name="section" id ="section" style="width:150px;height:20px;font-size:12px;font-family:verdana;"
                                                            onChange="showSubStations(this.value);">
                <option value="0">Select Section</option>
            </select>
        </td>
    </tr>
    <tr>
        <td align="left">
            Substation :
            <select name="substation" id="substation" style="width:150px;height:20px;font-size:12px;font-family:verdana;"
                                                           onChange="showFeeders(this.value);">
                <option value="0">Select SubStation</option>
            </select>
        </td>
    </tr>
    <tr>
        <td align="left">
            Feeder :
            <select name="feeder" id="feeder" style="width:150px;height:20px;font-size:12px;font-family:verdana;"
                                                             onChange="showDTRs(this.value,0);">
                <option value="0">Select Feeder</option>
            </select>
        </td>
    </tr>

    <!--<tr>
        <td align="left">
            <input type="radio" name="r1" value="feeder" checked onclick="list_change(0);"> Feeder
            <input type="radio" name="r1" value="dtr" onclick="list_change(1);"> DTR
            <input type="radio" name="r1" value="ht" onclick="list_change(2);"> HT
        </td>
    </tr>-->
    <tr>
        <td align="left"  height="100px">
            <select name="dtr" id="dtr" style="width:150px;font-size:12px;font-family:verdana;" size="3" onChange="getDataReportsInstantData(this.value);">
            </select>
        </td>
    </tr>
</table>
</form>