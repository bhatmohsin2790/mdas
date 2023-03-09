<%@ page session="false" %>
<%@ include file="getConnection.jsp"%>
<%!    PreparedStatement pstmt = null;
    ResultSet rs = null;
%>
<%
            try {
               String userId=request.getParameter("userId");
              System.out.println("user id is -->"+userId);
                String data = "";
                String sql="SELECT  u.office_id,m.office_type,m.office_name from user_roles u,master_data m where u.office_id=m.office_id and u.user_id='"+userId+"'";
                System.out.println("sql is "+sql);
                 pstmt = con.prepareStatement(sql);                    
                    rs = pstmt.executeQuery();
                    while (rs.next()) {
                        data = rs.getString(3) + "(" + rs.getString(2) + ")" + ":" + data;
                    }

                System.out.println(data);
                out.print(data);
            } catch (Exception e) {
                throw new Exception("Database error");
                //e.printStackTrace();
            } finally {
                con.close();
            }
%>