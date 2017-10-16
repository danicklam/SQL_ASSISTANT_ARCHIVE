/*TRACKED*/

sel 
 cal.week_of_year, min (cal.calendar_date) as WC, max (cal.calendar_date) as WE,
 dagg.route_name, dagg.route_id, 
 count(distinct delivery_point_ref_num) as NO_OF_DP, sum(Volume) AS VOLUME
  , dagg.location_name_rln
 from
 EDW_SCVER_CODA_ACCS_VIEWS.v_DP_DAILY_AGG dagg
 inner join
 SYS_CALENDAR.Calendar cal
 on dagg.delivery_date = cal.calendar_date
 and dagg.source_system IN ('TODS', 'RMGTT')
 and dagg.location_name_rln 
IN ('Ballymoney DO','Bodmin DO','Bromsgrove DO','Cardiff North DO','Glasgow G1 and G4 DO','Hampton DO','Kings Norton DO','Warwick DO' )
  Group by 1, 4, 5, 8
 ;
 
 /*TODS*/
 
 sel 
 cal.week_of_year, min (cal.calendar_date) as WC, max (cal.calendar_date) as WE,
 dagg.route_name, dagg.route_id, 
 count(distinct delivery_point_ref_num) as NO_OF_DP, sum(Volume) AS TODS_TOTAL
  , dagg.location_name_rln
 from
 EDW_SCVER_CODA_ACCS_VIEWS.v_DP_DAILY_AGG dagg
 inner join
 SYS_CALENDAR.Calendar cal
 on dagg.delivery_date = cal.calendar_date
 and dagg.source_system = 'TODS'
 and dagg.location_name_rln 
IN ('Ballymoney DO','Bodmin DO','Bromsgrove DO','Cardiff North DO','Glasgow G1 and G4 DO','Hampton DO','Kings Norton DO','Warwick DO' )
  Group by 1, 4, 5, 8
 ;
 
 /*RMGTT_TYPE*/
 
 sel 
 cal.week_of_year, min (cal.calendar_date) as WC, max (cal.calendar_date) as WE,
 dagg.route_name, dagg.route_id, 
 count(distinct delivery_point_ref_num) as NO_OF_DP, dagg.postal_piece_type_desc,
 sum(Volume) AS RMGTT_VOLUME
  , dagg.location_name_rln
 from
 EDW_SCVER_CODA_ACCS_VIEWS.v_DP_DAILY_AGG dagg
 inner join
 SYS_CALENDAR.Calendar cal
 on dagg.delivery_date = cal.calendar_date
 and dagg.source_system = 'RMGTT'
 and dagg.location_name_rln 
IN ('Ballymoney DO','Bodmin DO','Bromsgrove DO','Cardiff North DO','Glasgow G1 and G4 DO','Hampton DO','Kings Norton DO','Warwick DO' )
  Group by 1, 4, 5, 7, 9
 ;
 
 /*RMGTT TOTAL*/
 
 sel ---top 10 *
 cal.week_of_year, min (cal.calendar_date) as WC, max (cal.calendar_date) as WE,
 dagg.route_name, dagg.route_id, 
 count(distinct delivery_point_ref_num) as NO_OF_DP, sum(Volume) AS RMGTT_TOTAL
  , dagg.location_name_rln
 from
 EDW_SCVER_CODA_ACCS_VIEWS.v_DP_DAILY_AGG dagg
 inner join
 SYS_CALENDAR.Calendar cal
 on dagg.delivery_date = cal.calendar_date
 and dagg.source_system = 'RMGTT'
 and dagg.location_name_rln 
IN ('Ballymoney DO','Bodmin DO','Bromsgrove DO','Cardiff North DO','Glasgow G1 and G4 DO','Hampton DO','Kings Norton DO','Warwick DO' )
  Group by 1, 4, 5, 8
 ;
 
 /*PARCELS TYPE*/
 
 sel ---top 10 *
 cal.week_of_year, min (cal.calendar_date) as WC, max (cal.calendar_date) as WE,
 dagg.route_name, dagg.route_id, 
 count(distinct delivery_point_ref_num) as NO_OF_DP, dagg.postal_piece_type_desc,
 sum(Volume) AS PARCELS_VOLUME
  , dagg.location_name_rln
 from
 EDW_SCVER_CODA_ACCS_VIEWS.v_DP_DAILY_AGG dagg
 inner join
 SYS_CALENDAR.Calendar cal
 on dagg.delivery_date = cal.calendar_date
 and dagg.source_system = 'PARCELS'
 and dagg.location_name_rln 
