<%@page  isErrorPage="true" %>
<html>
    <head>
<style>
    #main h4.alert_error {
display: block;
width: 95%;
margin: 20px 3% 0 3%;
margin-top: 20px;
-webkit-border-radius: 5px;
-moz-border-radius: 5px;
border-radius: 5px;
background: #F3D9D9 url(../images/icn_alert_error.png) no-repeat;
background-position: 10px 10px;
border: 1px solid #D20009;
color: #7B040F;
padding: 10px 0;
text-indent: 40px;
font-size: 14px;}
    </style>
    
    </head>
    <body id="main">
        <%
        String errorMessage=request.getParameter("message");
        System.out.println("errorMessage-------->"+errorMessage);
        %>
<h4 style="display: block;
width: 95%;
margin: 20px 3% 0 3%;
margin-top: 20px;
-webkit-border-radius: 5px;
-moz-border-radius: 5px;
border-radius: 5px;
background: #F3D9D9 url(../images/icn_alert_error.png) no-repeat;
background-position: 10px 10px;
border: 1px solid #D20009;
color: #7B040F;
padding: 10px 0;
text-indent: 40px;
font-size: 14px;"> <%= errorMessage %> </h4>
    </body>
</html>