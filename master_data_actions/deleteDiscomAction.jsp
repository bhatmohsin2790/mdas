<%@ page session="false" %>
<%@include file="../masterDataActions.jsp" %>
<%

            String discomId = null;
            try {
                discomId = request.getParameter("discomId");
                if (deleteDiscom(Integer.parseInt(discomId)) > 0) {
                    out.println("Discom deleted Successfully : " + discomId);
                } else {
                    out.println("Discom deletion Failed, Try Again :" + discomId);
                }//end else

            } catch (Exception e) {
                out.println(e.getMessage());
            }//end catch
%>