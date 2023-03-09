<script>
   $(function() {
    getuserCount();
});
    function getuserCount(){
        setTimeout("getuserCount();",2000);
        xmlHttp10=GetXmlHttpObject();
        if (xmlHttp10==null)
        {
            alert ("Browser does not support HTTP Request");
            return;
        }
        var url="getUserCount.jsp";
        xmlHttp10.onreadystatechange=getuserCountAction;
        xmlHttp10.open("GET",url,true);
        xmlHttp10.send(null);
    }
    function getuserCountAction(){
        if (xmlHttp10.readyState==4 || xmlHttp10.readyState=="complete")
    {
        var showdata = xmlHttp10.responseText;
        document.getElementById("counter").innerHTML=showdata;
    }
    }
        
</script>
<%     try{
            if (session.getAttribute("userid") == null) {
               // response.sendRedirect("login2.jsp");
            } else {
%>

<tr>
    <td width=100% style="background:url(images/body.png);height:83px;" colspan=4 valign="top">
        <table width="100%" border="0" cellpadding=0 cellspacing=0 style="font-family:Verdana,Arial,Helvetica,sans-serif;font-size:12px;color:#FFFFFF;">
            <tr>
                <td align="right">
                    <img src="images/j&k.png" align="center" height="80px">
                </td>
                <td align="left" style="padding-top:0px;">
                    <img src="images/mdas_title_1.png">
                </td>
                <td align="right" valign="top">
                    <table border=0 cellpadding=0 cellspacing=0 style="font-family:Verdana,Arial,Helvetica,sans-serif;font-size:12px;color:#FFFFFF;">
                        <tr>
                            <td class="top_m">Welcome <blink>
                            <%
                                            if (session.getAttribute("userid") == null) {
                            %>
                            Guest
                            <%            } else
                                                out.println((session.getAttribute("userid") + "").toUpperCase());
                            %>
                        </blink></td>
                <td class="top_m">
                    <%
                                    if (session.getAttribute("userid") == null) {
                    %>
                    <a href="<%=response.encodeRedirectURL("login2.jsp")%>"><div style="background:url(images/icons.png) no-repeat 0px -28px;text-decoration: none;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Home</div></a>
                    <%} else {
                    %>
                    <a href="<%=response.encodeRedirectURL("home.jsp")%>"><div style="background:url(images/icons.png) no-repeat 0px -28px;text-decoration: none;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Home</div></a>
                    <%}%>
                </td>
                <td class="top_m">
                    <%
                  if (session.getAttribute("userid") == null) {
                    %>
                    <a href="<%=response.encodeRedirectURL("login2.jsp")%>"><div style="background:url(images/icons.png) no-repeat 0px -1167px;text-decoration: none;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Login</div></a>
                    <%} 
                 else {
                   if (session.getAttribute("IDAM") == null) {
                    %>
                    <a href="Logout.do"><div style="background:url(images/icons.png) no-repeat 0px -1167px;text-decoration: none;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Logout</div></a>
                    <%                                   } else {
                    %>
                    <!--<a href="http://172.18.3.62:14100/oamsso/logout.html"><div style="background:url(images/icons.png) no-repeat 0px -1167px;text-decoration: none;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Logout</div></a>-->
					<a href="http://IDAM-IAM.jkpdd.net:14100/oam/server/logout?end_url=http://SNRMDMAPP.jkpdd.net"><div style="background:url(images/icons.png) no-repeat 0px -1167px;text-decoration: none;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Logout</div></a>
                    <%                            }
                    }%>

                </td>
            </tr>
        </table>
		<table style="font-family:Verdana,Arial,Helvetica,sans-serif;font-size:12px;color:#FFFFFF;padding-right: 20px;">
                            <tr>
                                <td class="top_m">Online Users&nbsp;&nbsp</td>
                                <td class="top_m" style="border-radius: 5px;border: 1px solid red;padding:0px 15px 0px 2px;"><div id="counter"></div></td>
                            </tr>
                        </table>

    </td>
</tr>
</table>
</td>
</tr>
<%
    }//end else
    }catch(Exception e){
       // e.printStackTrace();
      //response.sendRedirect("login2.jsp");  
    }
%>

