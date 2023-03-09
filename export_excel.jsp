

    
        
        <%
        try{
                 System.out.println("IN export to excell");
                 System.out.println(request.getParameter("data"));
                response.setContentType("application/vnd.ms-excel");
                out.print(request.getParameter("data"));
                               }catch(Exception e)
                                                                             {
                                   e.printStackTrace();
                               }
                 %>
        
   
   
   
success