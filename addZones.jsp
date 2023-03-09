<%@ page session="false" %>
<%@include file="masterDataActions.jsp" %>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Map"%>
<table align="center" bgcolor="#E0ECF8" cellpadding="5" cellspacing="5">
    <tr><th colspan="2"><h2><u> Add Zone</u></h2></th></tr>
    <tr>
        <td>Discom name:</td>
        <td><select name="discomid" id="discomid" style="width:150px;height:20px;font-size:12px;font-family:verdana;">
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
        <td>Zone name:</td>
        <td><input type="text" name="zoneName" id="zoneName"/></td>
    </tr>
    <tr>
        <td></td>
        <td><input type="button"  id="add" value="add" onclick="insertZone()"/></td>
    </tr>


</table>
