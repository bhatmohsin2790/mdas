<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page contentType="application/x-www-form-urlencoded" pageEncoding="UTF-8"%>
<%@ page import="in.amitech.db.*,java.io.*"%>
<%--request.getParameter("data") --%>
<% System.out.println(getServletContext().getRealPath("/"));%>
<%
    try {
        System.out.println("File Reading start");
        FileReader fr = new FileReader(getServletContext().getRealPath("/") + "pro_drop_1/pro_drop_1.css");
        String substr = "";
        String totalString = "";
        BufferedReader br = new BufferedReader(fr, 1024);
        while ((substr = br.readLine()) != null) {
            totalString = totalString + substr;
        }
        totalString = request.getParameter("data");
        //System.out.println("totalString--->"+request.getParameter("data"));

        ActionBeans.GeneratePDF gpdf = new ActionBeans.GeneratePDF();
        gpdf.createPdf1(totalString);



         //CreatePDF pdf = new CreatePDF();              
        //pdf.createPDF1("<style>"+totalString+"</style>"+request.getParameter("data"));
        // pdf.createPDF1(request.getParameter("data"));
    } catch (Exception e) {
        //e.printStackTrace();
    }
%>
