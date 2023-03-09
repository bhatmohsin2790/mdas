<%@ page session="false" %>
<%@page import="in.amitech.db.DBUtil"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.*"%>

         <div style="overflow: scroll;width: 550px; height:400px">
    <style type="text/css">
            .pg-normal {
                color: black;
                font-weight: normal;
                text-decoration: none;
                cursor: pointer;
            }
            .pg-selected {
                color: black;
                font-weight: bold;
                text-decoration: underline;
                cursor: pointer;
            }
        </style>
        <!-- pagination concept using javascript -->
        <script>
function Pager(tableName, itemsPerPage) {
 this.tableName = tableName;
 this.itemsPerPage = itemsPerPage;
 this.currentPage = 1;
 this.pages = 0;
 this.inited = false;

 this.showRecords = function(from, to) {
 var rows = document.getElementById(tableName).rows;
 // i starts from 1 to skip table header row
 for (var i = 1; i < rows.length; i++) {
 if (i < from || i > to)
 rows[i].style.display = 'none';
 else
 rows[i].style.display = '';
 }
 }

 this.showPage = function(pageNumber) {
 if (! this.inited) {
 alert("not inited");
 return;
 }

 var oldPageAnchor = document.getElementById('pg'+this.currentPage);
 oldPageAnchor.className = 'pg-normal';

 this.currentPage = pageNumber;
 var newPageAnchor = document.getElementById('pg'+this.currentPage);
 newPageAnchor.className = 'pg-selected';

 var from = (pageNumber - 1) * itemsPerPage + 1;
 var to = from + itemsPerPage - 1;
 this.showRecords(from, to);
 }

 this.prev = function() {
 if (this.currentPage > 1)
 this.showPage(this.currentPage - 1);
 }

 this.next = function() {
 if (this.currentPage < this.pages) {
 this.showPage(this.currentPage + 1);
 }
 }

 this.init = function() {
 var rows = document.getElementById(tableName).rows;
 var records = (rows.length - 1);
 this.pages = Math.ceil(records / itemsPerPage);
 this.inited = true;
 }

 this.showPageNav = function(pagerName, positionId) {
 if (! this.inited) {
 alert("not inited");
 return;
 }
 var element = document.getElementById(positionId);

 var pagerHtml = '<span onclick="' + pagerName + '.prev();" class="pg-normal"> &#171 Prev </span> | ';
 for (var page = 1; page <= this.pages; page++)
 pagerHtml += '<span id="pg' + page + '" class="pg-normal" onclick="' + pagerName + '.showPage(' + page + ');">' + page + '</span> | ';
 pagerHtml += '<span onclick="'+pagerName+'.next();" class="pg-normal"> Next &#187;</span>';

 element.innerHTML = pagerHtml;
 }
}
</script>
    <table border="0" width="100%">
        <tr>
            <td>
                <div id="pageNavPosition" align="left"></div>
            </td>
        </tr>
        <tr>
            <td>
            <table border="1" class='mtable' id="htMeter_data" >
       <tbody>
       <tr><td colspan="3" align="center"><h2>Meters Mapped to HT</h2></td></tr>
      <tr>
      <td><h3>ConsumerId</h3></td>
      <td><h3>ConsumerName</h3></td>
              
      <td><h3>Meter_Sl_No</h3></td>
      </tr>
        <%
            Connection con3 = null;
            Statement st = null;
            String sql = null;
            sql="select h.consumerid,h.consumername,m.meter_serial_no from ht_consumer h,meter m where h.consumerid=m.htconsumerid order by consumerid asc";
             con3 = new DBUtil().getConnection();
                    st = con3.createStatement();
                    ResultSet rs3=st.executeQuery(sql);
                    while(rs3.next())
                        {

  %>
  <tr>
      <td><%=rs3.getInt(1)%></td>
      <td><%=rs3.getString(2)%></td>
      <td><%=rs3.getString("meter_serial_no")%></td>

  </tr>


  <%
  }
        %>
       </tbody></table></td></tr></table>
   <script type="text/javascript">
        var pager = new Pager('htMeter_data', 3);
        pager.init();
        pager.showPageNav('pager', 'pageNavPosition');
        pager.showPage(1);
    </script>


   </div>