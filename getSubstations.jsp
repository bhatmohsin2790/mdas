<%@ page session="false" %>
<%@ include file="getConnection.jsp"%>
<%!    
       PreparedStatement pstmt = null;
       ResultSet rs = null;
%>
<%
            try {
                //here sectionID is nothing but subDivID
                String sectionid = request.getParameter("emp_id").toString();
                System.out.println("Section ID---->" + sectionid);
                String data = "0_Select Receiving Station";
                String sql = "select * from substation where sectionid in ("
                        + "select sectionid from section where subdivid=" + sectionid + ")";
                //PreparedStatement pstmt = con.prepareStatement("select * from substation where sectionid='"+sectionid+"'");
                PreparedStatement pstmt = con.prepareStatement(sql);
                rs = pstmt.executeQuery();
                while (rs.next()) {
                    data = data + ":" + rs.getString("substationid") + "_" + rs.getString("substationname");
                }//end while

                // data = data +":Abc:Def:Ghisdfsdfsdfsdfsdfsdfsdfsdfsdfsddsf";
                out.println(data);
            } catch (Exception e) {
                e.printStackTrace();
            }
            finally{
                con.close();
            }
%>