<%@ page session="false" %>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Map"%>
<%@include file="masterDataActions.jsp" %>
<table align="center" bgcolor="#E0ECF8" cellpadding="5" cellspacing="5">
    <tr><th colspan="2"><h2><u> Delete Discom</u></h2></th></tr>
    <tr>
        <td>Discom name:</td>
        <td><select name="discomID" id="discomID" style="width:150px;height:20px;font-size:12px;font-family:verdana;">
                <option value="-1">select discom</option>
                <%
                            Map<Integer, String> map = null;
                            try {
                                map = getDiscoms();
                                if (!map.isEmpty()) {
                                    for (Iterator<Integer> it = map.keySet().iterator(); it.hasNext();) {
                                        int key = it.next();
                %>
                <option value="<%=key%>"><%=map.get(key)%></option>
                <%                  }//end for
                                }//end if
                            } catch (Exception e) {
                            }//end catch
%>
            </select></td>
    </tr>
    <tr>
        <td></td>
        <td><input type="button"  id="delete" value="delete" onclick="deleteDiscom()"/></td>
    </tr>


</table>
