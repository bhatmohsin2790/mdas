<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title></title>
<script type="text/javascript" src="jquery.js"></script>

<%@ page import="java.sql.*" %>

    <style>
    .tab-box {
  border-bottom: 1px solid #DDD;
  padding-bottom:5px;
}
.tab-box a {
  border:1px solid #DDD;
  color:#666666;
  padding: 5px 15px;
  text-decoration:none;
  background-color: #eee;
  font-size:12px;
}
.tab-box a.activeLink {
  background-color: #fff;
  border-bottom: 0;
  padding: 6px 15px;
}
.tabcontent { border: 1px solid #ddd; border-top: 0;}
.hide { display: none;}


</style>
<script type="text/javascript">
  $(document).ready(function() {
    $(".tabLink").each(function(){
      $(this).click(function(){
        tabeId = $(this).attr('id');
        $(".tabLink").removeClass("activeLink");
        $(this).addClass("activeLink");
        $(".tabcontent").addClass("hide");
        $("#"+tabeId+"-1").removeClass("hide")
        return false;
      });
    });
  });


  
</script>


</head>


<body>
<div id="navigation"></div>
<table width=100% border=0 cellpadding=0 cellspacing=0 style="background:url(images/body.png) repeat-x;">
<%@ include file="top.jsp"%>
<tr>

	<td width=14px style="background:url(images/bg-content-left.png) no-repeat;width:14px;background-color:#EDF5FA;"></td>
	<td width=98% style="background:url(images/bg-content-center.png) repeat-x;padding-left:10px;padding-right:10px;padding-bottom:10px;padding-top:7px;" valign="top">

            <%-- <%@ include file="menu2.jsp"%> --%>

<p><b>Admin Level Hierarchy </b></p>

<!-- code by maruthi from here to-->

<div class="tab-box" >
    <a href="javascript:;" class="tabLink activeLink" id="cont-1">Zone</a>
    <a href="javascript:;" class="tabLink " id="cont-2">Circle</a>
    <a href="javascript:;" class="tabLink " id="cont-3">Division</a>
    <a href="javascript:;" class="tabLink " id="cont-4">SubDivision</a>
    <a href="javascript:;" class="tabLink " id="cont-5">Section</a>
    <!--<a href="javascript:;" class="tabLink " id="cont-6">SubStation</a>
     <a href="javascript:;" class="tabLink " id="cont-7">Feeders</a>
      <a href="javascript:;" class="tabLink " id="cont-8">DTRs</a>
       <a href="javascript:;" class="tabLink " id="cont-9">HT</a> -->
  </div>

<table  align="center"><tr>
        <td ></td></tr>
        
    <tr><td></td></tr>
    <tr><td></td></tr>
    <tr><td></td></tr>
    <tr><td></td></tr>
    <tr><td></td></tr>
    <tr><td></td></tr>
    <tr><td></td></tr>
    <tr><td></td></tr><tr><td></td></tr><tr><td></td></tr><tr><td></td></tr>
    <tr><td></td></tr><tr><td></td></tr><tr><td></td></tr><tr><td></td></tr>







    <tr>

        <td >
  <div class="tabcontent paddingAll" id="cont-1-1">
      <center>
          <h3>Adding of Zones</h3>
          <form name="zone" title="Adding of Zones" >
              <table align="center" cellpadding="5" cellspacing="5">
                  
                  <tr>
                      <td>Zone name:</td>
                      <td><input type="text" name="zone"/></td>
                  </tr>
                  <tr>
                      <td></td>
                      <td><input type="submit" value="add "/></td>
                  </tr>


              </table>
          </form>
      </center>

  </div>



  <div class="tabcontent paddingAll hide" id="cont-2-1">
   <center>
          <h3>Adding of Circles</h3>
          <form name="circle"  >
              <table align="center" cellpadding="5" cellspacing="5">

                  <tr>
                      <td align="left">Select Zone : </td>
                      
                
                       <td>
                       <select name="circle" id="circle" style="width:150px;height:20px;font-size:12px;font-family:verdana;">

                         <option value="0">Select zone</option>
                          <option value="1">zone11</option>

                         <option value="2">zone22</option>

                       </select>
                      </td>
                  </tr>
                      <tr>
                      <td>Circle name:</td>
                      <td><input type="text" name="circle"/></td>
                  </tr>
                  <tr>
                      <td></td>
                      <td><input type="submit" value="add "/></td>
                  </tr>


              </table>
          </form>
      </center>
  </div>

  <div class="tabcontent paddingAll hide" id="cont-3-1">
<center>
          <h3>Adding of Divisions</h3>
          <form name="division"  >
              <table align="center" cellpadding="5" cellspacing="5">

                  <tr>
                      <td>Zone name:</td>
                      <td>
                       <select name="zone" id="division" style="width:150px;height:20px;font-size:12px;font-family:verdana;">

                         <option value="0">Select Zone</option>
                          <option value="1">zone1</option>

                         <option value="2">zone2</option>

                       </select>
                      </td>
                  </tr>

                  <tr>
                      <td align="left">Select Circle : </td>
                       
                  

                       <td>
                       <select name="division" id="division" style="width:150px;height:20px;font-size:12px;font-family:verdana;">

                         <option value="0">Select circle</option>
                          <option value="1">circle1</option>

                         <option value="2">circle2</option>

                       </select>
                      </td>
                  </tr>
                      <tr>
                      <td>Division name:</td>
                      <td><input type="text" name="division"/></td>
                  </tr>
                  <tr>
                      <td></td>
                      <td><input type="submit" value="add "/></td>
                  </tr>


              </table>
          </form>
      </center>
    
  </div>
<div class="tabcontent paddingAll hide" id="cont-4-1">
   <center>
          <h3>Adding of SubDivisions</h3>
          <form name="subdivision"  >
              <table align="center" cellpadding="5" cellspacing="5">

                  <tr>
                      <td>Zone name:</td>
                      <td>
                       <select name="zone" id="division" style="width:150px;height:20px;font-size:12px;font-family:verdana;">

                         <option value="0">Select Zone</option>
                          <option value="1">zone1</option>

                         <option value="2">zone2</option>

                       </select>
                      </td>
                  </tr>

<tr>
                      <td>Circle name:</td>
                      <td>
                       <select name="circle" id="division" style="width:150px;height:20px;font-size:12px;font-family:verdana;">

                         <option value="0">Select Circle</option>
                          <option value="1">zone1</option>

                         <option value="2">zone2</option>

                       </select>
                      </td>
                  </tr>

                  <tr>
                      <td align="left">Select Division : </td>



                       <td>
                       <select name="subdivision" id="subdivision" style="width:150px;height:20px;font-size:12px;font-family:verdana;">

                         <option value="0">Select division</option>
                          <option value="1">division1</option>

                         <option value="2">division2</option>

                       </select>
                      </td>
                  </tr>
                       <tr>
                      <td>SubDivision name:</td>
                      <td><input type="text" name="subdivision"/></td>
                  </tr>
                  <tr>
                      <td></td>
                      <td><input type="submit" value="add "/></td>
                  </tr>


              </table>
          </form>
      </center>
  </div>

   <div class="tabcontent paddingAll hide" id="cont-5-1">
   <center>
          <h3>Adding of Sections</h3>
          <form name="section"  >
              <table align="center" cellpadding="5" cellspacing="5">

                  <tr>
                      <td>Zone name:</td>
                      <td>
                       <select name="zone" id="zone" style="width:150px;height:20px;font-size:12px;font-family:verdana;">

                         <option value="0">Select Zone</option>
                          <option value="1">zone1</option>

                         <option value="2">zone2</option>

                       </select>
                      </td>
                  </tr>

		<tr>
                      <td>Circle name:</td>
                      <td>
                       <select name="circle" id="circle" style="width:150px;height:20px;font-size:12px;font-family:verdana;">

                         <option value="0">Select Circle</option>
                          <option value="1">zone1</option>

                         <option value="2">zone2</option>

                       </select>
                      </td>
                  </tr>

 		<tr>
                      <td>Select Division : </td>



                       <td>
                       <select name="division" id="division" style="width:150px;height:20px;font-size:12px;font-family:verdana;">

                         <option value="0">Select division</option>
                          <option value="1">division1</option>

                         <option value="2">division2</option>

                       </select>
                      </td>
                  </tr>

                  <tr>
                      <td align="left">Select SubDivision : </td>
                       <td>
                       <select name="section" id="section" style="width:150px;height:20px;font-size:12px;font-family:verdana;">

                         <option value="0">Select subdivision</option>
                          <option value="1">sub_division1</option>

                         <option value="2">sub_division2</option>

                       </select>
                      </td>
                  </tr>
                  <tr>
                      <td>Section name:</td>
                      <td><input type="text" name="section"/></td>
                  </tr>
                  <tr>
                      <td></td>
                      <td><input type="submit" value="add "/></td>
                  </tr>


              </table>
          </form>
      </center>
  </div>
 <!-- <div class="tabcontent paddingAll hide" id="cont-6-1">
  <center>
          <h3>Adding of SubStations</h3>
          <form name="ss"  >
              <table align="center" cellpadding="5" cellspacing="5">

                  <tr>
                      <td align="left">Select Section : </td>


                       <td>
                       <select name="ss" id="ss" style="width:150px;height:20px;font-size:12px;font-family:verdana;">

                         <option value="0">Select section</option>
                          <option value="1">section1</option>

                         <option value="2">section2</option>

                       </select>
                      </td>
                  </tr>
                  <tr>
                      <td>SubStation name:</td>
                      <td><input type="text" name="substation"/></td>
                  </tr>
                  <tr>
                      <td></td>
                      <td><input type="submit" value="add "/></td>
                  </tr>


              </table>
          </form>
      </center>
  </div>
            <div class="tabcontent paddingAll hide" id="cont-7-1">
  <center>
          <h3>Adding of Feeders</h3>
          <form name="feeder"  >
              <table align="center" cellpadding="5" cellspacing="5">

                  <tr>
                      <td align="left">Select SubStation : </td>


                       <td>
                       <select name="ss" id="ss" style="width:150px;height:20px;font-size:12px;font-family:verdana;">

                         <option value="0">Select substation</option>
                          <option value="1">substation1</option>

                         <option value="2">substation2</option>

                       </select>
                      </td>
                  </tr>
                  <tr>
                      <td>Feeder name:</td>
                      <td><input type="text" name="Feeder"/></td>
                  </tr>
                  <tr>
                      <td></td>
                      <td><input type="submit" value="add "/></td>
                  </tr>


              </table>
          </form>
      </center>
  </div>
            <div class="tabcontent paddingAll hide" id="cont-8-1">
  <center>
          <h3>Adding of DTRs</h3>
          <form name="dtr"  >
              <table align="center" cellpadding="5" cellspacing="5">

                  <tr>
                      <td align="left">Select Feeder : </td>


                       <td>
                       <select name="ss" id="ss" style="width:150px;height:20px;font-size:12px;font-family:verdana;">

                         <option value="0">Select Feeder</option>
                          <option value="1">Feeder1</option>

                         <option value="2">Feeder2</option>

                       </select>
                      </td>
                  </tr>
                  <tr>
                      <td>DTR name:</td>
                      <td><input type="text" name="dtr"/></td>
                  </tr>
                  <tr>
                      <td></td>
                      <td><input type="submit" value="add "/></td>
                  </tr>


              </table>
          </form>
      </center>
  </div>
            <div class="tabcontent paddingAll hide" id="cont-9-1">
  <center>
          <h3>Adding of HT Meeters</h3>
          <form name="HT"  >
              <table align="center" cellpadding="5" cellspacing="5">

                  <tr>
                      <td align="left">Select DTR : </td>


                       <td>
                       <select name="ss" id="ss" style="width:150px;height:20px;font-size:12px;font-family:verdana;">

                         <option value="0">Select DTR</option>
                          <option value="1">dtr1</option>

                         <option value="2">dtr2</option>

                       </select>
                      </td>
                  </tr>
                  <tr>
                      <td>HT name:</td>
                      <td><input type="text" name="HT"/></td>
                  </tr>
                  <tr>
                      <td></td>
                      <td><input type="submit" value="add "/></td>
                  </tr>


              </table>
          </form>
      </center>
  </div> -->
<script type="text/javascript">
  $(document).ready(function() {
    $(".tabLink").each(function(){
      $(this).click(function(){
        tabeId = $(this).attr('id');
        $(".tabLink").removeClass("activeLink");
        $(this).addClass("activeLink");
        $(".tabcontent").addClass("hide");
        $("#"+tabeId+"-1").removeClass("hide")
        return false;
      });
    });
  });
</script>

</td></tr>
</table>

<!-- upto here-->

	</td>
	<td width=13px style="background:url(images/bg-content-right.png) no-repeat;width:13px;background-color:#EDF5FA;"></td>
</tr>
</table>
<div id="navigation"></div>
<%@ include file="bottom.jsp"%>

</body>
</html>