<%@ page import="java.sql.*"%>
<%

   Class.forName("oracle.jdbc.OracleDriver");
   Connection con = DriverManager.getConnection("jdbc:oracle:thin:@192.168.1.108:1521:XE","mdas","mdas");

%>