<%@ page session="false" %>
<%@include file="../masterDataActions.jsp" %>
<%
            String discomName = null;
            try {
                discomName = request.getParameter("discomName").trim();

                if (discomName.equals("")) {
                    System.out.println("Discom Name Should not be Empty :" + discomName);
                } else {
                    if (insertDiscom(discomName) > 0) {
                        out.println("Discom Added Successfully : " + discomName);
                    } else {
                        out.println("Discom Added Failed, Try Again :" + discomName);
                    }//end else
                }//end else
            } catch (Exception e) {
                if (discomName == null) {
                    out.println("discom Name Should Not be null");
                } else {
                    out.println(e.getMessage());
                }
            }//end catch
%>