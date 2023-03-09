<%@ page session="false" %>
<%@page import="java.sql.*" %>
<%
  Connection con=null;
  ResultSet rs=null;
  Statement st=null;
  String sql="",data="";
  

    try
    {
        
        con=new DBUtil().getConnection();
        sql="select * from user_privileges";
        st=con.createStatement();
        rs=st.executeQuery(sql);
        while(rs.next())
            {
                    data=data+""+rs.getString("zones")
                    +","+rs.getString("circles")
                    +","+rs.getString("divisions")
                    +","+rs.getString("subdivisions")
                    +","+rs.getString("substations")
                    +","+rs.getString("feeders")
                    +","+rs.getString("dtrs")
                    +","+rs.getString("consumers")
                    +","+rs.getString("meters")
                    +","+rs.getString("feedercurrentdata")
                    +","+rs.getString("feedertotaldata")
                    +","+rs.getString("feederreports")
                    +","+rs.getString("dtrcurrentdata")
                    +","+rs.getString("dtrtotaldata")
                    +","+rs.getString("dtrreports")+",";
            }
        System.out.println("data is------------->"+data);
    }
    catch(Exception e)
    {
        out.println(e);
    }
        data=data.replaceAll("1","true");
        data=data.replaceAll("0","false");
        out.println(data);



%>

