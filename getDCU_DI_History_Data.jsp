<%@ page session="false" %>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ include file="getConnection.jsp"%>
<link rel="stylesheet" type="text/css" href="css/style.css" />
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.3.1/jquery.min.js"></script>
<script type="text/javascript" src="js/sh_main.min.js"></script>
<script type="text/javascript" src="js/sh_javascript.js"></script>
<script type="text/javascript" src="js/jquery.fixedtable.js"></script>


<script type="text/javascript">
    $(document).ready(function() {
        sh_highlightDocument();

        $(".tableDiv").each(function() {
            var Id = $(this).get(0).id;
            var maintbheight = 555;
            var maintbwidth = 760;

            $("#" + Id + " .FixedTables").fixedTable({
                width: maintbwidth,
                height: maintbheight,
                fixedColumns: 1,
                classHeader: "fixedHead",
                classFooter: "fixedFoot",
                classColumn: "fixedColumn",
                fixedColumnWidth: 150,
                outerId: Id,
                Contentbackcolor: "#FFFFFF",
                Contenthovercolor: "#99CCFF",
                fixedColumnbackcolor:"#187BAF",
                fixedColumnhovercolor:"#99CCFF"
            });
        });
    });
</script>


<style type="text/css">

    .fixedColumn .fixedTable td
    {
        color: #FFFFFF;
        background-color: #187BAF;
        font-size: 12px;
        font-weight: normal;
    }

    .fixedHead td, .fixedFoot td
    {
        color: #FFFFFF;
        background-color: #187BAF;
        font-size: 12px;
        font-weight: normal;
        padding: 5px;
        border: 1px solid #187BAF;
    }
    .fixedTable td
    {
        font-size: 8.5pt;
        background-color: #FFFFFF;
        padding: 5px;
        text-align: left;
        border: 1px solid #CEE7FF;
    }
</style>
<body>
    <%
        try {
            NumberFormat twoDecFormat = new DecimalFormat("#0.00");
            SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
            SimpleDateFormat dateFormat1 = new SimpleDateFormat("yyyy-MM-dd");
            SimpleDateFormat timeFormat = new SimpleDateFormat("HH:mm:ss");
            String dcu_id = request.getParameter("dcu_id");
            String feeder_id = request.getParameter("feeder_id");
            String from_date = request.getParameter("from_date");
            String from_time = request.getParameter("from_time");
            String to_date = request.getParameter("to_date");
            String to_time = request.getParameter("to_time");
            System.out.println(from_date);
            System.out.println(to_date);
            PreparedStatement pstmt = con.prepareStatement("select Name1,Description from digital_input_details where rtu_id=? order by srlno");
            pstmt.setString(1, dcu_id);
            ResultSet rs = pstmt.executeQuery();
            Map param_names = new HashMap();
            String[] di_temp = new String[100];
            int i = 0;
            while (rs.next()) {
                di_temp[i] = rs.getString("Name1");
                param_names.put(rs.getString("Name1"), rs.getString("DESCRIPTION"));
                i++;
            }
            String[] di = new String[i];
    %>
    <div id="tableDiv_Arrays" class="tableDiv">
        <table border="0" cellpadding="0" cellspacing="0px" >
            <tr>
                <td valign="top">
                    <table border="0" class="FixedTables" id="table_disp" cellpadding="0" cellspacing="1px" align="left">

                        <%
                            String time_values_str = "";
                            for (int j = 0; j < i; j++) {
                                di[j] = di_temp[j];

                                pstmt = con.prepareStatement("SELECT * FROM rtu_di_data where DI_NAME=? and RTU_ID=? and timestamp(CONCAT(DI_DATE,' ',TIME)) >= timestamp(?) and timestamp(CONCAT(DI_DATE,' ',TIME)) <= timestamp(?) order by SNO");
                                pstmt.setString(1, di[j]);
                                pstmt.setString(2, dcu_id);
                                pstmt.setString(3, dateFormat1.format(dateFormat.parse(from_date)) + " " + from_time);
                                pstmt.setString(4, dateFormat1.format(dateFormat.parse(to_date)) + " " + to_time);
                                rs = pstmt.executeQuery();
                        %>
                        <thead>
                            <tr>
                                <td style="-moz-border-radius: 3px;
                                    -webkit-border-radius: 3px;
                                    border-radius: 3px;
                                    -moz-box-shadow: 0 6px 10px #A1A1A1;
                                    -webkit-box-shadow: 0 6px 10px #A1A1A1;">Description</td>
                                <%
                                    while (rs.next()) {
                                        out.println("<td align=right  style=\"width:250px;-moz-border-radius: 3px;-webkit-border-radius: 3px;border-radius: 3px;-moz-box-shadow: 0 6px 10px #A1A1A1;-webkit-box-shadow: 0 6px 10px #A1A1A1;\" >" + dateFormat.format(dateFormat1.parse(rs.getString("DI_DATE"))) + "<br />" + rs.getString("time") + "</td>");
                                    }
                                %>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                    break;
                                }
                                int data_flag = 0;
                                for (int j = 0; j < i; j++) {
                                    di[j] = di_temp[j];

                                    pstmt = con.prepareStatement("SELECT * FROM rtu_di_data where DI_NAME=? and RTU_ID=? and timestamp(CONCAT(DI_DATE,' ',TIME)) >= timestamp(?) and timestamp(CONCAT(DI_DATE,' ',TIME)) <= timestamp(?) order by SNO");
                                    pstmt.setString(1, di[j]);
                                    pstmt.setString(2, dcu_id);
                                    pstmt.setString(3, dateFormat1.format(dateFormat.parse(from_date)) + " " + from_time);
                                    pstmt.setString(4, dateFormat1.format(dateFormat.parse(to_date)) + " " + to_time);
                                    rs = pstmt.executeQuery();
                            %>
                            <tr>
                                <td width="180px"><%= param_names.get(di[j])%>&nbsp;</td>
                                <%
                                    int no_of_val = 0;
                                    while (rs.next()) {
                                        data_flag = 1;
                                        int di_value = Integer.parseInt(rs.getString("di_value"));
                                        out.println("<td>");
                                        switch (di_value) {
                                            case 0:
                                                out.println("Undefined");
                                                break;
                                            case 1:
                                                out.println("OPEN");
                                                break;
                                            case 2:
                                                out.println("CLOSE");
                                                break;
                                            case 3:
                                                out.println("Transiant");
                                                break;
                                        }
                                        out.println("</td>");
                                        no_of_val++;
                                    }
                                %>
                            </tr>
                            <%
                                }
                                System.out.println("data_flag:" + data_flag);
                                if (data_flag == 0) {
                            %>
                            <tr>
                                <td width="600px">Data Not Available.</td>
                            </tr>
                            <%            }
                            %>
                        </tbody>
                    </table>
                </td>
            </tr>
        </table>
    </div>
    <%
        } catch (Exception e) {
            e.printStackTrace();
        }
        finally{
            con.close();
        }
    %>

</body>