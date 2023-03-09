<%@ page session="false" %>

<%@page import="in.amitech.db.DBUtil"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%
            Connection conuml = null;
            PreparedStatement stuml = null;
            String locid = null;
            String locname = null;
            locid = request.getParameter("locid").trim();
            locname = request.getParameter("locname").trim();
            String msg;
            conuml = new DBUtil().getConnection();
            String query = "  update meterlocation set locationname='" + locname + "'  where locationid=" + locid + "  ";
            stuml = conuml.prepareStatement(query);
            if (stuml.executeUpdate() > 0) {
                out.println("MeterLocation Updated Successfully : " + locid);
            } else {
                out.println("MeterLocation Updated Failed, Try Again :" + locid);
            }//end else
            //  if (stuml.executeUpdate() > 0) {
            //String locaaId = "MeterLocation Updated Successfully";
            // responseXML.append("<locationid>" + locaaId + "</locationid>");
            //   }else{
            //     String loccName = "MeterLocation Updated Failed, Try Again ";
            //    responseXML.append("<locationname>" + loccName + "</locationname>");

            //}

%>
<!--
try {
		StringBuffer responseXML = new StringBuffer();
                response.setContentType("text/xml");
                response.setHeader("Cache-Control", "no-cache");
                responseXML.append("<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?>");
                responseXML.append("<MeterLocation>");
                if (stuml.executeUpdate() > 0) {
                    msg = "MeterLocation Updated Successfully";

                } else {
                    msg = "MeterLocation Updation Failed, Try Again ";
                }
                responseXML.append("<message>" + msg + "</message>");

                responseXML.append("</MeterLocation>");
                System.out.println("responseXML.toString()------------" + responseXML.toString());
                response.getWriter().write(responseXML.toString());
            } catch (Exception e) {
                System.out.println("Exception occured due to " + e);
            }

-->