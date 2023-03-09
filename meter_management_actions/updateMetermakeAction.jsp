<%@ page session="false" %>
<%@page import="in.amitech.db.DBUtil"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%
            Connection conumma = null;
            PreparedStatement stumma = null;
            String metermakeid = null;
            String metermakeName = null;
            String meterSeries = null;
            String meterVersion = null;
            String noofParams = null;
            String paramNames = null;
            String b4_Tod_Params = null;
            String d4_Params = null;
            metermakeid = request.getParameter("metermakeid").trim();
            metermakeName = request.getParameter("metermakeName").trim();
            meterSeries = request.getParameter("meterSeries").trim();
            meterVersion = request.getParameter("meterVersion").trim();
           // noofParams = request.getParameter("noofParams").trim();
          //  paramNames = request.getParameter("paramNames").trim();
           // b4_Tod_Params = request.getParameter("b4_Tod_Params").trim();
           // d4_Params = request.getParameter("d4_Params").trim();
            conumma = new DBUtil().getConnection();
            String queryumm = "  update metermake set metermakename='" + metermakeName + "',meter_series='" + meterSeries + "',meter_version='" + meterVersion + "' where metermakeid = " + metermakeid + "  ";
            stumma = conumma.prepareStatement(queryumm);

            if (stumma.executeUpdate() > 0) {
                out.println("MetermakeId Updated Successfully : " + metermakeid);
            } else {
                out.println("MetermakeId Updated Failed, Try Again :" + metermakeid);
            }//end else

%>