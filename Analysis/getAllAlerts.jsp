<%@page import="java.util.*"%>
<%@ page import="java.sql.*" %>
<%@page import="in.amitech.db.DBUtil"%>
<%@page import="ActionBeans.AnalysisAction"%>
<style>
        .thstyle{
        background-color: #8FA1B5; 
        color:#FFFFFF;
         font-size:14px;
         border-left:1px solid #FFFFFF;
          text-decoration:none;
          font-family: monospace;
           border-bottom: 1px solid #FFFFFF;
           
        }
        .trbg{
            background-color: #E8EBE2;
             border-bottom: 1px solid #FFFFFF;
        }
        .tdbg{
             border-bottom: 1px solid #FFFFFF;
             border-left: 1px solid #FFFFFF;
        }
        #district_11kv_load tr  td {
             background-color: #E8EBE2;
              border-bottom: 1px solid #FFFFFF;
             border-left: 1px solid #FFFFFF;
        }
     </style> 
<% 
  String townId=request.getParameter("townId").trim();
  String metersType = request.getParameter("metersType");
  String category=request.getParameter("category");
 
 ResultSet rs=null;
 Connection con=null;
 String sql="",lastAlert="",alertDate="";
  int slno=1;
 
%>
<table width="100%" class="stdtable stdtablecb smallfont" id="dtable">
  <thead >
        <tr >
            <th class="thstyle">Sl No</th>
            <th class="thstyle">Location Name</th>       
            <th class="thstyle">Meter Sl No</th>
            <th class="thstyle">Last Alert From Modem/Meter</th>           
            <th class="thstyle">Alert Date & Time </th>           
        </tr>
    </thead>  
    <tbody>
        <%
            try {
                  HttpSession sess=request.getSession(false);
                 String office_type=sess.getAttribute("office_type").toString();
                 String office_type_id=sess.getAttribute("office_type_id").toString();
                con = new DBUtil().getConnection();
                Map meters= new AnalysisAction().getAllmeters(townId, metersType,category,office_type,office_type_id);
                System.out.println("totl ameters =====>"+meters.size());
                Iterator it= meters.entrySet().iterator();
                 sql="select * from (select ml.*,rownum from modem_alerts ml order by alert_id desc) where meter_id=? and rownum=1";
                while(it.hasNext()){
                     Map.Entry am=(Map.Entry)it.next();
                     PreparedStatement ps=con.prepareStatement(sql);
                     ps.setString(1,am.getKey().toString().trim());
                     rs=ps.executeQuery();
                     if(rs.next()){
                         lastAlert=rs.getString("alert_desc");
                         alertDate=rs.getTimestamp("alert_generated_date").toString();
                                                 }
                    %>
                    <tr class="trbg">
                        <td class="trbg" align="center"><%=slno%></td>
                        <td class="tdbg"><%=am.getValue().toString().split(",")[0]%></td>
                        <td class="tdbg"><%=am.getKey()%></td>
                        <td class="tdbg" align="center"><%=lastAlert%></td>
                        <td class="tdbg" align="center"><%=alertDate%></td>
                    </tr>
              <% slno++;
                           }
                
            }//try
            catch (Exception e) {
               // out.println("<h4>Error:</h4>" + e.getMessage());
                e.printStackTrace();
            }

        %>
        
    </tbody>
    
</table>