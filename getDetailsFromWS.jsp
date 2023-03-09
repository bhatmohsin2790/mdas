<%@page import="jk_client_meter.change.ConsumerBean"%>
<%@page import="jk_client_meter.change.Client"%>
<%
    String result="";
    
try{
    
    String cc=request.getParameter("consumercode");
    System.out.println("-------"+cc);
    Client c=new Client();
    ConsumerBean cb=c.executeWS(cc);
    if(cb.getError()==null){
        result=result+","+cb.getCc();
        result=result+","+cb.getCname();
        result=result+","+cb.getAddr1();
        result=result+","+cb.getAddr2();
        result=result+","+cb.getSancload();
        result=result+","+cb.getSdo();
        result=result+","+cb.getFeeder();
        
        result=result.substring(1);
    }else{
        result=cb.getError();
    }
    
    System.out.println("-------"+result);
}catch(Exception e){
    result=e.getMessage();
    e.printStackTrace();
}
out.print(result);
%>