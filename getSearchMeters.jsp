
<%@ page session="false" %>
<%@ include file="getConnection.jsp"%>
<%!    PreparedStatement pstmt = null;
       ResultSet rs = null;
//       Connection con = null;
       int counter=1;
%>
<%
            //---------------------------------------------
            HttpSession sess=request.getSession(false);
            String office_type=sess.getAttribute("office_type").toString();
            String office_type_id=sess.getAttribute("office_type_id").toString();
            //---------------------------------------------
            String meterId = null;String meterLoc=null;String sql=null,searchBy=null;
            int searchType = 0;
            try {
                int optVal = Integer.parseInt(request.getParameter("opt"));
                searchType = Integer.parseInt(request.getParameter("searchType"));
                meterLoc =request.getParameter("meterLoc").trim();
                meterId = request.getParameter("meterId");
                searchBy=request.getParameter("searchBy");
                String data = "";
       System.out.println("Search Type     "+searchType);
                if (searchType == -1) {
                  //search by option is selected
                     counter=1;
                   if(meterLoc.toUpperCase().equals("DTR"))
                   {
                     sql = "select m.meterid,m.meter_serial_no,d.dtrname from meter m,dtr d where m.dtrid in"
                             + " ( select dtrid from dtr where feederid in ( select feederid from feeder where substationid in "
                             + "(select substationid from substation where townid in ( select townid from town where subdivid in "
                             + "(select subdivid from subdivision where divisionid in ( select divisionid from division where circleid in "
                             + "(select circleid from circle where zoneid in ( select zoneid from zone where discom_id in "
                             + "(select discom_id from discom where discom_id=?))))))))) "
                             + "and m.dtrid=d.dtrid ";
                     if(searchBy.equals("meter"))
                         sql=sql+" and m.meter_serial_no like '"+meterId+"%'  order by d.dtrname asc";
                     if(searchBy.equals("name"))
                         sql=sql+" and LOWER(d.dtrname) like '%"+meterId.toLowerCase()+"%'  order by d.dtrname asc";
                     if(searchBy.equals("code"))
                         sql=sql+" and m.location_code like '"+meterId+"%'  order by d.dtrname asc";
                    }
                    if(meterLoc.toUpperCase().equals("HT"))
                   {
                        sql="select m.meterid,m.meter_serial_no,ht.consumername from meter m,ht_consumer ht where m.htconsumerid in "
                                + "(select consumerid from ht_consumer where feederid in (select feederid from feeder where substationid in "
                                + "(select substationid from substation where townid in (select townid from town where subdivid in "
                                + "(select subdivid from subdivision where divisionid in (select divisionid from division where circleid in"
                                + "(select circleid from circle where zoneid in (select zoneid from zone where discom_id in "
                                + "(select discom_id from discom where discom_id=?))))))))) and m.htconsumerid=ht.consumerid ";
                     if(searchBy.equals("meter"))
                         sql=sql+" and m.meter_serial_no like '"+meterId+"%'  order by ht.consumername asc";
                     if(searchBy.equals("name"))
                         sql=sql+" and LOWER(ht.consumername) like '%"+meterId.toLowerCase()+"%'  order by ht.consumername asc";
                     if(searchBy.equals("code"))
                         sql=sql+" and m.location_code like '"+meterId+"%'  order by ht.consumername asc";                  
                         }
                   if(meterLoc.toUpperCase().equals("FEEDER"))
                   {
                       sql="select m.meterid,m.meter_serial_no,f.feedername from meter m,feeder f where m.feederid in "
                               + " (select feederid from feeder where substationid in (select substationid from substation where townid in"
                               + " (select townid from town where subdivid in (select subdivid from subdivision where divisionid in"
                               + " (select divisionid from division where circleid in (select circleid from circle where zoneid in"
                               + " (select zoneid from zone where discom_id in (select discom_id from discom where discom_id=?))))))))"
                               + " and m.feederid=f.feederid ";
                    if(searchBy.equals("meter"))
                         sql=sql+" and m.meter_serial_no like '"+meterId+"%'  order by f.feedername asc";
                     if(searchBy.equals("name"))
                         sql=sql+" and LOWER(f.feedername) like '%"+meterId.toLowerCase()+"%'  order by f.feedername asc";
                     if(searchBy.equals("code"))
                         sql=sql+" and m.location_code like '"+meterId+"%'  order by f.feedername asc";                   
                       }
                 System.out.println("query--->"+sql);
                    pstmt = con.prepareStatement(sql);
                    pstmt.setInt(1, optVal);
                    rs = pstmt.executeQuery();
                    while (rs.next()) {
                       data = data+rs.getString("meterid") + "_" + rs.getString("meter_serial_no") + "-" + counter+"-"+rs.getString(3)+":" ;
                         counter++;
                       }//end while
                    if(meterLoc.toUpperCase().equals("FEEDER"))
                   {  data = "0_All-All Feeders:"+data;}
                    
                } 
                else if (searchType == 1) {  //discom is selected
                    counter=1;
                   if(meterLoc.toUpperCase().equals("DTR"))
                   {
                       if (office_type.equals("DO")) {
                         sql = "select m.meterid,m.meter_serial_no,d.dtrname from meter m,dtr d where m.dtrid in"
                             + " ( select dtrid from dtr where feederid in ( select feederid from feeder where substationid in "
                             + "(select substationid from substation where subdivid in(select subdivid from subdivision where divisionid="+office_type_id+" )))) "
                             + "and m.dtrid=d.dtrid and m.meter_serial_no like ?  order by d.dtrname asc";
                         pstmt = con.prepareStatement(sql);
                         pstmt.setString(1, meterId + "%");
                       }
                      else if (office_type.equals("SDO")) {
                         sql = "select m.meterid,m.meter_serial_no,d.dtrname from meter m,dtr d where m.dtrid in"
                             + " ( select dtrid from dtr where feederid in ( select feederid from feeder where substationid in "
                             + "(select substationid from substation where subdivid="+office_type_id+" ))) "
                             + "and m.dtrid=d.dtrid and m.meter_serial_no like ?  order by d.dtrname asc";
                         pstmt = con.prepareStatement(sql);
                         pstmt.setString(1, meterId + "%");
                       }
                       else{
                           sql = "select m.meterid,m.meter_serial_no,d.dtrname from meter m,dtr d where m.dtrid in"
                             + " ( select dtrid from dtr where feederid in ( select feederid from feeder where substationid in "
                             + "(select substationid from substation where  subdivid in "
                             + "(select subdivid from subdivision where divisionid in ( select divisionid from division where townid in(select townid from town where circleid in(select circleid from circle where zoneid in ( select zoneid from zone where discom_id in "
                             + "(select discom_id from discom where discom_id=?))))))))) "
                             + "and m.dtrid=d.dtrid and m.meter_serial_no like ?  order by d.dtrname asc";
                           pstmt = con.prepareStatement(sql);
                    pstmt.setInt(1, optVal);
                    pstmt.setString(2, meterId + "%");
                    }
                   }
                    if(meterLoc.toUpperCase().equals("HT"))
                   {
                       if (office_type.equals("DO")) {
                        sql="select m.meterid,m.meter_serial_no,ht.consumername from meter m,ht_consumer ht where m.htconsumerid in "
                                + "(select consumerid from ht_consumer where feederid in (select feederid from feeder where substationid in "
                                + "(select substationid from substation where  subdivid in(select subdivid from subdivision where divisionid="+office_type_id+")))) and m.htconsumerid=ht.consumerid and m.meter_serial_no like ? order by ht.consumername asc";
                   pstmt = con.prepareStatement(sql);
                    pstmt.setString(1, meterId + "%");
                   }
                     else  if (office_type.equals("SDO")) {
                        sql="select m.meterid,m.meter_serial_no,ht.consumername from meter m,ht_consumer ht where m.htconsumerid in "
                                + "(select consumerid from ht_consumer where feederid in (select feederid from feeder where substationid in "
                                + "(select substationid from substation where  subdivid="+office_type_id+"))) and m.htconsumerid=ht.consumerid and m.meter_serial_no like ? order by ht.consumername asc";
                   pstmt = con.prepareStatement(sql);
                    pstmt.setString(1, meterId + "%");
                   }
                       else{
                           sql="select m.meterid,m.meter_serial_no,ht.consumername from meter m,ht_consumer ht where m.htconsumerid in "
                                + "(select consumerid from ht_consumer where feederid in (select feederid from feeder where substationid in "
                                + "(select substationid from substation where  subdivid in "
                                + "(select subdivid from subdivision where divisionid in (select divisionid from division where townid in(select townid from town where circleid in(select circleid from circle where zoneid in (select zoneid from zone where discom_id in "
                                + "(select discom_id from discom where discom_id=?))))))))) and m.htconsumerid=ht.consumerid and m.meter_serial_no like ? order by ht.consumername asc";
                   pstmt = con.prepareStatement(sql);
                    pstmt.setInt(1, optVal);
                    pstmt.setString(2, meterId + "%");
                   }
                       }
                   if(meterLoc.toUpperCase().equals("FEEDER"))
                   {
                       if (office_type.equals("DO")) {
                       sql="select m.meterid,m.meter_serial_no,f.feedername from meter m,feeder f where m.feederid in "
                               + " (select feederid from feeder where substationid in (select substationid from substation where  subdivid in(select subdivid from subdivision where divisionid="+office_type_id+")))"
                               + " and m.feederid=f.feederid and m.meter_serial_no like ? order by f.feedername asc";
                   pstmt = con.prepareStatement(sql);
                    pstmt.setString(1, meterId + "%");
                   }
                     else  if (office_type.equals("SDO")) {
                       sql="select m.meterid,m.meter_serial_no,f.feedername from meter m,feeder f where m.feederid in "
                               + " (select feederid from feeder where substationid in (select substationid from substation where  subdivid="+office_type_id+"))"
                               + " and m.feederid=f.feederid and m.meter_serial_no like ? order by f.feedername asc";
                   pstmt = con.prepareStatement(sql);
                    pstmt.setString(1, meterId + "%");
                   }
                       else{
                           
                       sql="select m.meterid,m.meter_serial_no,f.feedername from meter m,feeder f where m.feederid in "
                               + " (select feederid from feeder where substationid in (select substationid from substation where subdivid in (select subdivid from subdivision where divisionid in (select divisionid from division where townid in(select townid from town where circleid in (select circleid from circle where zoneid in (select zoneid from zone where discom_id in (select discom_id from discom where discom_id=?)))))))) and m.feederid=f.feederid and m.meter_serial_no like ? order by f.feedername asc";
                   pstmt = con.prepareStatement(sql);
                    pstmt.setInt(1, optVal);
                    pstmt.setString(2, meterId + "%");
                   }
                       }
                 System.out.println("query--->"+sql);
                    
                    rs = pstmt.executeQuery();
                    while (rs.next()) {
                        data = data+rs.getString("meterid") + "_" + rs.getString("meter_serial_no") + "-" + counter+"-"+rs.getString(3)+":" ;
                         counter++;
                    }//end while
                   
                    if(meterLoc.toUpperCase().equals("FEEDER"))
                   {  data = "0_All-All Feeders:"+data;}
                    
                } 
                 else if (searchType == 8) {  //zone is selected
                    counter=1;
                   if(meterLoc.toUpperCase().equals("DTR"))
                   {
                       if (office_type.equals("DO")) {
                         sql = "select m.meterid,m.meter_serial_no,d.dtrname from meter m,dtr d where m.dtrid in"
                             + " ( select dtrid from dtr where feederid in ( select feederid from feeder where substationid in "
                             + "(select substationid from substation where subdivid in(select subdivid from subdivision where divisionid="+office_type_id+" )))) "
                             + "and m.dtrid=d.dtrid and m.meter_serial_no like ?  order by d.dtrname asc";
                         pstmt = con.prepareStatement(sql);
                         pstmt.setString(1, meterId + "%");
                       }
                      else if (office_type.equals("SDO")) {
                         sql = "select m.meterid,m.meter_serial_no,d.dtrname from meter m,dtr d where m.dtrid in"
                             + " ( select dtrid from dtr where feederid in ( select feederid from feeder where substationid in "
                             + "(select substationid from substation where subdivid="+office_type_id+" ))) "
                             + "and m.dtrid=d.dtrid and m.meter_serial_no like ?  order by d.dtrname asc";
                         pstmt = con.prepareStatement(sql);
                         pstmt.setString(1, meterId + "%");
                       }
                       else{
                           sql = "select m.meterid,m.meter_serial_no,d.dtrname from meter m,dtr d where m.dtrid in"
                             + " ( select dtrid from dtr where feederid in ( select feederid from feeder where substationid in "
                             + "(select substationid from substation where  subdivid in "
                             + "(select subdivid from subdivision where divisionid in ( select divisionid from division where townid in(select townid from town where circleid in(select circleid from circle where zoneid in"
                             + " ( select zoneid from zone where zoneid=?)))))))) "
                             + "and m.dtrid=d.dtrid and m.meter_serial_no like ?  order by d.dtrname asc";
                           pstmt = con.prepareStatement(sql);
                    pstmt.setInt(1, optVal);
                    pstmt.setString(2, meterId + "%");
                    }
                   }
                    if(meterLoc.toUpperCase().equals("HT"))
                   {
                       if (office_type.equals("DO")) {
                        sql="select m.meterid,m.meter_serial_no,ht.consumername from meter m,ht_consumer ht where m.htconsumerid in "
                                + "(select consumerid from ht_consumer where feederid in (select feederid from feeder where substationid in "
                                + "(select substationid from substation where  subdivid in(select subdivid from subdivision where divisionid="+office_type_id+")))) and m.htconsumerid=ht.consumerid and m.meter_serial_no like ? order by ht.consumername asc";
                   pstmt = con.prepareStatement(sql);
                    pstmt.setString(1, meterId + "%");
                   }
                   else if (office_type.equals("SDO")) {
                        sql="select m.meterid,m.meter_serial_no,ht.consumername from meter m,ht_consumer ht where m.htconsumerid in "
                                + "(select consumerid from ht_consumer where feederid in (select feederid from feeder where substationid in "
                                + "(select substationid from substation where  subdivid="+office_type_id+"))) and m.htconsumerid=ht.consumerid and m.meter_serial_no like ? order by ht.consumername asc";
                   pstmt = con.prepareStatement(sql);
                    pstmt.setString(1, meterId + "%");
                   }
                       else{
                           sql="select m.meterid,m.meter_serial_no,ht.consumername from meter m,ht_consumer ht where m.htconsumerid in "
                                + "(select consumerid from ht_consumer where feederid in (select feederid from feeder where substationid in "
                                + "(select substationid from substation where  subdivid in "
                                + "(select subdivid from subdivision where divisionid in (select divisionid from division where townid in(select townid from town where circleid in(select circleid from circle where zoneid in "
                                + "(select zoneid from zone where zoneid=?)))))))) and m.htconsumerid=ht.consumerid and m.meter_serial_no like ? order by ht.consumername asc";
                   pstmt = con.prepareStatement(sql);
                    pstmt.setInt(1, optVal);
                    pstmt.setString(2, meterId + "%");
                   }
                       }
                   if(meterLoc.toUpperCase().equals("FEEDER"))
                   {
                       if (office_type.equals("DO")) {
                       sql="select m.meterid,m.meter_serial_no,f.feedername from meter m,feeder f where m.feederid in "
                               + " (select feederid from feeder where substationid in (select substationid from substation where  subdivid in(select subdivid from subdivision where divisionid="+office_type_id+")))"
                               + " and m.feederid=f.feederid and m.meter_serial_no like ? order by f.feedername asc";
                   pstmt = con.prepareStatement(sql);
                    pstmt.setString(1, meterId + "%");
                   }
                    else if (office_type.equals("SDO")) {
                       sql="select m.meterid,m.meter_serial_no,f.feedername from meter m,feeder f where m.feederid in "
                               + " (select feederid from feeder where substationid in (select substationid from substation where  subdivid="+office_type_id+"))"
                               + " and m.feederid=f.feederid and m.meter_serial_no like ? order by f.feedername asc";
                   pstmt = con.prepareStatement(sql);
                    pstmt.setString(1, meterId + "%");
                   }
                       else{
                           
                       sql="select m.meterid,m.meter_serial_no,f.feedername from meter m,feeder f where m.feederid in "
                               + " (select feederid from feeder where substationid in (select substationid from substation where subdivid in (select subdivid from subdivision where divisionid in "
                               + "(select divisionid from division where townid in(select townid from town where circleid in (select circleid from circle where zoneid in "
                               + "(select zoneid from zone where zoneid=?))))))) and m.feederid=f.feederid and m.meter_serial_no like ? order by f.feedername asc";
                   pstmt = con.prepareStatement(sql);
                    pstmt.setInt(1, optVal);
                    pstmt.setString(2, meterId + "%");
                   }
                       }
                 //System.out.println("query***************>"+sql);
                    
                    rs = pstmt.executeQuery();
                    while (rs.next()) {
                        data = data+rs.getString("meterid") + "_" + rs.getString("meter_serial_no") + "-" + counter+"-"+rs.getString(3)+":" ;
                         counter++;
                    }//end while
                   
                    if(meterLoc.toUpperCase().equals("FEEDER"))
                   {  data = "0_All-All Feeders:"+data;}
                    
                } 
                else if (searchType == 2) {   //circle is selected
                     counter=1;
                  if(meterLoc.toUpperCase().equals("DTR"))
                   { 
                      if (office_type.equals("DO")) {
                         sql = "select m.meterid,m.meter_serial_no,d.dtrname from meter m,dtr d where m.dtrid in"
                             + " ( select dtrid from dtr where feederid in ( select feederid from feeder where substationid in "
                             + "(select substationid from substation where subdivid in(select subdivid from subdivision where divisionid="+office_type_id+" )))) "
                             + "and m.dtrid=d.dtrid and m.meter_serial_no like ?  order by d.dtrname asc";
                         pstmt = con.prepareStatement(sql);
                         pstmt.setString(1, meterId + "%");
                       }
                      else if (office_type.equals("SDO")) {
                         sql = "select m.meterid,m.meter_serial_no,d.dtrname from meter m,dtr d where m.dtrid in"
                             + " ( select dtrid from dtr where feederid in ( select feederid from feeder where substationid in "
                             + "(select substationid from substation where subdivid="+office_type_id+" ))) "
                             + "and m.dtrid=d.dtrid and m.meter_serial_no like ?  order by d.dtrname asc";
                         pstmt = con.prepareStatement(sql);
                         pstmt.setString(1, meterId + "%");
                       }
                       else{
                    sql = "select m.meterid,m.meter_serial_no,d.dtrname from meter m,dtr d where m.dtrid in "
                            + "( select dtrid from dtr where feederid in (select feederid from feeder where substationid in "
                            + "(select substationid from substation where  subdivid in "
                            + "( select subdivid from subdivision where divisionid in (select divisionid from division where townid in (select townid from town where circleid=? )))))) and m.dtrid=d.dtrid and m.meter_serial_no like ? order by d.dtrname asc";
                    pstmt = con.prepareStatement(sql);
                    pstmt.setInt(1, optVal);
                    pstmt.setString(2, meterId + "%");
                    }
                                           }//dtr
                  if(meterLoc.toUpperCase().equals("HT"))
                   { 
                      if (office_type.equals("DO")) {
                        sql="select m.meterid,m.meter_serial_no,ht.consumername from meter m,ht_consumer ht where m.htconsumerid in "
                                + "(select consumerid from ht_consumer where feederid in (select feederid from feeder where substationid in "
                                + "(select substationid from substation where  subdivid in(select subdivid from subdivision where divisionid="+office_type_id+")))) and m.htconsumerid=ht.consumerid and m.meter_serial_no like ? order by ht.consumername asc";
                   pstmt = con.prepareStatement(sql);
                    pstmt.setString(1, meterId + "%");
                   }
                   else if (office_type.equals("SDO")) {
                        sql="select m.meterid,m.meter_serial_no,ht.consumername from meter m,ht_consumer ht where m.htconsumerid in "
                                + "(select consumerid from ht_consumer where feederid in (select feederid from feeder where substationid in "
                                + "(select substationid from substation where  subdivid="+office_type_id+"))) and m.htconsumerid=ht.consumerid and m.meter_serial_no like ? order by ht.consumername asc";
                   pstmt = con.prepareStatement(sql);
                    pstmt.setString(1, meterId + "%");
                   }
                       else{
                      sql="select m.meterid,m.meter_serial_no,ht.consumername from meter m,ht_consumer ht where m.htconsumerid in "
                          + "( select consumerid from ht_consumer where feederid in (select feederid from feeder where substationid in "
                          + "(select substationid from substation where subdivid in "
                          + "( select subdivid from subdivision where divisionid in (select divisionid from division where townid in(select townid from town where circleid=? )))))) and m.htconsumerid=ht.consumerid and m.meter_serial_no like ? order by ht.consumername asc";
                       pstmt = con.prepareStatement(sql);
                    pstmt.setInt(1, optVal);
                    pstmt.setString(2, meterId + "%");
                   } }
                  if(meterLoc.toUpperCase().equals("FEEDER"))
                   { 
                      if (office_type.equals("DO")) {
                       sql="select m.meterid,m.meter_serial_no,f.feedername from meter m,feeder f where m.feederid in "
                               + " (select feederid from feeder where substationid in (select substationid from substation where  subdivid in(select subdivid from subdivision where divisionid="+office_type_id+")))"
                               + " and m.feederid=f.feederid and m.meter_serial_no like ? order by f.feedername asc";
                   pstmt = con.prepareStatement(sql);
                    pstmt.setString(1, meterId + "%");
                   }
                    else if (office_type.equals("SDO")) {
                       sql="select m.meterid,m.meter_serial_no,f.feedername from meter m,feeder f where m.feederid in "
                               + " (select feederid from feeder where substationid in (select substationid from substation where  subdivid="+office_type_id+"))"
                               + " and m.feederid=f.feederid and m.meter_serial_no like ? order by f.feedername asc";
                   pstmt = con.prepareStatement(sql);
                    pstmt.setString(1, meterId + "%");
                   }
                       else{
                      sql="select m.meterid,m.meter_serial_no,f.feedername from meter m,feeder f where m.feederid in "
                           + "(select feederid from feeder where substationid in (select substationid from substation  where subdivid in ( select subdivid from subdivision where divisionid in (select divisionid from division where townid in(select townid from town where circleid=?)))))"
                           + "and m.feederid=f.feederid and m.meter_serial_no like ? order by f.feedername asc";
                      pstmt = con.prepareStatement(sql);
                    pstmt.setInt(1, optVal);
                    pstmt.setString(2, meterId + "%");
                   }
                                           }
//System.out.println("===="+sql);
                    
                    rs = pstmt.executeQuery();
                    while (rs.next()) {
                       data = data+rs.getString("meterid") + "_" + rs.getString("meter_serial_no") + "-" + counter+"-"+rs.getString(3)+":" ;
                         counter++;
                    }//end while
                    if(meterLoc.toUpperCase().equals("FEEDER"))
                   {  data = "0_All-All Feeders:"+data;}
                }//circle else if
             else if (searchType == 3) {   //town is selected
                     counter=1;
                  if(meterLoc.toUpperCase().equals("DTR"))
                   { 
                      if (office_type.equals("DO")) {
                         sql = "select m.meterid,m.meter_serial_no,d.dtrname from meter m,dtr d where m.dtrid in"
                             + " ( select dtrid from dtr where feederid in ( select feederid from feeder where substationid in "
                             + "(select substationid from substation where subdivid in(select subdivid from subdivision where divisionid="+office_type_id+" )))) "
                             + "and m.dtrid=d.dtrid and m.meter_serial_no like ?  order by d.dtrname asc";
                         pstmt = con.prepareStatement(sql);
                         pstmt.setString(1, meterId + "%");
                       }
                      else if (office_type.equals("SDO")) {
                         sql = "select m.meterid,m.meter_serial_no,d.dtrname from meter m,dtr d where m.dtrid in"
                             + " ( select dtrid from dtr where feederid in ( select feederid from feeder where substationid in "
                             + "(select substationid from substation where subdivid="+office_type_id+" ))) "
                             + "and m.dtrid=d.dtrid and m.meter_serial_no like ?  order by d.dtrname asc";
                         pstmt = con.prepareStatement(sql);
                         pstmt.setString(1, meterId + "%");
                       }
                       else{
                    sql = "select m.meterid,m.meter_serial_no,d.dtrname from meter m,dtr d where m.dtrid in "
                            + "( select dtrid from dtr where feederid in (select feederid from feeder where substationid in "
                            + "(select substationid from substation where  subdivid in "
                            + "( select subdivid from subdivision where divisionid in (select divisionid from division where townid=? ))))) and m.dtrid=d.dtrid and m.meter_serial_no like ? order by d.dtrname asc";
                    pstmt = con.prepareStatement(sql);
                    pstmt.setInt(1, optVal);
                    pstmt.setString(2, meterId + "%");
                    }
                                           }
                  if(meterLoc.toUpperCase().equals("HT"))
                   { 
                       if (office_type.equals("DO")) {
                        sql="select m.meterid,m.meter_serial_no,ht.consumername from meter m,ht_consumer ht where m.htconsumerid in "
                                + "(select consumerid from ht_consumer where feederid in (select feederid from feeder where substationid in "
                                + "(select substationid from substation where  subdivid in(select subdivid from subdivision where divisionid="+office_type_id+")))) and m.htconsumerid=ht.consumerid and m.meter_serial_no like ? order by ht.consumername asc";
                   pstmt = con.prepareStatement(sql);
                    pstmt.setString(1, meterId + "%");
                   }
                   else if (office_type.equals("SDO")) {
                        sql="select m.meterid,m.meter_serial_no,ht.consumername from meter m,ht_consumer ht where m.htconsumerid in "
                                + "(select consumerid from ht_consumer where feederid in (select feederid from feeder where substationid in "
                                + "(select substationid from substation where  subdivid="+office_type_id+"))) and m.htconsumerid=ht.consumerid and m.meter_serial_no like ? order by ht.consumername asc";
                   pstmt = con.prepareStatement(sql);
                    pstmt.setString(1, meterId + "%");
                   }
                       else{
                      sql="select m.meterid,m.meter_serial_no,ht.consumername from meter m,ht_consumer ht where m.htconsumerid in "
                          + "( select consumerid from ht_consumer where feederid in (select feederid from feeder where substationid in "
                          + "(select substationid from substation where subdivid in "
                          + "( select subdivid from subdivision where divisionid in (select divisionid from division where townid=? ))))) and m.htconsumerid=ht.consumerid and m.meter_serial_no like ? order by ht.consumername asc";
                      pstmt = con.prepareStatement(sql);
                    pstmt.setInt(1, optVal);
                    pstmt.setString(2, meterId + "%");
                   }
                                             }
                  if(meterLoc.toUpperCase().equals("FEEDER"))
                   { 
                      if (office_type.equals("DO")) {
                       sql="select m.meterid,m.meter_serial_no,f.feedername from meter m,feeder f where m.feederid in "
                               + " (select feederid from feeder where substationid in (select substationid from substation where  subdivid in(select subdivid from subdivision where divisionid="+office_type_id+")))"
                               + " and m.feederid=f.feederid and m.meter_serial_no like ? order by f.feedername asc";
                   pstmt = con.prepareStatement(sql);
                    pstmt.setString(1, meterId + "%");
                   }
                    else if (office_type.equals("SDO")) {
                       sql="select m.meterid,m.meter_serial_no,f.feedername from meter m,feeder f where m.feederid in "
                               + " (select feederid from feeder where substationid in (select substationid from substation where  subdivid="+office_type_id+"))"
                               + " and m.feederid=f.feederid and m.meter_serial_no like ? order by f.feedername asc";
                   pstmt = con.prepareStatement(sql);
                    pstmt.setString(1, meterId + "%");
                   }
                       else{
                       sql="select m.meterid,m.meter_serial_no,f.feedername from meter m,feeder f where m.feederid in "
                           + "(select feederid from feeder where substationid in (select substationid from substation  where subdivid in ( select subdivid from subdivision where divisionid in (select divisionid from division where townid=?))))"
                           + "and m.feederid=f.feederid and m.meter_serial_no like ? order by f.feedername asc";
                       pstmt = con.prepareStatement(sql);
                    pstmt.setInt(1, optVal);
                    pstmt.setString(2, meterId + "%");
                   }}

                    
                    rs = pstmt.executeQuery();
                    while (rs.next()) {
                       data = data+rs.getString("meterid") + "_" + rs.getString("meter_serial_no") + "-" + counter+"-"+rs.getString(3)+":" ;
                         counter++;
                    }//end while
                    if(meterLoc.toUpperCase().equals("FEEDER"))
                   {  data = "0_All-All Feeders:"+data;}
                }//town else if
                else if (searchType == 4) {   //division is selected
                     counter=1;
                  if(meterLoc.toUpperCase().equals("DTR"))
                   { 
                     if (office_type.equals("DO")) {
                         sql = "select m.meterid,m.meter_serial_no,d.dtrname from meter m,dtr d where m.dtrid in"
                             + " ( select dtrid from dtr where feederid in ( select feederid from feeder where substationid in "
                             + "(select substationid from substation where subdivid in(select subdivid from subdivision where divisionid="+office_type_id+" )))) "
                             + "and m.dtrid=d.dtrid and m.meter_serial_no like ?  order by d.dtrname asc";
                         pstmt = con.prepareStatement(sql);
                         pstmt.setString(1, meterId + "%");
                       }
                      else if (office_type.equals("SDO")) {
                         sql = "select m.meterid,m.meter_serial_no,d.dtrname from meter m,dtr d where m.dtrid in"
                             + " ( select dtrid from dtr where feederid in ( select feederid from feeder where substationid in "
                             + "(select substationid from substation where subdivid="+office_type_id+" ))) "
                             + "and m.dtrid=d.dtrid and m.meter_serial_no like ?  order by d.dtrname asc";
                         pstmt = con.prepareStatement(sql);
                         pstmt.setString(1, meterId + "%");
                       }
                       else{ 
                    sql = "select m.meterid,m.meter_serial_no,d.dtrname from meter m,dtr d where m.dtrid in "
                            + "( select dtrid from dtr where feederid in (select feederid from feeder where substationid in "
                            + "(select substationid from substation where  subdivid in "
                            + "( select subdivid from subdivision where divisionid=? )))) and m.dtrid=d.dtrid and m.meter_serial_no like ? order by d.dtrname asc";
                    pstmt = con.prepareStatement(sql);
                    pstmt.setInt(1, optVal);
                    pstmt.setString(2, meterId + "%");
                    }
                                         }
                  if(meterLoc.toUpperCase().equals("HT"))
                   { 
                       if (office_type.equals("DO")) {
                        sql="select m.meterid,m.meter_serial_no,ht.consumername from meter m,ht_consumer ht where m.htconsumerid in "
                                + "(select consumerid from ht_consumer where feederid in (select feederid from feeder where substationid in "
                                + "(select substationid from substation where  subdivid in(select subdivid from subdivision where divisionid="+office_type_id+")))) and m.htconsumerid=ht.consumerid and m.meter_serial_no like ? order by ht.consumername asc";
                   pstmt = con.prepareStatement(sql);
                    pstmt.setString(1, meterId + "%");
                   }
                   else if (office_type.equals("SDO")) {
                        sql="select m.meterid,m.meter_serial_no,ht.consumername from meter m,ht_consumer ht where m.htconsumerid in "
                                + "(select consumerid from ht_consumer where feederid in (select feederid from feeder where substationid in "
                                + "(select substationid from substation where  subdivid="+office_type_id+"))) and m.htconsumerid=ht.consumerid and m.meter_serial_no like ? order by ht.consumername asc";
                   pstmt = con.prepareStatement(sql);
                    pstmt.setString(1, meterId + "%");
                   }
                       else{
                       sql="select m.meterid,m.meter_serial_no,ht.consumername from meter m,ht_consumer ht where m.htconsumerid in "
                          + "( select consumerid from ht_consumer where feederid in (select feederid from feeder where substationid in "
                          + "(select substationid from substation where subdivid in "
                          + "( select subdivid from subdivision where divisionid=? )))) and m.htconsumerid=ht.consumerid and m.meter_serial_no like ? order by ht.consumername asc";
                        pstmt = con.prepareStatement(sql);
                    pstmt.setInt(1, optVal);
                    pstmt.setString(2, meterId + "%");
                   }
                                             }
                  if(meterLoc.toUpperCase().equals("FEEDER"))
                   { 
                      if (office_type.equals("DO")) {
                       sql="select m.meterid,m.meter_serial_no,f.feedername from meter m,feeder f where m.feederid in "
                               + " (select feederid from feeder where substationid in (select substationid from substation where  subdivid in(select subdivid from subdivision where divisionid="+office_type_id+")))"
                               + " and m.feederid=f.feederid and m.meter_serial_no like ? order by f.feedername asc";
                   pstmt = con.prepareStatement(sql);
                    pstmt.setString(1, meterId + "%");
                   }
                    else if (office_type.equals("SDO")) {
                       sql="select m.meterid,m.meter_serial_no,f.feedername from meter m,feeder f where m.feederid in "
                               + " (select feederid from feeder where substationid in (select substationid from substation where  subdivid="+office_type_id+"))"
                               + " and m.feederid=f.feederid and m.meter_serial_no like ? order by f.feedername asc";
                   pstmt = con.prepareStatement(sql);
                    pstmt.setString(1, meterId + "%");
                   }
                       else{
                     sql="select m.meterid,m.meter_serial_no,f.feedername from meter m,feeder f where m.feederid in "
                           + "(select feederid from feeder where substationid in (select substationid from substation  where subdivid in ( select subdivid from subdivision where divisionid=?))) and m.feederid=f.feederid and m.meter_serial_no like ? order by f.feedername asc";
                     pstmt = con.prepareStatement(sql);
                    pstmt.setInt(1, optVal);
                    pstmt.setString(2, meterId + "%");
                   }}

                    
                    rs = pstmt.executeQuery();
                    while (rs.next()) {
                      data = data+rs.getString("meterid") + "_" + rs.getString("meter_serial_no") + "-" + counter+"-"+rs.getString(3)+":" ;
                         counter++;
                    }//end while
                    if(meterLoc.toUpperCase().equals("FEEDER"))
                   {  data = "0_All-All Feeders:"+data;}
                }//division else if
                else if (searchType == 5) {   //subdiv is selected
                     counter=1;
                  if(meterLoc.toUpperCase().equals("DTR"))
                   { 
                    sql = "select m.meterid,m.meter_serial_no,d.dtrname from meter m,dtr d where m.dtrid in "
                            + "( select dtrid from dtr where feederid in (select feederid from feeder where substationid in "
                            + "(select substationid from substation where  subdivid=? ))) and m.dtrid=d.dtrid and m.meter_serial_no like ? order by d.dtrname asc";
                    }
                  if(meterLoc.toUpperCase().equals("HT"))
                   { 
                      sql="select m.meterid,m.meter_serial_no,ht.consumername from meter m,ht_consumer ht where m.htconsumerid in "
                          + "( select consumerid from ht_consumer where feederid in (select feederid from feeder where substationid in "
                          + "(select substationid from substation where subdivid=? ))) and m.htconsumerid=ht.consumerid and m.meter_serial_no like ? order by ht.consumername asc";
                   }
                  if(meterLoc.toUpperCase().equals("FEEDER"))
                   { 
                      sql="select m.meterid,m.meter_serial_no,f.feedername from meter m,feeder f where m.feederid in "
                           + "(select feederid from feeder where substationid in (select substationid from substation  where subdivid=?)) and m.feederid=f.feederid and m.meter_serial_no like ? order by f.feedername asc";
                   }

                    pstmt = con.prepareStatement(sql);
                    pstmt.setInt(1, optVal);
                    pstmt.setString(2, meterId + "%");
                    rs = pstmt.executeQuery();
                    while (rs.next()) {
                      data = data+rs.getString("meterid") + "_" + rs.getString("meter_serial_no") + "-" + counter+"-"+rs.getString(3)+":" ;
                         counter++;
                    }//end while
                    if(meterLoc.toUpperCase().equals("FEEDER"))
                   {  data = "0_All-All Feeders:"+data;}
                }//subdiv else if
               
                else if (searchType == 6) {   //substation is selected
                     counter=1;
                     if(meterLoc.toUpperCase().equals("FEEDER"))
                   { 
                      sql="select m.meterid,m.meter_serial_no,f.feedername from meter m,feeder f where m.feederid in "
                           + "(select feederid from feeder where substationid=?) and m.feederid=f.feederid and m.meter_serial_no like ? order by f.feedername asc";
                   }
                  if(meterLoc.toUpperCase().equals("DTR"))
                   { 
                    sql = "select m.meterid,m.meter_serial_no,d.dtrname from meter m,dtr d where m.dtrid in "
                            + "( select dtrid from dtr where feederid in (select feederid from feeder where substationid=? )) and m.dtrid=d.dtrid and m.meter_serial_no like ? order by d.dtrname asc";
                    }
                  if(meterLoc.toUpperCase().equals("HT"))
                   { 
                      sql="select m.meterid,m.meter_serial_no,ht.consumername from meter m,ht_consumer ht where m.htconsumerid in "
                          + "( select consumerid from ht_consumer where feederid in (select feederid from feeder where substationid=? )) and m.htconsumerid=ht.consumerid and m.meter_serial_no like ? order by ht.consumername asc";
                   }
                    pstmt = con.prepareStatement(sql);
                    pstmt.setInt(1, optVal);
                    pstmt.setString(2, meterId + "%");
                    rs = pstmt.executeQuery();
                    while (rs.next()) {
                       data = data+rs.getString("meterid") + "_" + rs.getString("meter_serial_no") + "-" + counter+"-"+rs.getString(3)+":" ;
                         counter++;
                    }//end while
                   
                }//substation else if
                if(data.length()!=0)
                    out.print(data);
                else
                  out.print("0_0-No Meters Available:");

                 //out.print(data);
                //System.out.println("searched data--->"+data.length());
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                con.close();
            }
%>