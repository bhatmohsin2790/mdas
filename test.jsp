<%
response.setContentType("application/octet-stream");
			response.setHeader("Content-Disposition", "attachment;filename=test.csv");
			ServletOutputStream op = response.getOutputStream();
			String str="test";
			op.write(str.getBytes(),0,str.length());
			op.flush();
			op.close();
%>