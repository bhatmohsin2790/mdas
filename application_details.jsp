<%@page import="java.sql.*" %>
<%@page import="java.io.*" %>

<%
    Connection con = null;
    ResultSet rs = null;
    PreparedStatement pst = null;
    FileInputStream fis = null;


    String fname = request.getParameter("fname");
    String lname = request.getParameter("lname");
    String mname = request.getParameter("mname");
    String mobile = request.getParameter("mobile");
    String file = request.getParameter("file");
    String email = request.getParameter("email");
    String lnumber = request.getParameter("lnumber");
    String quali = request.getParameter("quali");
    String farea = request.getParameter("farea");
    String exp_years = request.getParameter("exp_years");
    String exp_months = request.getParameter("exp_months");
    String loc = request.getParameter("loc");
    String value = fname + "" + lname + "" + mname + "" + mobile + "" + file + "" + email + "" + lnumber + "" + quali + "" + farea + "" + exp_years + "" + exp_months + "" + loc;

    try {
        Class.forName("oracle.jdbc.OracleDriver");
        con = DriverManager.getConnection("jdbc:oracle:thin:@192.168.1.110:1521:XE", "mdas", "mdas");
        String sql = "insert into hr_recruitment("
                + "FIRST_NAME,MIDDLE_NAME,LAST_NAME,EMAIL,MOBILE,LANDLINE,QUALIFICATION,FUNCTIONAL_AREA,"
                + "EXP_YEARS,EXP_MONTHS,LOCATION,RESUME) "
                + "values(?,?,?,?,?,?,?,?,?,?,?,?)";
        pst = con.prepareStatement(sql);

        pst.setString(1, fname);
        pst.setString(2, mname);
        pst.setString(3, lname);
        pst.setString(4, email);
        pst.setString(5, mobile);
        pst.setString(6, lnumber);
        pst.setString(7, quali);
        pst.setString(8, farea);
        pst.setInt(9, Integer.parseInt(exp_years));
        pst.setInt(10, Integer.parseInt(exp_months));
        pst.setString(11, loc);
        pst.setBytes(12, file.getBytes());
        int res = pst.executeUpdate();
        if (res != 0) {
            out.println("values are inserted successfully....!");
        } else {
            out.println("values are not inserted....!");
        }

    } catch (Exception e) {
        out.println("Error from database" + e);
    } finally {
        con.close();
    }


%>
