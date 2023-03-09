<%@ include file="getConnection.jsp"%>
<%!    PreparedStatement pstmt = null;
    ResultSet rs = null;
%>
<%    try {
        String officeType = request.getParameter("officeType");
        String data = "-1_All";
        String sql = "";
        if (officeType.equals("RO")) {
            sql = "select discom_id,discom_name from discom";
            data = data + ":" + "0_All";
        } else if (officeType.equals("CO")) {
            sql = "select circleid,circlename from circle";
        } else if (officeType.equals("DO")) {            
            sql = "select divisionid,divisionname from division";
        } else if (officeType.equals("SDO")) {
            sql = "select subdivid,subdivname from subdivision order by subdivname";
        }
        pstmt = con.prepareStatement(sql);
        rs = pstmt.executeQuery();
        while (rs.next()) {
            data = data + ":" + rs.getString(1) + "_" + rs.getString(2);
        }
        out.print(data);

    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        con.close();
    }
%>