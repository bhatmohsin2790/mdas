<%@ page session="false" %>
<%@ page import="java.sql.*" %>
<%@ page import="in.amitech.db.DBUtil"%>
   <style>
            
        </style>


  
    <table id="dtable"  align="center"  cellpadding="0" cellspacing="0" >        
        <thead>    
    <tr>
        <th >USER_ID</th>   
        <th >USER_TYPE</th>      
        <th >IS_ACTIVE</th>   
        <th >Office_Type</th>
        <th >Office</th>
        <th >Last Logged-in</th>
   </tr></thead>
   <tbody> 
       <%
                                Connection con13 = new DBUtil().getConnection();
                                Statement st13 = null;
                                ResultSet rs13 = null;
                                Statement st14 = null;
                                ResultSet rs14 = null;                                
                                try
				{
                                    st13 = con13.createStatement();
                                    rs13 = st13.executeQuery("select u.user_id,ut.user_type_name,u.is_active,u.first_name,u.last_name,u.office_id o_id,(select office_type_name from Admin_Hierarchy a where a.office_type_code = u.office_id) office_type,office_type_id,lastlogin from users u,user_types ut where u.user_type=ut.user_type_id order by upper(u.user_id)");

                                    while (rs13.next())
				    {
        %>                                <tr class="trbg">
                                           <td class="tdbg"><%=rs13.getString("user_id")%></td>
                                           <td class="tdbg"><%=rs13.getString(2)%></td>
                                      <%     if(Integer.parseInt(rs13.getString("is_active"))==1 ){
                                      %>
                                           <td class="tdbg">True</td>
                                           <% }
                                                else   if(Integer.parseInt(rs13.getString("is_active"))==0 ){  %>
                                                    <td class="tdbg">False</td> 
                                                            <% } %>
                                       <%
                                       if(rs13.getString("o_id").equals("all")){ %>
                                           <td class="tdbg">All</td> 
                                       <% }else{ %>
                                           <td class="tdbg"><%=rs13.getString("office_type")%></td> 
                                       <% }
                                       if(rs13.getString("o_id").equals("all")){
                                       %>
                                            <td class="tdbg">All</td> 
                                       <% } else{
                                            st14 = con13.createStatement();
                                            String strSql="";
                                            if(rs13.getString("o_id").equals("RO")){
                                                strSql=" select DISCOM_NAME  as NAME  from discom where DISCOM_ID='"+rs13.getString("office_type_id")+"'";
                                            } else if(rs13.getString("o_id").equals("CO")){
                                               strSql=" select CIRCLENAME  as NAME  from circle where CIRCLEID='"+rs13.getString("office_type_id")+"'"; 
                                            } else if(rs13.getString("o_id").equals("DO")){
                                               strSql=" select DIVISIONNAME  as NAME  from division where DIVISIONID='"+rs13.getString("office_type_id")+"'"; 
                                            } else if(rs13.getString("o_id").equals("SDO")){
                                               strSql=" select subdivname  as NAME  from subdivision where subdivid='"+rs13.getString("office_type_id")+"'";  
                                            }
                                            
                                            rs14 = st14.executeQuery(strSql);
                                            if(rs14.next()){ %>
                                                <td class="tdbg"><%=rs14.getString("NAME")%></td>    
                                         <%   } else {  %>
                                                <td class="tdbg">All</td> 
                                          <%  }
                                       }
                                       %> 
                                       <td class="tdbg"><%=rs13.getString("lastlogin")==null?" ":rs13.getString("lastlogin")%></td>    
                                    </tr>
       <%
                                    }
                                }
                                catch (Exception e)
                                {
                                      e.printStackTrace();
                                }
        %>
       
        </tbody>
   
</table>

  