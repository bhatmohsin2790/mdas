<tr>
	<td width=100% style="background:url(../images/body.png);height:83px;" colspan=4 valign="top">
            <table width="100%" border="0" cellpadding=0 cellspacing=0 style="font-family:Verdana,Arial,Helvetica,sans-serif;font-size:12px;color:#FFFFFF;">
                <tr>
                    <td align="center">
                        <img src="../images/ami.png" align="center" width="90px">
                    </td>
                    <td align="left" style="padding-top:20px;">
                        <img src="../images/mdas_title.png">
                    </td>
                    <td align="right" valign="top">
            <table border=0 cellpadding=0 cellspacing=0 style="font-family:Verdana,Arial,Helvetica,sans-serif;font-size:12px;color:#FFFFFF;">
                <tr>
                    <td class="top_m">Welcome <blink>
                        <%
if(session.getAttribute("userid")==null)
  {
%>
Guest
<%

  }
else
    out.println((session.getAttribute("userid")+"").toUpperCase());
%>
                </blink></td>
            <td class="top_m">
                 <%
if(session.getAttribute("userid")==null)
  {
%>
 <a href="<%=response.encodeRedirectURL("index.jsp")%>"><div style="background:url(images/icons.png) no-repeat 0px -28px;text-decoration: none;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Home</div></a>
<%

  }
else
   {
%>
 <a href="<%=response.encodeRedirectURL("home.jsp")%>"><div style="background:url(images/icons.png) no-repeat 0px -28px;text-decoration: none;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Home</div></a>
<%}%>
               </td>
                    <td class="top_m">
                    <%
if(session.getAttribute("userid")==null)
  {
%>
<a href="<%=response.encodeRedirectURL("login.jsp")%>"><div style="background:url(images/icons.png) no-repeat 0px -1167px;text-decoration: none;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Login</div></a>
<%

  }
else
   {
%>
<a href="<%=response.encodeRedirectURL("Logout.do")%>"><div style="background:url(images/icons.png) no-repeat 0px -1167px;text-decoration: none;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Logout</div></a>
<%}%>

                    </td>
                </tr>
            </table>

                    </td>
                </tr>
            </table>
	</td>
</tr>