<%@ page session="false" %>
<%@page import="in.amitech.db.DBUtil"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.*"%>


<style>
            #dtr_data h3
            {background-color:#EEEEEE;
border:1px solid #DDDDDD;
color:#666666;
 width:100px;
font-size:12px;
padding:5px 15px;
text-decoration:none;}
            .dtr_data
            {
           width:100px;
            }
        </style>
<table cellpadding="0" cellspacing="0" border="0" id="dtr_data" width="250px">
   
    <tr>
        <td  align="center"><h3>DTR Id</h3></td>
        <td align="center" ><h3>DTR Name</h3></td>
        <td  align="center"><h3>Feeder Name</h3></td>
    </tr>
    <%
                int start = Integer.parseInt(request.getParameter("start"));
                int limit = 10;
                int range=5;
                int count = 0;
                Connection con = null;
                PreparedStatement ps = null;
                ResultSet rs = null;
                String sql = null;
                sql = "select count(*) from dtr";
                con = new DBUtil().getConnection();
                ps = con.prepareStatement(sql);
                rs = ps.executeQuery();
                if (rs.next()) {
                    count = rs.getInt(1);
                }//end if
                System.out.println("Total Dtrs :" + count);

                //sql="select d.dtrid,d.dtrname,f.feedername from dtr d,feeder f where d.feederid=f.feederid";
                 if (DBUtil.getTargetDB().equals("oracle")) {
                sql = "select dtrid,dtrname,f.feedername from (select dtrid,dtrname,feederid,rownum r from ( select dtrid,dtrname,feederid from dtr order by dtrid) "
                        + "where rownum <= ? ) d,feeder f where d.feederid=f.feederid and r >= ?";

                ps = con.prepareStatement(sql);
                ps.setInt(1, start + limit);
                ps.setInt(2, start);
                 } else if (DBUtil.getTargetDB().equals("mysql")) {
                     sql=" select d.dtrid,d.dtrname,f.feedername from dtr d,feeder f where  d.feederid=f.feederid limit ?,?";
                      if (start == 1) {
                                        start = 0;
                                    }
                                    ps = con.prepareStatement(sql);                                    
                                    ps.setInt(1, start);
                                    ps.setInt(2, start + limit);
                                }//end else
                 

                rs = ps.executeQuery();
                while (rs.next()) {

    %>
    <tr>
        <td align="center"><%=rs.getInt(1)%></td>
        <td align="center"><%=rs.getString(2)%></td>
        <td align="center"><%=rs.getString("feedername")%></td>

    </tr>


    <%
                }
    %>
</table>
<!-- This table contains code to display the page numbers,previous and next hyperlinks  -->
<table width="100%" border="0">
      <tr>
          <td width="100%" align="center">
  <table>&nbsp;&nbsp;
    <tr>
        <%


                   // code for previous
int start_tmp = start;

                // code for page numbers
               //  start = 1;

                 if(((Integer.parseInt(request.getParameter("start"))-1)/10)+1>10)
                     {
                     %>
        <td id="pageNo" style="border:1px solid red;padding-right:5px;padding-left:5px;"><a href="#"  onclick="javascript:viewDtr(<%=((start_tmp/100)*100)-9%>)" style="text-decoration:none;">Prev 10</a></td>&nbsp;
        <%
                     }
                 int page_no_start = (start_tmp / 100)*100+1;
                 int page_no_end = ((start_tmp/100)*100)+90;
                 page_no_start = (page_no_start / 10)+1;
                 page_no_end =  (page_no_end/10)+1;

                 start =1;
                 if(page_no_end>=Math.ceil((double) count / (double) limit))
                     page_no_end = (int)Math.ceil((double) count / (double) limit);

                   for (int i = 1; i <= Math.ceil((double) count / (double) limit); i++)
                    {
                    if(i>=page_no_start && i<=page_no_end)
                        {
                    if(i==((Integer.parseInt(request.getParameter("start"))-1)/10)+1)
                        {
        %>

        <td id="pageNo" style="border:1px solid red;padding-right:5px;padding-left:5px;"><a href="#"  onclick="javascript:viewDtr(<%=start%>)" style="text-decoration:none;"><%=i%></a></td>&nbsp;

        <%
                       }

                  else

                        {
        %>

        <td id="pageNo"><a href="#"  onclick="javascript:viewDtr(<%=start%>)"><%=i%></a></td>&nbsp;

        <%
                        }
                    }
                       start = start + limit;
                        }
             // code for next
                        //if((((Integer.parseInt(request.getParameter("start"))-1)/10)+1)>=1)
                 start = start_tmp;
                            if(page_no_end>=Math.ceil((double) count / (double) limit))
                            {}else{


                            start=Integer.parseInt(request.getParameter("start"))+100;

%>

        <td id="pageNo"  style="border:1px solid red;padding-right:5px;padding-left:5px;"><a href="#"  onclick="javascript:viewDtr(<%=start%>)" style="text-decoration:none;">Next 10</a></td>&nbsp;

        <%
        }

%>
    </tr>
</table>
          </td>
      </tr>
  </table>
<%
           con.close();
%>