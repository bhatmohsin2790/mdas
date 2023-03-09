<form>
<table border="0" height="390px">
    
    <tr>
        <td align="left">
            Section :
            <select name="section" id ="section" style="width:150px;height:20px;font-size:12px;font-family:verdana;"
                                                            onChange="showSubStations(this.value);">
                <option value="0">Select Section</option>
                <option value="1">Section1</option>
                <option value="181">Tirupath Town</option>
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
    
    <tr>
        <td align="left">
            <select name="dtr" id="dtr" style="width:150px;font-size:12px;font-family:verdana;" size="3" onChange="getDataReportsInstantData(this.value);">
            </select>
        </td>
    </tr>
     
</table>
</form>