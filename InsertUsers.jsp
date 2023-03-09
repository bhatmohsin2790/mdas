<%@ include file="getConnection.jsp"%>
<%@page import="java.sql.*;" %>

<%!    PreparedStatement pstmt = null; %>
<%
            ResultSet rs1,rs2=null;
            Statement st1,st2=null;
             con=null;
            PreparedStatement pstmt1=null;
            String sql2="",sql="",usertype="";
            String userId = request.getParameter("userId");
            String password = request.getParameter("password");
            String userTypeId = request.getParameter("userType");
            String zoneId = request.getParameter("zoneId");
            String circleId = request.getParameter("circleId");
            String isActive = request.getParameter("isActive");
            String firstName = request.getParameter("firstName");
            String lastName = request.getParameter("lastName");
            System.out.println("values from jsp page are"+userId+" "+password+" "+userTypeId+" "+zoneId+" "+circleId+" "+isActive+" "+firstName+" "+lastName);
            try
            {
                con=new DBUtil().getConnection();
                sql2="select * from USERS where USER_ID='"+userId+"'";
                st2=con.createStatement();
                rs2=st2.executeQuery(sql2);
                    String sql1="select user_type_name from user_types where user_type_id='"+userTypeId+"'";
                    st1=con.createStatement();
                    rs1=st1.executeQuery(sql1);
                    while(rs1.next())
                        {
                            usertype=rs1.getString("user_type_name");
                        }
                if(!rs2.next())
                {
                  
                   try
                   {

                        String vsql = "insert into users values(?,?,?,?,?,?,?,?)";
                        pstmt = con.prepareStatement(vsql);
                        pstmt.setString(1, userId);
                        pstmt.setString(2, password);
                        pstmt.setString(3, usertype);
                        pstmt.setString(4, zoneId);
                        pstmt.setString(5, circleId);
                        pstmt.setString(6, isActive);
                        pstmt.setString(7, firstName);
                        pstmt.setString(8, lastName);
                        pstmt.executeUpdate();
                        st1.close();
                        rs1.close();
                        out.println(userId+" Is inserted into database successfully....!");
                   }
                   catch(Exception e)
                   {
                            e.printStackTrace();
                            out.println(userId+" Is Not inserted into database....?");
                   }
                }
                else
                {
                   
                    try
                    {
                    
                    String u_sql="update users set password='"+password+"',user_type='"+usertype+"',zone_id='"+zoneId+"',circle_id='"+circleId+"',is_active='"+isActive+"',first_name='"+firstName+"',last_name='"+lastName+"' where user_id='"+userId+"'" ;
                    pstmt1=con.prepareStatement(u_sql);
                    int i=pstmt1.executeUpdate();
                    if(i>0)
                        {
                            out.println(userId+" Updated Successfully");
                        }
                    else
                        {
                            out.println(userId+" Values are not Updated");
                        }
                    }
                    catch(Exception e)
                    {
                            out.println(e);
                    }
                }
            }
            catch(Exception e)
            {
                    e.printStackTrace();
                    out.println("Error is----->"+e);
            }
            finally{
                con.close();
            }
       
           

%>
<br><br>
