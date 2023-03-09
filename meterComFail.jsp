<%@page import=" java.io.*"%>
<%@page import=" java.sql.*"%>
<%@page import=" org.apache.poi.hssf.usermodel.HSSFSheet"%>
<%@page import=" org.apache.poi.hssf.usermodel.HSSFWorkbook"%>
<%@page import=" org.apache.poi.hssf.usermodel.HSSFRow"%>
<%@page import=" org.apache.poi.hssf.usermodel.HSSFCell"%>

<%
try{


HSSFWorkbook wb = new HSSFWorkbook();
HSSFSheet sheet = wb.createSheet("Excel Sheet");
HSSFRow rowhead = sheet.createRow((short)0);
rowhead.createCell((short) 0).setCellValue("Roll No");
rowhead.createCell((short) 1).setCellValue("Name");
rowhead.createCell((short) 2).setCellValue("Marks");
rowhead.createCell((short) 3).setCellValue("Grade");

int index=1;


HSSFRow row = sheet.createRow((short)index);
row.createCell((short)0).setCellValue(1);
row.createCell((short)1).setCellValue("maruthi");
row.createCell((short)2).setCellValue(123);
row.createCell((short)3).setCellValue("A");
index++;
//to get desktop path
String desktopPath = System.getProperty("user.home") + "/Desktop";
String path=desktopPath.replace("\\", "/");
        System.out.print("desktop path is"+path);
FileOutputStream fileOut = new FileOutputStream(path+"/excelFile.xls");
wb.write(fileOut);
fileOut.close();
out.println("Data is saved in excel file.");

}
catch(Exception e){}
%>