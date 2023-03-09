<%@ page session="false" %>
<html><head><title></title></head>

    <body>
        <form name="Metermake">

            <table align="center" bgcolor="#E0ECF8" cellpadding="5" cellspacing="5">
                <tr><th colspan="4"><h2>Meter Make</h2></th></tr>


                <tr><td>
                        METERMAKENAME:</td><td>
                        <input name="metermakeName" id="metermakeName" type="text" ></td>
                </tr>
                <tr><td>
                        METER_SERIES:</td><td>
                        <input name="meterSeries" id="meterSeries" type="text" ></td></tr>
                <tr><td>
                        METER_VERSION:</td><td>
                        <input name="meterVersion" id="meterVersion" type="text"></td>
                </tr>


                <input name="metermakeId" id="metermakeId" type="hidden" value="-1" />
                <input name="noofParams" id="noofParams" type="hidden" value="-1" />
                <input name="paramNames" id="paramNames" type="hidden" value="-1" />
                <input name="b4_Tod_Params" id="b4_Tod_Params" type="hidden" value="-1" />
                <input name="d4_Params" id="d4_Params" type="hidden" value="-1" />

                <!--
                <tr>
                    <td>
                       METERMAKEID:
                    </td>
                    <td>
                        <input name="metermakeId" id="metermakeId" type="text" >
                    </td>
                </tr>
                <tr><td>
                        NO_OF_PARAMS:</td><td>
                        <input name="noofParams" id="noofParams" type="text" ></td></tr>
                <tr><td>
                        PARAM_NAMES:</td><td>
                        <input name="paramNames" id="paramNames" type="text" ></td></tr>
                <tr><td>
                        B4_TOD_PARAMS:</td><td>
                        <input name="b4_Tod_Params" id="b4_Tod_Params" type="text" ></td></tr>
                <tr><td>
                        D4_PARAMS:</td><td>
                    <input name="d4_Params" id="d4_Params"type="text" ></td.</tr>
                -->


                <tr><td></td><td>
                        <input type="button" value="ADD" onclick="insertMetermake()"></td>
                </tr>



            </table>

        </form>

    </body>
</html>