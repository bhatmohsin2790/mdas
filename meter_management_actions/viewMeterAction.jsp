<%@ page session="false" %>
<%@page import="in.amitech.db.DBUtil"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.*"%>

    <table   id="dtable"  >
        <thead>
            <tr>
                <th>Meter SlNo</th>                            
                <th>Modem SlNo</th>
                <th>Meter Make</TH>
                <th>Meter Location</th>
                <th>Location Code</th>
                <th>Consumer Id</th>
                <th>Meter CTR</th>
                <th>Meter PTR</th>
                <th>Adopted CTR</th>
                <th>Adopted PTR</th>
            </tr>
        </thead>
        <tbody>
            <%
                Connection con1 = null;
                PreparedStatement st = null;
                String sql = null;
                int start = Integer.parseInt(request.getParameter("start"));
                
                con1 = new DBUtil().getConnection();
                
                ResultSet rs = null;
                
                if (DBUtil.getTargetDB().equals("oracle")) {
//                    sql = "select meter_serial_no,modem_serial_no,metermakename,locationname,meter_ctr,meter_ptr,adopted_ctr,adopted_ptr,location_code,consumerid from("
//                           + "select meter_serial_no,modem_serial_no,metermakename,locationname,meter_ctr,meter_ptr,adopted_ctr,adopted_ptr,location_code,consumerid,rownum r from("
//                           + "select meter_serial_no,modem_serial_no,mk.metermakename,ml.locationname,meter_ctr,meter_ptr,adopted_ctr,adopted_ptr,location_code,consumerid from meter m left join metermake mk on m.metermake=mk.metermakeid left join meterlocation ml on  m.meterlocation=ml.locationid) where rownum<=?) where r>=? ";
                   sql="select meter_serial_no,modem_serial_no,mk.metermakename,ml.locationname,meter_ctr,meter_ptr,adopted_ctr,adopted_ptr,location_code,consumerid from meter m left join metermake mk on m.metermake=mk.metermakeid left join meterlocation ml on  m.meterlocation=ml.locationid";
                    
                    st = con1.prepareStatement(sql);
                    

                }
                if (DBUtil.getTargetDB().equals("mysql")) {
                    
                }


                rs = st.executeQuery();
                while (rs.next()) {

            %>
            <tr>
                <td align="center"><%=rs.getString(1)%></td>
                <% if (rs.getString(2) == null) {%>
                <td align="center">.......</td>
                <% } else {%>
                <td align="center"><%=rs.getString(2)%></td>  <% }%>
                <% if (rs.getString(3) == null) {%>
                <td align="center">.......</td>
                <% } else {%>  
                <td align="center"><%=rs.getString(3)%></td> <% }%>
                <% if (rs.getString(4) == null) {%>
                <td align="center">.......</td>
                <% } else {%>
                <td align="center"><%=rs.getString(4)%></td> <% }%>
                <td align="center"><%=rs.getString(9)==null?"....":rs.getString(9)%></td>
                <td align="center"><%=rs.getString(10)==null?"....":rs.getString(10)%></td>
                <% if (rs.getString(5) == null) {%>
                <td align="center">.......</td>
                <% } else {%>
                <td align="center"><%=rs.getString(5)%></td> <% }%>
                <% if (rs.getString(6) == null) {%>
                <td align="center">.......</td>
                <% } else {%>
                <td align="center"><%=rs.getString(6)%></td> <% }%>
                <% if (rs.getString(7) == null) {%>
                <td align="center">.......</td>
                <% } else {%>
                <td align="center"><%=rs.getString(7)%></td> <% }%>
                <% if (rs.getString(8) == null) {%>
                <td align="center">.......</td>
                <% } else {%>
                <td align="center"><%=rs.getString(8)%></td> <% }%>
            </tr>

            <%
                }
            %>
        </tbody></table> 
    

<%
    if (con1 != null) {
        con1.close();
    }//end if
%>