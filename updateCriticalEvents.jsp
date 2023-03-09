<%@ page session="false" %>
<%@page import="java.sql.*" %>
<%@page import="in.amitech.db.DBUtil"%>
<form name="eventScreen" >

    <table cellpadding="5" cellspacing="5">
        <tr>
                                <td>Select Mail ID:</td>
                                <td>
                                    <select id="updatemailid" onchange="getMappedEvents()">
                                        <option value="-1">Select Mail</option>
                                        <% 
                                        try{
                                        Connection con= new DBUtil().getConnection();
                                        ResultSet rs= con.prepareStatement("select distinct(emailid) from critical_events").executeQuery();
                                        while(rs.next()){ %>
                                        <option value='<%=rs.getString("emailid") %>'><%=rs.getString("emailid") %></option>
                                         <%}
                                                                               }catch(Exception e){e.printStackTrace();}
                                        %>
                                        
                                    </select>
                                </td>
                            </tr>
        <tr><td colspan="7" style="height:1px;background-color:#ddd;">Select Events </td></tr>
        <tr>
            <td><input type="checkbox" name="R-Phase" value="1" onclick="deselect(this);"/> &nbsp;R-Phase Missing Pott </td>
            <td> <input type="checkbox" name="R-Phase" value="24" onclick="deselect(this);"/> &nbsp;R-Phase CT open</td>
            <td> <input type="checkbox" name="R-Phase" value="4" onclick="deselect(this);"/> &nbsp;R-Phase CT Reverse</td>
            <td> <input type="checkbox" name="R-Phase" value="23" onclick="deselect(this);"/> &nbsp;CT Open</td>
            <td> <input type="checkbox" name="R-Phase" value="27" onclick="deselect(this);"/> &nbsp;Magnetic Tamper</td>
            <td><input type="checkbox" name="R-Phase" value="28" onclick="deselect(this);"/> &nbsp;Neutral Distarbance </td>
            <td> <input type="checkbox" name="R-Phase" value="58" onclick="deselect(this);"/> &nbsp;Low Voltage</td>
        </tr>

        <tr><td> <input type="checkbox" name="R-Phase" value="2" onclick="deselect(this);"/> &nbsp;Y-Phase Missing Pott</td>
            <td> <input type="checkbox" name="R-Phase" value="25" onclick="deselect(this);"/> &nbsp;Y-Phase CT open</td>
            <td>  <input type="checkbox" name="R-Phase" value="5" onclick="deselect(this);"/> &nbsp;Y-Phase CT Reverse</td>
            <td>  <input type="checkbox" name="R-Phase" value="11" onclick="deselect(this);"/> &nbsp;Overload(Current) </td>
            <td> <input type="checkbox" name="R-Phase" value="7" onclick="deselect(this);"/> &nbsp;Load Imbalance</td>
            <td>  <input type="checkbox" name="R-Phase" value="19" onclick="deselect(this);"/> &nbsp;CT Short</td>
            <td><input type="checkbox" name="R-Phase" value="33" onclick="deselect(this);"/> &nbsp;High Voltage</td>
        </tr>
        <tr>  <td> <input type="checkbox" name="R-Phase" value="3" onclick="deselect(this);"/> &nbsp;B-Phase Missing Pott</td>
            <td> <input type="checkbox" name="R-Phase" value="26" onclick="deselect(this);"/> &nbsp;B-Phase CT open</td>
            <td> <input type="checkbox" name="R-Phase" value="6" onclick="deselect(this);"/> &nbsp;B-Phase CT Reverse</td>
            <td> <input type="checkbox" name="R-Phase" value="13" onclick="deselect(this);"/> &nbsp;Power Failed</td>
            <td> <input type="checkbox" name="R-Phase" value="14" onclick="deselect(this);"/> &nbsp;Voltage Unbalance</td>
            <td><input type="checkbox" name="R-Phase" value="12" onclick="deselect(this);"/> &nbsp;Very Low PF</td></tr>
       
        <tr><td colspan="2" style="height:1px;background-color:#ddd;padding-left:80px;">
                <input type="button" value="Update" name="Update" onclick="updateEvents();"
            </td></tr>

    </table></form>

