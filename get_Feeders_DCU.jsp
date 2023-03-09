<%@ page session="false" %>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.sql.*"%>
<link rel="stylesheet" type="text/css" href="css/style.css" />
<%@ include file="getConnection.jsp"%>
<%
try
{
    Statement stmt=null;
    String sql=null;
     ResultSet rs=null,rsfeeder=null,rset=null;
     PreparedStatement pstmt=null,ps=null;
    String dcu_id = request.getParameter("dcu_id");
    System.out.println("dcu_d-->"+dcu_id);
     pstmt =  con.prepareStatement("select * from feeder where substationid=?");
    pstmt.setString(1, dcu_id);
    rs = pstmt.executeQuery();
   
    int i=0;
    String strt_di ="";
    %>
    <form action="feeder_type_save.jsp" method="post">
        <input type="hidden" name="dcu_id1" value="<%=dcu_id%>" />
    <table border="0">
        <tr>
            <td valign="top">
                
    <table border="0" width="auto" id="table_div" cellpadding="0" cellspacing="1px" >
        <thead><tr>
            <td align="center" style="background-color: #EEEEEE">Feeder Name</td>
            <td align="center" style="background-color: #EEEEEE">Feeder Type</td>
            <td align="center" style="background-color: #EEEEEE">DI Name</td>
            <td align="center" style="background-color: #EEEEEE">Incoming Feeder</td>
        </tr></thead>
    <%
    int list = 0;
    int table_count = 1;
    while (rs.next())
    {
     //System.out.println("Feeder Name :"+rs.getString("FEEDERNAME"));   
        i++;
        if(list!=0 && list%8==0)
        {
            table_count++;
        %>
    </table>
            </td>
            <td valign="top">
        <table border="0" width="auto" id="table_disp" cellpadding="0" cellspacing="1px" >
        <thead><tr>
            <td>Feeder Name</td>
            <td>Feeder Type</td>
             <td>DI Name</td>
             <td>Incoming Feeder</td>
        </tr></thead>
        <%
        }
        %>
        <tr>
            <td><input type="hidden" name="feeder_id" id="feeder_id<%=list%>" value='<%= rs.getString("FEEDERID") %>' /><%= rs.getString("FEEDERNAME") %></td>
            <td>
                <select name="feeder_type" id="feeder_type<%=list%>">
                    <option value="0" <%= (rs.getString("feeder_type").equals("0")) ? "selected=selected":"" %>>Out-going</option>
                    <option value="1" <%= (rs.getString("feeder_type").equals("1")) ? "selected=selected":"" %>>In-coming</option>
                </select>
            </td>
            <td>
                <select name="DI_name" id="DI_name">
                    <option value="-1">DI_name</option>
            <% 
                   sql="select substr(name1,3) from digital_input_details where rtu_id="+dcu_id;
                    stmt=con.createStatement();
                   rset=stmt.executeQuery(sql);
                    System.out.println("query is---->"+sql);
                    while(rset.next())
                                               { %>
                        
                    <option value="<%=rset.getString(1)%>" ><%=rset.getString(1)%></option>
               
              <%      }
            %>
            </select>
            </td>
           
        
        <%
        list++;
        
        
    %>
    <td>
        <select name="incoming_feeder" id="incoming_feeder">
                    <option value="-1">incoming_feeder</option>
                    <% 
                    ps =  con.prepareStatement("select * from feeder where substationid=?");
                    ps.setString(1, dcu_id);
                    rsfeeder = ps.executeQuery();
                    while(rsfeeder.next()) { %>
                     <option value="<%=rsfeeder.getString("feederid")%>" ><%=rsfeeder.getString("feedername")%></option>
                     <% } %>
        </select>            
        
    </td> 
    <%
   
    %>
        </tr>
        <%} %>
    
   
    </table>
    
            </td>
        </tr>
        <tr>
        <td colspan="<%=list+2%>" align="center">
            <input type="submit" value="Save" />
        </td>
        </tr>
    </table>
        </form>
    <%
       }
catch(Exception e)
               {
    e.printStackTrace();
}
finally{
    con.close();
}
    %>