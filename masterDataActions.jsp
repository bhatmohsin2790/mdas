<%@page import="java.util.Hashtable"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="in.amitech.db.DBUtil"%>
<%@page import="java.util.Map"%>
<%!
    public Map<Integer, String> getDiscoms() throws Exception {
        DBUtil db = null;
        Connection con = null;
        Statement st = null;
        ResultSet rs = null;
        String sql = null;
        Map<Integer, String> map = null;
        try {
            db = new DBUtil();
            con = db.getConnection();
            sql = "select * from discom";
            st = con.createStatement();
            rs = st.executeQuery(sql);
            map = new Hashtable<Integer, String>();
            while (rs.next()) {
                map.put(rs.getInt("discom_id"), rs.getString("discom_name"));
            }//end while
            return map;
        } finally {
            if (rs != null) {
                rs.close();
            }//end if
            if (st != null) {
                st.close();
            }//end if
            if (con != null) {
                con.close();
            }//end if
        }//end finally
    }//end method

    public int insertDiscom(String discomName) throws Exception {
        DBUtil db = null;
        Connection con = null;
        Statement st = null;
        ResultSet rs = null;
        String sql = null;
        Map<Integer, String> map = null;
        try {
            db = new DBUtil();
            con = db.getConnection();
            sql = "insert into discom(discom_name) values('"+discomName+"')";
            st = con.createStatement();
            return st.executeUpdate(sql);
        } finally {
            if (st != null) {
                st.close();
            }//end if
            if (con != null) {
                con.close();
            }//end if
        }//end finally
    }//end method

    public int deleteDiscom(int discomId) throws Exception {
        DBUtil db = null;
        Connection con = null;
        Statement st = null;
        ResultSet rs = null;
        String sql = null;
        Map<Integer, String> map = null;
        try {
            db = new DBUtil();
            con = db.getConnection();
            sql = "delete from discom where discom_id="+discomId;
            st = con.createStatement();
            return st.executeUpdate(sql);
        } finally {
            if (st != null) {
                st.close();
            }//end if
            if (con != null) {
                con.close();
            }//end if
        }//end finally
    }//end method
%>