<style>
    #login a{text-decoration: none;color:#FFFFFF;}
    #login a:hover{text-decoration: underline;color:#FFFFFF;}
</style>
<div id="scroll">
			WELCOME TO METER DATA ACQUISITION SYSTEM
                        <div id="login" style="float:right;padding-right:50px;color:#FFFFFF;">

                            <%
if(session.getAttribute("userid")==null)
  {
%>
<a href="<%=response.encodeRedirectURL("login.jsp")%>">Login</a>
<%

  }
else
   {
%>
<a href="<%=response.encodeRedirectURL("Logout.do")%>">Logout</a>
<%}%>
                        </div>
                    </div>