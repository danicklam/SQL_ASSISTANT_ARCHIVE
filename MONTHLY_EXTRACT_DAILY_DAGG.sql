sel COALESCE (L.week_of_year, LL.week_of_year, P.week_of_year, T.week_of_year ) as WEEK_OF_YR, 
 COALESCE (L.route_name, LL.route_name, P.route_name, T.route_name ) as route_name, 
 COALESCE (L.route_id, LL.route_id, P.route_id, T.route_id )as route_id, 
  COALESCE (L.location_name_rln, LL.location_name_rln, P.location_name_rln, T.location_name_rln )as location_name_rln, 
 COALESCE (L.delivery_point_ref_num, LL.delivery_point_ref_num, P.delivery_point_ref_num, T.delivery_point_ref_num )as delivery_point_ref_num,  
 LL.LARGE_LETTERS,  L.LETTERS, P.PARCELS, T.TRACKED
 FROM
 (sel ---top 10 *
 cal.week_of_year, min (cal.calendar_date) as WC, max (cal.calendar_date) as WE,
 dagg.route_name, dagg.route_id, delivery_point_ref_num ,
 dagg.location_name_rln,
 sum(Volume) AS LARGE_LETTERS
 from EDW_SCVER_CODA_ACCS_VIEWS.v_DP_DAILY_AGG dagg
 inner join SYS_CALENDAR.Calendar cal on dagg.delivery_date = cal.calendar_date
 and dagg.source_system = 'MEARS-ADF'
 and dagg.postal_piece_type_desc = 'LARGE LETTER'
 and dagg.location_name_rln IN ('Ballymoney DO','Bodmin DO','Bromsgrove DO','Cardiff North DO','Glasgow G1 and G4 DO','Hampton DO','Kings Norton DO','Warwick DO' )

 Group by 1, 4, 5, 6, 7) LL

 FULL JOIN
 
 (sel ---top 10 *
 cal.week_of_year, min (cal.calendar_date) as WC, max (cal.calendar_date) as WE,
 dagg.route_name, dagg.route_id, delivery_point_ref_num , 
  dagg.location_name_rln,
 sum(Volume) AS LETTERS
 from EDW_SCVER_CODA_ACCS_VIEWS.v_DP_DAILY_AGG dagg
 inner join SYS_CALENDAR.Calendar cal on dagg.delivery_date = cal.calendar_date
 and dagg.source_system = 'MEARS-ADF'
 and dagg.postal_piece_type_desc = 'LETTER'
 and dagg.location_name_rln IN ('Ballymoney DO','Bodmin DO','Bromsgrove DO','Cardiff North DO','Glasgow G1 and G4 DO','Hampton DO','Kings Norton DO','Warwick DO' )
 Group by 1, 4, 5, 6, 7) L
 
 ON  L.week_of_year              = LL.week_of_year
 AND L.route_name                = LL.route_name
 AND L.route_id                  = LL.route_id  
 AND L.delivery_point_ref_num    = LL.delivery_point_ref_num
  AND L.delivery_point_ref_num    = LL.delivery_point_ref_num
 
 FULL JOIN
 
 (sel ---top 10 *
 cal.week_of_year, min (cal.calendar_date) as WC, max (cal.calendar_date) as WE,
 dagg.route_name, dagg.route_id, delivery_point_ref_num ,
  dagg.location_name_rln,
 sum(Volume) AS PARCELS
 from EDW_SCVER_CODA_ACCS_VIEWS.v_DP_DAILY_AGG dagg
 inner join SYS_CALENDAR.Calendar cal on dagg.delivery_date = cal.calendar_date
 and dagg.source_system = 'PARCELS'
 and dagg.location_name_rln IN ('Ballymoney DO','Bodmin DO','Bromsgrove DO','Cardiff North DO','Glasgow G1 and G4 DO','Hampton DO','Kings Norton DO','Warwick DO' )
 Group by 1, 4, 5, 6, 7 ) P
 
 ON  L.week_of_year              = P.week_of_year
 AND L.route_name                = P.route_name
 AND L.route_id                  = P.route_id  
 AND L.delivery_point_ref_num    = P.delivery_point_ref_num
  AND L.delivery_point_ref_num    = P.delivery_point_ref_num
 
 FULL JOIN 
 (sel ---top 10 *
 cal.week_of_year, min (cal.calendar_date) as WC, max (cal.calendar_date) as WE,
 dagg.route_name, dagg.route_id, delivery_point_ref_num ,
  dagg.location_name_rln,
 sum(Volume) AS TRACKED
 from EDW_SCVER_CODA_ACCS_VIEWS.v_DP_DAILY_AGG dagg
 inner join SYS_CALENDAR.Calendar cal on dagg.delivery_date = cal.calendar_date
 and dagg.source_system IN ('TODS', 'RMGTT')
 and dagg.location_name_rln IN ('Ballymoney DO','Bodmin DO','Bromsgrove DO','Cardiff North DO','Glasgow G1 and G4 DO','Hampton DO','Kings Norton DO','Warwick DO' )
 Group by 1, 4, 5, 6, 7 ) T
 
 ON  L.week_of_year              = T.week_of_year
 AND L.route_name                = T.route_name
 AND L.route_id                  = T.route_id  
 AND L.delivery_point_ref_num    = T.delivery_point_ref_num
  AND L.delivery_point_ref_num    = T.delivery_point_ref_num
 
 ;