<%@page import="in.amitech.mdas.SendSMS"%>
<html>
    <head>
        <script type="text/javascript">
            function validateForm(){
                mobile=document.getElementById("mobile").value;
                message=document.getElementById("message").value;
                if(mobile.length != 10){
                    alert("Mobile Number Length should be 10");
                    return false;
                }
                if(message.length < 3){
                    alert("Message should be At least 3 characters");
                    return false;
                }
            }
        </script>
    </head>
    <body bgcolor="blue">
        <div id="form-1">
            <center>
                <form name="custSMS"  action="" method="POST" onsubmit="return validateForm()">
                    <input type="hidden" name="meterIds"/>
                    <input type="hidden" name="meterLocation" />
                    <table valign="top" style="font-size:12px;padding-left:5px;padding-top:5px;background-color:#EDF5FA;" align="center">
                        <tr>
                            <td colspan="2">
                                <%
                                            String mobile = request.getParameter("mobile");
                                            String message = request.getParameter("message");
                                            //String command_To_MODEM = "$TI4,AIRTELGPRS.COM,21,ami,ami123,122.169.243.224,28000,";
                                            //String mobileNumber = "8978604396";
                                            if (mobile != null && message != null) {
                                                int smsStatus = new SendSMS().sendSMS(message, mobile);
                                                if (smsStatus == 0) {
                                                    out.println("SMS sent Successfully to Mobile :" + mobile + ", Message :" + message);
                                                } else {
                                                    out.println("SMS sending Failed to Mobile :" + mobile + ", Message :" + message);
                                                }
                                            }//end else

                                %>
                            </td>
                        </tr>
                        <tr>
                            <td>Mobile No:</td>
                            <td><input type="text" name="mobile" id="mobile"/> </td>
                        </tr>
                        <tr>
                            <td>Message :</td>
                            <td><input type="text" name="message" id="message"/> </td>
                        </tr>
                        <tr>
                            <td colspan="2"><input type="submit" value="Send SMS"/> </td>
                        </tr>
                    </table>
                </form>
            </center>
        </div>
    </body>
</html>