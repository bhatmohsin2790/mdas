<%@page import="java.sql.*" %>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="in.amitech.db.DBUtil"%>
<style>
    .button_style
    {
        background-color:#EEEEEE;
        border:1px solid #DDDDDD;
        color:#666666;
        padding:3px 15px;
        text-decoration:none;
        float:left;
    }
    .graph_style
    {
        background-color:#EEEEEE;
        border:1px solid #DDDDDD;
        color:#666666;
        padding:0px 10px;
        text-decoration:none;
        float:left;
    }
    .tab-box1{
        border-bottom: 1px solid #DDD;
        padding-bottom:5px;
    }
    .tab-box1 a {
        border:1px solid #DDD;
        color:#666666;
        padding: 5px 15px;
        text-decoration:none;
        background-color: #eee;
    }
    .tab-box1 a.activeLink {
        background-color: #fff;
        border-bottom: 0;
        padding: 6px 15px;
    }
    .tabcontent1 { border: 0px solid #ddd; border-top: 0;}
    .hide { display: none;}


</style>
<style>
    .line{ border: 0px solid #ddd; border-top: 0;}
</style>
<script type="text/javascript">

    $(document).ready(function() {
        $(".tabLink1").each(function(){
            $(this).click(function(){
                tabeId = $(this).attr('id');
                $(".tabLink1").removeClass("activeLink");
                $(this).addClass("activeLink");
                $(".tabcontent1").addClass("hide");
                $("#"+tabeId+"-1").removeClass("hide")
           //document.getElementById("sDate").value="";
          //document.getElementById("eDate").value="";

                if(tabeId=="cnt-21")
                {
                    document.getElementsByName("dcu_opt")[0].checked = true;
                    getDCUData();
                }

                if(tabeId=="cnt-22")
                {
                    document.getElementsByName("dcu_opt")[2].checked = true;
                    getDCUData();
                }

                if(tabeId=="cnt-23")
                {
                   document.getElementsByName("dcu_opt")[4].checked = true;
                   getDCUData();
                }

                if(tabeId=="cnt-24")
                {
                    document.getElementsByName("dcu_opt")[6].checked = true;
                    getDCUData();
                }

                if(tabeId=="cnt-25")
                {
                    document.getElementsByName("dcu_opt")[7].checked = true;
                    getDCUData();
                }
                 if(tabeId=="cnt-26")
                {
                    document.getElementsByName("dcu_opt")[9].checked = true;
                    getDCUData();
                }
                if(tabeId=="cnt-27")
                {
                    document.getElementsByName("dcu_opt")[11].checked = true;
                    getDCUData();
                }
                if(tabeId=="cnt-28")
                {
                    document.getElementsByName("dcu_opt")[12].checked = true;
                    getDCUData();
                }
                if(tabeId=="cnt-29")
                {
                    document.getElementsByName("dcu_opt")[13].checked = true;
                    getDCUData();
                }
                 if(tabeId=="cnt-30")
                {
                    var ssId=document.getElementById("substation").value;            
                    if(ssId==0) alert("please select Substation");
                    document.getElementById("DataPart").innerHTML="";
                    document.getElementsByName("dcu_opt")[14].checked = true;
                    //getDCUData();
                }
                if(tabeId=="cnt-31")
                {
                    var ssId=document.getElementById("substation").value;            
                    if(ssId==0) alert("please select Substation");
                    document.getElementById("DataPart").innerHTML="";
                    document.getElementsByName("dcu_opt")[14].checked = true;
                    //getDCUData();
                }

                return false;
            });
        });
    });
    
</script>



<script type="text/JavaScript">

var gAutoPrint = true; // Tells whether to automatically call the print function
function printPage()
{
    if (document.getElementById != null)
{
var html = '<HTML>\n<HEAD>\n';



html += '\n</HEAD>\n\n';

var printReadyElem = document.getElementById("DataPart");

if (printReadyElem != null)
{
html += printReadyElem.innerHTML;
}
else
{
alert("Could not find the printReady function");
return;
}

html += '\n</HTML>';

var printWin = window.open("","printPage",'width=950,height=400,scrollbars=1,left=300,top=150');
printWin.document.open();
printWin.document.write(html);
printWin.save();

if (gAutoPrint)
{
printWin.print();

}


}
else
{
alert("The print ready feature is only available if you are using an browser. Please update your browswer.");
}
}//printpage
function exportMenu()
{
    document.getElementById('export').style.display="block";
}
function hideExport()
{
    document.getElementById('export').style.display="none";
}
function write_to_excel() {

 //window.open('data:application/vnd.ms-excel,'+document.getElementById("DataPart"));
 if (document.getElementById != null)
{
var html = "";



html += "";

var printReadyElem = document.getElementById("DataPart");

if (printReadyElem != null)
{
    

html += printReadyElem.innerHTML;
}
else
{
alert("Could not find the printReady function");
return;
}

html += "";
}

//window.open('data:application/vnd.ms-excel,'+html);
xmlHttp=GetXmlHttpObject();
        if (xmlHttp==null)
        {
            alert ("Browser does not support HTTP Request");
            return;
        }
//alert(html);
    var  url="export_excel.jsp?data="+html;
  //var parameters ="data="+ encodeURIComponent(html);
    //alert( parameters.length);
         xmlHttp.onreadystatechange=excelAction;
         xmlHttp.open("POST",url,true);
         //xmlHttp.setRequestHeader("Content-type","application/vnd.ms-excel");
        // xmlHttp.setRequestHeader("Content-length", parameters .length);
         
         xmlHttp.send();
 
}
function excelAction()
{
    if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
    {
        var showdata = xmlHttp.responseText;
       // alert("data"+showdata);
       // window.open('data:application/vnd.ms-excel,'+showdata);
    }
}

</script>

<div class="tab-box1" id="dcu">
    <a href="javascript:;" class="tabLink1 activeLink " id="cnt-21">Instantaneous</a>
    <a href="javascript:;" class="tabLink1 " id="cnt-27">Energy</a>
    <a href="javascript:;" class="tabLink1 " id="cnt-25">Load Survey</a>
    <a href="javascript:;" class="tabLink1 " id="cnt-26">Tampers</a>
    <a href="javascript:;" class="tabLink1 " id="cnt-29">Miscellaneous</a>
    <a href="javascript:;" class="tabLink1 " id="cnt-28">Transmission Loss </a>
    <a href="javascript:;" class="tabLink1 " id="cnt-30">On Demand</a>
	<a href="javascript:;" class="tabLink1 " id="cnt-31">Configure DCU</a>
  <!--  <a href="javascript:;" class="tabLink1 " id="cnt-22">Analog Data</a>
    <a href="javascript:;" class="tabLink1 " id="cnt-23">Digital Data</a>
    <a href="javascript:;" class="tabLink1 " id="cnt-24">SOE Data</a> -->
</div>



<div style="float:right;"><img src="images/p1.jpeg" id=""   onclick="printPage();"width=25 height=25 border=0  style="border-color:#ddd;cursor:pointer" title="print"/>
<!--<img src="images/2.jpeg" id=""   onclick="exportMenu();"width=20 height=20 border=0  style="border-color:#ddd;cursor:pointer" title="export"/>
<div id="export" style="background-color:#F5F5F5;border:1px;width:95px;right:-14px;display:none;z-index:10;position:absolute;"onmouseover="exportMenu();"onmouseout="hideExport();" >
    <div style="cursor:pointer;background:transparent none repeat scroll 0% 0%;"onmouseover="this.style.background='#56a5ec';"onmouseout="this.style.background='#F5F5F5';" onclick="createPDF();">Save As pdf</div>
    <div style="cursor:pointer;background:transparent none repeat scroll 0% 0%;"onmouseover="this.style.background='#56a5ec';"onmouseout="this.style.background='#F5F5F5';" onclick="write_to_excel();">Save As excel</div>
</div> -->
</div>
<script type="text/javascript" src="date-picker.js"></script>
<div class="tabcontent1 paddingAll" id="cnt-21-1">

    <div class="button_style"> <input type="radio" name="dcu_opt" id="dcu_opt" value="1" checked onclick="getDCUData()"> Latest Data &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
    <div class="button_style" style="display:none;"><input type="radio" name="dcu_opt" id="dcu_opt" value="2" onclick="getDCUData()"> Historical Data</div>
    
</div>

<div class="tabcontent1 paddingAll hide" id="cnt-22-1">
    <div class="button_style"><input type="radio" name="dcu_opt" id="dcu_opt" value="3" onclick="getDCUData()"> Latest Data &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
    <div class="button_style"><input type="radio" name="dcu_opt" id="dcu_opt" value="4" onclick="getDCUData()"> Historical Data</div>
</div>

<div class="tabcontent1 paddingAll hide" id="cnt-23-1">
   <div class="button_style"><input type="radio" name="dcu_opt" id="dcu_opt" value="5" onclick="getDCUData()"> Latest Data &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
    <div class="button_style"><input type="radio" name="dcu_opt" id="dcu_opt" value="6" onclick="getDCUData()"> Historical Data</div>
</div>
<div class="tabcontent1 paddingAll hide" id="cnt-24-1">
   <div class="button_style"> <input type="radio" name="dcu_opt" id="dcu_opt" value="7" onclick="getDCUData()"> SOE Data&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
</div>
<div class="tabcontent1 paddingAll hide" id="cnt-25-1">
    <div class="button_style"><input type="radio" name="dcu_opt"  id="dcu_opt" value="8" onclick="getDCUData()"> Latest 10 Records &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
    <div class="button_style" style="display:none;"><input type="radio" name="dcu_opt" id="dcu_opt" value="9" onclick="getDCUData()"> Historical &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
</div>
<div class="tabcontent1 paddingAll hide" id="cnt-26-1">
<div class="button_style"><input type="radio" name="dcu_opt"  id="dcu_opt" value="10" onclick="getDCUData()"> Latest 10 Tampers &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
<div class="button_style" style="display:none;"><input type="radio" name="dcu_opt" id="dcu_opt" value="11" onclick="getDCUData()"> Historical &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
</div>
<div class="tabcontent1 paddingAll hide" id="cnt-27-1">
<div class="button_style"><input type="radio" name="dcu_opt"  id="dcu_opt" value="12" onclick="getDCUData()"> Latest 10 Records &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
</div>
<div class="tabcontent1 paddingAll hide" id="cnt-28-1">
<div class="button_style"><input type="radio" name="dcu_opt"  id="dcu_opt" value="13" onclick="getDCUData()"> Transformation Loss Report&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
</div>
<div class="tabcontent1 paddingAll hide" id="cnt-29-1">
<div class="button_style"><input type="radio" name="dcu_opt"  id="dcu_opt" value="14" onclick="getDCUData()">Latest Records&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
</div>
<div class="tabcontent1 paddingAll hide" id="cnt-30-1">
    <div class="button_style" style="visibility:hidden;"><input type="radio" name="dcu_opt"  id="dcu_opt" value="15" onclick="getDCUData()">On Demand for Data&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
    <div style="padding-top:10%;padding-left: 40%"><input type="button" value="Send On Demand" onclick="getDCUData()"></input></div>
</div>
<div class="tabcontent1 paddingAll hide" id="cnt-31-1">
    <div class="button_style" style="visibility:hidden;"><input type="radio" name="dcu_opt"  id="dcu_opt" value="15" onclick="getDCUData()">On Demand for Data&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
    <div style="padding-top:10%;padding-left: 40%"><a href="http://192.168.1.106:8080/dcu2/">Configure DCU</a></input></div>
</div>

<script>
                                        function create_graph(id)
                                        {
                                            //alert(id);
                                            //alert(document.getElementById("ai_values_string"+id).value);
                                            //alert(document.getElementById("avg_value"+id).value);
                                            //alert(document.getElementById("time_values_string"+id).value);
                                            window.showModalDialog("feeder_ai_line_graph.jsp?ai_values_string="+document.getElementById("ai_values_string"+id).value+"&avg_value="+document.getElementById("avg_value"+id).value+"&time_values_string="+document.getElementById("time_values_string"+id).value+"&ai_name="+document.getElementById('ai_name'+id).value ,"" ,'status:no;resizable=no;dialogWidth:850px;dialogHeight:450px;dialogHide:true;help:no;scroll:no');
                                        }
                                    </script>

<div id="dcu_loading" style="display: none">
    <table width="100%"><tr><td align="center">
    <img src="./images/loading.jpg"/>
    </td</tr></table>
</div>