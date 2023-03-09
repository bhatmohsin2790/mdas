<div  id="side_selection">
                    <%@ include file="getConnection.jsp"%>
                    <%
                        Statement stmt1 = con.createStatement();
                        ResultSet rs1 = stmt1.executeQuery("select * from substation");
                    %>
                    <strong>Select Substation : </strong>
                    <select name="dcu_id" id="dcu_id" style="width:120px;height:20px;font-size:12px;" onchange="getDCUData_For_Mapping(this.value)">
                        <option value="-1">Select Substation</option>
                        <%
                            while(rs1.next())
                            {
                        %>  
                            <option value="<%= rs1.getString("substationid") %>"><%= rs1.getString("substationname") %></option>
                        <%
                            }
                        con.close();
                        %>
                    </select>
                    </div>                    
                    <div id="feeders_data">                        
                    </div>