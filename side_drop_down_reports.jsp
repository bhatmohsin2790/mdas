<script language="JavaScript">
    function showDivisions(emp_value)
    {
        //    alert("reached here.........!"+emp_value);
        //------------Removing the previous values---------------------
        //	for(var j=document.forms[0].division.options.length-1;j>=0;j--){
        //		document.forms[0].division.remove(j);
        //		}
        //-----------End for removing values----------------------------
        //               alert("A");
        if(emp_value!="-1")
        {
            //            alert("B");
            xmlHttp=GetXmlHttpObject();
            if (xmlHttp==null)
            {
                alert ("Browser does not support HTTP Request");
                return;
            }
            var url="getDivisions.jsp";
            url=url+"?emp_id="+emp_value;

            xmlHttp.onreadystatechange=stateChanged;
            xmlHttp.open("GET",url,true);
            xmlHttp.send(null);

        }else
        {
            //                           alert("C");
            alert("Please Select Subdivision ");
        }
        //                       alert("D");
    }//showDivisions

    function stateChanged()
    {

        if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
        {

            var showdata = xmlHttp.responseText;

            var strar = showdata.split(":");

            if(strar.length==1)
            {
                //  alert("Please Select Employee Id");
            }
            else if(strar.length>1)
            {
                var strname = strar[1];
                //----- Values inserting into Combo Box Dynamicaly------
                for(var j=document.forms[0].division.options.length-1;j>=0;j--){
                    document.forms[0].division.remove(j);
                }
                var combo = document.getElementById("division");
                for(var i=0;i<strar.length;i++)
                {
                    // alert(strar[i].substringData(strar[i].indexOf("_")+1));
                    var option = document.createElement("option");
                    option.text = strar[i].substring(2);//textb.value;
                    option.value = strar[i].substring(0, strar[i].indexOf("_"));//textb.value;
                    try {
                        combo.add(option, null); //Standard
                    }catch(error) {
                        combo.add(option); // IE only
                    }//try
                }//for
                //----- End of Values inserting into Combo Box Dynamicaly------
            }

        }
    }//stateChanged

    function showSubDivisions(emp_value)
    {
        //    alert("reached here.........!"+emp_value);
        //------------Removing the previous values---------------------
        //	for(var j=document.forms[0].division.options.length-1;j>=0;j--){
        //		document.forms[0].division.remove(j);
        //		}
        //-----------End for removing values----------------------------
        if(emp_value!="-1")
        {
            xmlHttp=GetXmlHttpObject();
            if (xmlHttp==null)
            {
                alert ("Browser does not support HTTP Request");
                return;
            }
            var url="getSubDivisions.jsp";
            url=url+"?emp_id="+emp_value;

            xmlHttp.onreadystatechange=state_SubDivision_Changed;
            xmlHttp.open("GET",url,true);
            xmlHttp.send(null);

        }else
        {
            alert("Please Select Subdivision ");
        }
    }//showDivisions

    function state_SubDivision_Changed()
    {

        if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
        {

            var showdata = xmlHttp.responseText;

            var strar = showdata.split(":");

            if(strar.length==1)
            {
                //  alert("Please Select Employee Id");
            }
            else if(strar.length>1)
            {
                var strname = strar[1];
                //----- Values inserting into Combo Box Dynamicaly------
                for(var j=document.forms[0].subdivision.options.length-1;j>=0;j--){
                    document.forms[0].subdivision.remove(j);
                }
                var combo = document.getElementById("subdivision");
                for(var i=0;i<strar.length;i++)
                {
                    var option = document.createElement("option");
                    option.text = strar[i].substring(2);//textb.value;
                    option.value = strar[i].substring(0, strar[i].indexOf("_"));//textb.value;
                    try {
                        combo.add(option, null); //Standard
                    }catch(error) {
                        combo.add(option); // IE only
                    }//try
                }//for
                //----- End of Values inserting into Combo Box Dynamicaly------
            }

        }
    }//state_SubDivision_Changed

    function showSections(emp_value)
    {
        //    alert("reached here.........!"+emp_value);
        //------------Removing the previous values---------------------
        //	for(var j=document.forms[0].division.options.length-1;j>=0;j--){
        //		document.forms[0].division.remove(j);
        //		}
        //-----------End for removing values----------------------------
        if(emp_value!="-1")
        {
            xmlHttp=GetXmlHttpObject();
            if (xmlHttp==null)
            {
                alert ("Browser does not support HTTP Request");
                return;
            }
            var url="getSections.jsp";
            url=url+"?emp_id="+emp_value;

            xmlHttp.onreadystatechange=state_Section_Changed;
            xmlHttp.open("GET",url,true);
            xmlHttp.send(null);

        }else
        {
            alert("Please Select Subdivision ");
        }
    }//showDivisions

    function state_Section_Changed()
    {

        if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
        {

            var showdata = xmlHttp.responseText;

            var strar = showdata.split(":");

            if(strar.length==1)
            {
                //  alert("Please Select Employee Id");
            }
            else if(strar.length>1)
            {
                var strname = strar[1];
                //----- Values inserting into Combo Box Dynamicaly------
                for(var j=document.forms[0].section.options.length-1;j>=0;j--){
                    document.forms[0].section.remove(j);
                }
                var combo = document.getElementById("section");
                for(var i=0;i<strar.length;i++)
                {
                    var option = document.createElement("option");
                    option.text = strar[i].substring(2);//textb.value;
                    option.value = strar[i].substring(0, strar[i].indexOf("_"));//textb.value;
                    try {
                        combo.add(option, null); //Standard
                    }catch(error) {
                        combo.add(option); // IE only
                    }//try
                }//for
                //----- End of Values inserting into Combo Box Dynamicaly------
            }

        }
    }//state_Section_Changed

    function showSubStations(emp_value)
    {
        //    alert("reached here.........!"+emp_value);
        //------------Removing the previous values---------------------
        //	for(var j=document.forms[0].division.options.length-1;j>=0;j--){
        //		document.forms[0].division.remove(j);
        //		}
        //-----------End for removing values----------------------------
        if(emp_value!="-1")
        {
            xmlHttp=GetXmlHttpObject();
            if (xmlHttp==null)
            {
                alert ("Browser does not support HTTP Request");
                return;
            }
            var url="getSubstations.jsp";
            url=url+"?emp_id="+emp_value;

            xmlHttp.onreadystatechange=state_SubStation_Changed;
            xmlHttp.open("GET",url,true);
            xmlHttp.send(null);

        }else
        {
            alert("Please Select Subdivision ");
        }
    }//showDivisions

    function state_SubStation_Changed()
    {

        if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
        {

            var showdata = xmlHttp.responseText;

            var strar = showdata.split(":");

            if(strar.length==1)
            {
                //  alert("Please Select Employee Id");
            }
            else if(strar.length>1)
            {
                var strname = strar[1];
                //----- Values inserting into Combo Box Dynamicaly------
                for(var j=document.forms[0].substation.options.length-1;j>=0;j--){
                    document.forms[0].substation.remove(j);
                }
                var combo = document.getElementById("substation");
                for(var i=0;i<strar.length;i++)
                {
                    var option = document.createElement("option");
                    option.text = strar[i].substring(2);//textb.value;
                    option.value = strar[i].substring(0, strar[i].indexOf("_"));//textb.value;
                    try {
                        combo.add(option, null); //Standard
                    }catch(error) {
                        combo.add(option); // IE only
                    }//try
                }//for
                //----- End of Values inserting into Combo Box Dynamicaly------
            }

        }
    }//state_SubStation_Changed

    function showFeeders(emp_value)
    {
            alert("reached here......sddr...!"+emp_value);
        //------------Removing the previous values---------------------
        //	for(var j=document.forms[0].division.options.length-1;j>=0;j--){
        //		document.forms[0].division.remove(j);
        //		}
        //-----------End for removing values----------------------------
        if(emp_value!="-1")
        {
            xmlHttp=GetXmlHttpObject();
            if (xmlHttp==null)
            {
                alert ("Browser does not support HTTP Request");
                return;
            }
            var url="getFeeders.jsp";
            url=url+"?emp_id="+emp_value;

            xmlHttp.onreadystatechange=state_Feeder_Changed;
            xmlHttp.open("GET",url,true);
            xmlHttp.send(null);

        }else
        {
            alert("Please Select Subdivision ");
        }
    }//showDivisions

    function state_Feeder_Changed()
    {

        if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
        {

            var showdata = xmlHttp.responseText;

            var strar = showdata.split(":");

            if(strar.length==1)
            {
                //  alert("Please Select Employee Id");
            }
            else if(strar.length>1)
            {
                var strname = strar[1];
                //----- Values inserting into Combo Box Dynamicaly------
                for(var j=document.forms[0].feeder.options.length-1;j>=0;j--){
                    document.forms[0].feeder.remove(j);
                }
                var combo = document.getElementById("feeder");
                for(var i=0;i<strar.length;i++)
                {
                    var option = document.createElement("option");
                    option.text = strar[i].substring(2);//textb.value;
                    option.value = strar[i].substring(0, strar[i].indexOf("_"));//textb.value;
                    try {
                        combo.add(option, null); //Standard
                    }catch(error) {
                        combo.add(option); // IE only
                    }//try
                }//for
                //----- End of Values inserting into Combo Box Dynamicaly------
            }

        }
    }//state_Feeder_Changed

    //select Meters list based on opt (option value 0-->Feeders, 1-->DTR's, 2-->HT's)
    function list_change(opt)
    {
        showDTRs(document.getElementById('feeder').value,opt);
    }
    function showDTRs(emp_value,i)
    {
    
        //    alert("reached here.........!"+emp_value);
        //------------Removing the previous values---------------------
        //	for(var j=document.forms[0].division.options.length-1;j>=0;j--){
        //		document.forms[0].division.remove(j);
        //		}
        //-----------End for removing values----------------------------
        if(emp_value!="-1")
        {
            xmlHttp=GetXmlHttpObject();
            if (xmlHttp==null)
            {
                alert ("Browser does not support HTTP Request");
                return;
            }
            /*
                        var url="getDTRs.jsp";
                        url=url+"?emp_id="+emp_value;
                        url=url+"&opt="+i;
             */
            var url="getDTRs.jsp?emp_id="+escape(emp_value)+"&opt="+escape(i);
            xmlHttp.onreadystatechange=state_DTR_Changed;
            xmlHttp.open("GET",url,true);
            xmlHttp.send(null);

        }else
        {
            alert("Please Select Subdivision ");
        }
    }//showDivisions

    function state_DTR_Changed()
    {

        if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
        {

            var showdata = xmlHttp.responseText;
            showdata = showdata.toString().replace("\n", "");
            showdata = showdata.toString().replace("\n", "");
            showdata = showdata.toString().replace("\n", "");
            showdata = showdata.toString().replace("\n", "");
            var strar = showdata.split(":");

            if(strar.length==1)
            {
                //  alert("Please Select Employee Id");
            }
            else if(strar.length>1)
            {
                var strname = strar[1];
                //----- Values inserting into Combo Box Dynamicaly------
                for(var j=document.forms[0].dtr.options.length-1;j>=0;j--){
                   
                    document.forms[0].dtr.remove(j);
                }
                var combo = document.getElementById("dtr");
                for(var i=0;i<strar.length-1;i++)
                {
                    var option = document.createElement("option");
                    option.text = strar[i].trim().substring(2);//textb.value;
                    option.value = strar[i].substring(0,strar[i].trim().indexOf("_"));//textb.value;
                                
                    try {
                        combo.add(option, null); //Standard
                    }catch(error) {
                        combo.add(option); // IE only

                    }//try
                }//for
                //----- End of Values inserting into Combo Box Dynamicaly------
        
      
            }

        }
    }//state_DTR_Changed

        

    function GetXmlHttpObject()
    {
        var xmlHttp=null;
        try
        {
            // Firefox, Opera 8.0+, Safari
            xmlHttp=new XMLHttpRequest();
        }
        catch (e)
        {
            //Internet Explorer
            try
            {
                xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
            }
            catch (e)
            {
                xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
            }
        }
        return xmlHttp;
    }//GetXmlHttpObject

</script>


<form>
    <table border="0">
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
                    <option value="0">Select Sub-Division</option>
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
        <tr>
            <td align="left">
                <input type="radio" name="r1" value="feeder" checked onclick="list_change(0);"> Feeder
                <input type="radio" name="r1" value="dtr" onclick="list_change(1);"> DTR
                <input type="radio" name="r1" value="ht" onclick="list_change(2);"> HT
            </td>
        </tr>
        <tr>
            <td align="left">
                <select name="dtr" id="dtr" style="width:150px;font-size:12px;font-family:verdana;" size="3" onChange="getInstantData2(this.value);">
                </select>
            </td>
        </tr>
    </table>
</form>