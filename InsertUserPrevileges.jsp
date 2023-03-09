<%@page import="ami.util.DBUtil"%>
<%@page import="java.sql.*" %>
<%
    int izones,icircles,idiv,isdiv,isstn,ifeeders,idtrs,icnsmrs,imeters,icdata,ifdr_tdata,ifdr_rprts,idtr_cdata,idtr_tdata,idtr_rprts;
    String userId=request.getParameter("userId");
    String zones = request.getParameter("zones");
    String circles = request.getParameter("circles");
    String div = request.getParameter("divisions");
    String sdiv = request.getParameter("subdivisions");
    String sstn = request.getParameter("substation");
    String feeders = request.getParameter("feeders");
    String dtrs = request.getParameter("dtrs");
    String cnsmrs = request.getParameter("consumers");
    String meters = request.getParameter("meters");
    String fdr_cdata = request.getParameter("feederCurrentdata");
    String fdr_tdata = request.getParameter("feederTotalData");
    String fdr_rprts = request.getParameter("feedersReports");
    String dtr_cdata = request.getParameter("dtrCurrentData");
    String dtr_tdata = request.getParameter("dtrTotalData");
    String dtr_rprts = request.getParameter("dtrReport");
    
    if(zones.equals("true"))
    {
        izones=1;
    }
    else
    {
        izones=0;
    }
    if(circles.equals("true"))
    {
        icircles=1;
    }
    else
    {
        icircles=0;
    }
    if(div.equals("true"))
    {
        idiv=1;
    }
    else
    {
        idiv=0;
    }
    if(sdiv.equals("true"))
    {
        isdiv=1;
    }
    else
    {
        isdiv=0;
    }
    if(sstn.equals("true"))
    {
        isstn=1;
    }
    else
    {
        isstn=0;
    }
    
    if(feeders.equals("true"))
    {
        ifeeders=1;
    }
    else
    {
        ifeeders=0;
    }
    if(dtrs.equals("true"))
    {
        idtrs=1;
    }
    else
    {
        idtrs=0;
    }
    if(cnsmrs.equals("true"))
    {
        icnsmrs=1;
    }
    else
    {
        icnsmrs=0;
    }
    
    if(meters.equals("true"))
    {
        imeters=1;
    }
    else
        {imeters=0;}
    
    if(fdr_cdata.equals("true"))
    {
        icdata=1;
    }
    else
    {
        icdata=0;
    }
    if(fdr_tdata.equals("true"))
    {
        ifdr_tdata=1;
    }
    else
    {
        ifdr_tdata=0;
    }
    
    if(fdr_rprts.equals("true"))
    {
        ifdr_rprts=1;
    }
    else
    {
        ifdr_rprts=0;
    }

    if(dtr_cdata.equals("true"))
    {
        idtr_cdata=1;
    }
    else
    {
        idtr_cdata=0;
    }
    
    if(dtr_tdata.equals("true"))
    {
        idtr_tdata=1;
    }
    else
    {
        idtr_tdata=0;
    }
    
    if(dtr_rprts.equals("true"))
    {
        idtr_rprts=1;
    }
    else
    {
        idtr_rprts=0;
    }
    
    Connection con=null;
    ResultSet rs=null;
    Statement st=null;
    String sql="";
    Class.forName("oracle.jdbc.OracleDriver");
    con=DriverManager.getConnection("jdbc:oracle:thin:@192.168.1.108:1521:XE","mdas","mdas");
    sql="select * from user_privileges where user_id='"+userId+"'";
    st=con.createStatement();
    rs=st.executeQuery(sql);
   

    if(!rs.next())
    {
        try
        {                
                con=new DBUtil().getConnection();
                sql="insert into user_privileges values('"+userId+"','"+izones+"','"+icircles+"','"+idiv+"','"+isdiv+"','"+isstn+"','"+ifeeders+"','"+idtrs+"','"+icnsmrs+"','"+imeters+"','"+icdata+"','"+ifdr_tdata+"','"+ifdr_rprts+"','"+idtr_cdata+"','"+idtr_tdata+"','"+idtr_rprts+"')";
                st=con.createStatement();
                rs=st.executeQuery(sql);
                out.println(userId+" is Added to user privileges successfully...!");

        }
        catch(Exception e)
        {
                out.println(e);
        }
        finally{
            con.close();
        }
    }
    else
    {
        out.println(userId+" is already added to user privileges.....!");
    }

%>

