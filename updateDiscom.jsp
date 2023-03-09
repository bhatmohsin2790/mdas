<%@ page session="false" %>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Map"%>
<%@include file="masterDataActions.jsp" %>
<table align="center" bgcolor="#E0ECF8" cellpadding="5" cellspacing="5"  width="350px">
    <tr><th colspan="2"><h2><u> Update Discom</u></h2></th></tr>
    <tr>
        <td>Discom name:</td>
        <td><select name="discomID" id="oldDiscom" style="width:150px;height:20px;font-size:12px;font-family:verdana;" onchange="showEditDiscom();">
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
    </tr></table>
            
            <div id="editDiscom" style="visibility: hidden"><table bgcolor="#E0ECF8" width="350px"><tr>
        <td>Edit Discom</td>
        <td><input type="text" id="newDiscom" /></td>
    <tr>
        <td></td>
        <td><input type="button"  id="update" value="update" onclick="updateDiscom()"/></td>
    </tr></table></div>
