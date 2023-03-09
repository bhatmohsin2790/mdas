<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@page import="ami.util.ReadAndPrintXMLFile"%>
<%
//ReadAndPrintXMLFile xml_read = new ReadAndPrintXMLFile();
//xml_read.main();

%>
<html:form action="/xmlFileUpload_DB" method="post" enctype="multipart/form-data">
Select RTU XML File : <html:file property="theFile"/> <br />
<html:submit>Upload File</html:submit>
</html:form>