IN ('Ballymoney DO','Bodmin DO','Bromsgrove DO','Cardiff North DO','Glasgow G1 and G4 DO','Hampton DO','Kings Norton DO','Warwick DO' )
  Group by 1, 4, 5, 7, 9
 ;
 
 
  /*PARCELS TOTAL*/
  
 sel ---top 10 *
 cal.week_of_year, min (cal.calendar_date) as WC, max (cal.calendar_date) as WE,
 dagg.route_name, dagg.route_id, 
 count(distinct delivery_point_ref_num) as NO_OF_DP, sum(Volume) AS PARCELS_TOTAL
  , dagg.location_name_rln
 from
 EDW_SCVER_CODA_ACCS_VIEWS.v_DP_DAILY_AGG dagg
 inner join
 SYS_CALENDAR.Calendar cal
 on dagg.delivery_date = cal.calendar_date
 and dagg.source_system = 'PARCELS'
 and dagg.location_name_rln 
IN ('Ballymoney DO','Bodmin DO','Bromsgrove DO','Cardiff North DO','Glasgow G1 and G4 DO','Hampton DO','Kings Norton DO','Warwick DO' )
  Group by 1, 4, 5, 8
 ;
 
 /*MEARS LETTER*/
 
 sel ---top 10 *
 cal.week_of_year, min (cal.calendar_date) as WC, max (cal.calendar_date) as WE,
 dagg.route_name, dagg.route_id, 
 count(distinct delivery_point_ref_num) as NO_OF_DP, sum(Volume) AS MEARS_LETTERS
  , dagg.location_name_rln
 from
 EDW_SCVER_CODA_ACCS_VIEWS.v_DP_DAILY_AGG dagg
 inner join
 SYS_CALENDAR.Calendar cal
 on dagg.delivery_date = cal.calendar_date
 and dagg.source_system = 'MEARS-ADF'
 and dagg.postal_piece_type_desc = 'LETTER'
 and dagg.location_name_rln 
IN ('Ballymoney DO','Bodmin DO','Bromsgrove DO','Cardiff North DO','Glasgow G1 and G4 DO','Hampton DO','Kings Norton DO','Warwick DO' )
  Group by 1, 4, 5, 8
 ;
 
 /*MEARS LL*/
 sel ---top 10 *
 cal.week_of_year, min (cal.calendar_date) as WC, max (cal.calendar_date) as WE,
 dagg.route_name, dagg.route_id, 
 count(distinct delivery_point_ref_num) as NO_OF_DP, sum(Volume) AS MEARS_LARGE_LETTERS
 , dagg.location_name_rln
 from
 EDW_SCVER_CODA_ACCS_VIEWS.v_DP_DAILY_AGG dagg
 inner join
 SYS_CALENDAR.Calendar cal
 on dagg.delivery_date = cal.calendar_date
 and dagg.source_system = 'MEARS-ADF'
 and dagg.postal_piece_type_desc = 'LARGE LETTER'
 and dagg.location_name_rln 
 IN ('Ballymoney DO','Bodmin DO','Bromsgrove DO','Cardiff North DO','Glasgow G1 and G4 DO','Hampton DO','Kings Norton DO','Warwick DO' )
  Group by 1, 4, 5, 8
 ;
 
 /*MEARS TOTAL*/
 
 sel ---top 10 *
 cal.week_of_year, min (cal.calendar_date) as WC, max (cal.calendar_date) as WE,
 dagg.route_name, dagg.route_id, 
 count(distinct delivery_point_ref_num) as NO_OF_DP, sum(Volume) AS MEARS_TOTAL,
  dagg.location_name_rln
 from
 EDW_SCVER_CODA_ACCS_VIEWS.v_DP_DAILY_AGG dagg
 inner join
 SYS_CALENDAR.Calendar cal
 on dagg.delivery_date = cal.calendar_date
 and dagg.source_system = 'MEARS-ADF'
 and dagg.location_name_rln 
 IN ('Ballymoney DO','Bodmin DO','Bromsgrove DO','Cardiff North DO','Glasgow G1 and G4 DO','Hampton DO','Kings Norton DO','Warwick DO' )
  Group by 1, 4, 5, 8
 ;
 
 /*SOURCE TOTALS*/
 
 sel ---top 10 *
 cal.week_of_year, min (cal.calendar_date) as WC, max (cal.calendar_date) as WE,
 dagg.source_system, 
 dagg.route_name, dagg.route_id, 
 count(distinct delivery_point_ref_num) as NO_OF_DP, 
 sum(Volume) as VOLUME,
 dagg.location_name_rln
 from
 EDW_SCVER_CODA_ACCS_VIEWS.v_DP_DAILY_AGG dagg
 inner join
 SYS_CALENDAR.Calendar cal
 on dagg.delivery_date = cal.calendar_date
 and dagg.source_system <> 'MEARS-ADF'
 and dagg.location_name_rln 
IN ('Ballymoney DO','Bodmin DO','Bromsgrove DO','Cardiff North DO','Glasgow G1 and G4 DO','Hampton DO','Kings Norton DO','Warwick DO' )
  Group by 1, 4, 5, 6, 9
 ;