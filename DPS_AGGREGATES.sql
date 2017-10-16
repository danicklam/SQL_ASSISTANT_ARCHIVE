 /*
 sel 
 --top 10 * 
 cal.week_of_year, 
 dagg.delivery_date,
 dagg.Location_name_rln,
dagg.route_name, dagg.route_id,   
dagg.postal_piece_type_desc, 
count (distinct dagg.delivery_point_ref_num),
 sum (volume)
 from
 EDW_SCVER_CODA_ACCS_VIEWS.v_DP_DAILY_AGG dagg
 
 inner join
 SYS_CALENDAR.Calendar cal
 on dagg.delivery_date = cal.calendar_date
 and dagg.source_system = 'MEARS-ADF'
 and dagg.location_name_rln = 'Northwood DO'
group by 1,2,3,4,5,6
 ;
 
 sel  dagg.location_name_rln , count (*) from
 EDW_SCVER_CODA_ACCS_VIEWS.v_DP_DAILY_AGG dagg
 inner join
 SYS_CALENDAR.Calendar cal
 on dagg.delivery_date = cal.calendar_date
 and dagg.source_system = 'MEARS-ADF'
 and dagg.location_name_rln 
 IN (
 'Northwood DO', 	
 'Ripley DE DO', --- DE same?
 'Plympton DO',
 'Valley DO')   --- can't find
 group by 1
 ;
 
 */
 
 
--------------------
 
 /* TOTAL SOURCE */
 
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
= 'Uxbridge DO'
  Group by 1, 4, 5, 6, 9
 ;
 
 /* MEARS_TOTAL */
 
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
= 'Uxbridge DO'
  Group by 1, 4, 5, 8
 ;
 
 
 /* MEARS_LL */
 
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
= 'Uxbridge DO'
  Group by 1, 4, 5, 8
 ;
 
 /* MEARS_L */
 
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
= 'Uxbridge DO'
  Group by 1, 4, 5, 8
 ;
 
 /* PARCELS_TOTAL */
 
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
= 'Uxbridge DO'
  Group by 1, 4, 5, 8
 ;
 
 
 /* PARCELS_TYPE */
 
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
= 'Uxbridge DO'
  Group by 1, 4, 5, 7, 9
 ;
 
 /* RMGTT_TOTAL */
 
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
= 'Uxbridge DO'
  Group by 1, 4, 5, 8
 ;
 
 /* RMGTT_TYPE */
 
    sel ---top 10 *
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
= 'Uxbridge DO'
  Group by 1, 4, 5, 7, 9
 ;
 
 /* TODS_TOTAL */
   sel ---top 10 *
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
= 'Uxbridge DO'
  Group by 1, 4, 5, 8
 ;
 
 /* TRACKED_TOTAL */
 
 
   sel ---top 10 *
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
= 'Uxbridge DO'
  Group by 1, 4, 5, 8
 ;
 
 
 ---------------------------------------------
 /*
 RUN DOs SEPARATELY
 */
----------------------------------------------
 
 
 /* DPS_VOLUMES */
 
 sel COALESCE (L.week_of_year, LL.week_of_year, P.week_of_year, T.week_of_year ) as WEEK_OF_YR, 
 COALESCE (L.route_name, LL.route_name, P.route_name, T.route_name ) as route_name, 
 COALESCE (L.route_id, LL.route_id, P.route_id, T.route_id )as route_id, 
 COALESCE (L.delivery_point_ref_num, LL.delivery_point_ref_num, P.delivery_point_ref_num, T.delivery_point_ref_num )as 

delivery_point_ref_num,  
 LL.LARGE_LETTERS,  L.LETTERS, P.PARCELS, T.TRACKED
 FROM
 (sel ---top 10 *
 cal.week_of_year, min (cal.calendar_date) as WC, max (cal.calendar_date) as WE,
 dagg.route_name, dagg.route_id, delivery_point_ref_num , sum(Volume) AS LARGE_LETTERS
 from EDW_SCVER_CODA_ACCS_VIEWS.v_DP_DAILY_AGG dagg
 inner join SYS_CALENDAR.Calendar cal on dagg.delivery_date = cal.calendar_date
 and dagg.source_system = 'MEARS-ADF'
 and dagg.postal_piece_type_desc = 'LARGE LETTER'
 and dagg.location_name_rln = 'Uxbridge DO'

 Group by 1, 4, 5, 6) LL

 FULL JOIN
 
 (sel ---top 10 *
 cal.week_of_year, min (cal.calendar_date) as WC, max (cal.calendar_date) as WE,
 dagg.route_name, dagg.route_id, delivery_point_ref_num , sum(Volume) AS LETTERS
 from EDW_SCVER_CODA_ACCS_VIEWS.v_DP_DAILY_AGG dagg
 inner join SYS_CALENDAR.Calendar cal on dagg.delivery_date = cal.calendar_date
 and dagg.source_system = 'MEARS-ADF'
 and dagg.postal_piece_type_desc = 'LETTER'
 and dagg.location_name_rln = 'Uxbridge DO'
 Group by 1, 4, 5, 6) L
 
 ON  L.week_of_year              = LL.week_of_year
 AND L.route_name                = LL.route_name
 AND L.route_id                  = LL.route_id  
 AND L.delivery_point_ref_num    = LL.delivery_point_ref_num
 
 FULL JOIN
 
 (sel ---top 10 *
 cal.week_of_year, min (cal.calendar_date) as WC, max (cal.calendar_date) as WE,
 dagg.route_name, dagg.route_id, delivery_point_ref_num , sum(Volume) AS PARCELS
 from EDW_SCVER_CODA_ACCS_VIEWS.v_DP_DAILY_AGG dagg
 inner join SYS_CALENDAR.Calendar cal on dagg.delivery_date = cal.calendar_date
 and dagg.source_system = 'PARCELS'
 and dagg.location_name_rln = 'Uxbridge DO'
 Group by 1, 4, 5, 6 ) P
 
 ON  L.week_of_year              = P.week_of_year
 AND L.route_name                = P.route_name
 AND L.route_id                  = P.route_id  
 AND L.delivery_point_ref_num    = P.delivery_point_ref_num
 
 FULL JOIN 
 (sel ---top 10 *
 cal.week_of_year, min (cal.calendar_date) as WC, max (cal.calendar_date) as WE,
 dagg.route_name, dagg.route_id, delivery_point_ref_num , sum(Volume) AS TRACKED
 from EDW_SCVER_CODA_ACCS_VIEWS.v_DP_DAILY_AGG dagg
 inner join SYS_CALENDAR.Calendar cal on dagg.delivery_date = cal.calendar_date
 and dagg.source_system IN ('TODS', 'RMGTT')
 and dagg.location_name_rln = 'Uxbridge DO'
 Group by 1, 4, 5, 6 ) T
 
 ON  L.week_of_year              = T.week_of_year
 AND L.route_name                = T.route_name
 AND L.route_id                  = T.route_id  
 AND L.delivery_point_ref_num    = T.delivery_point_ref_num
 
 ;
 
 
  /* DPS_MONTHLY_VOLUMES */
 
 sel 
 COALESCE (L.route_name, LL.route_name, P.route_name, T.route_name ) as route_name, 
 COALESCE (L.route_id, LL.route_id, P.route_id, T.route_id )as route_id, 
 COALESCE (L.delivery_point_ref_num, LL.delivery_point_ref_num, P.delivery_point_ref_num, T.delivery_point_ref_num )as 

delivery_point_ref_num,  
 LL.LARGE_LETTERS,  L.LETTERS, P.PARCELS, T.TRACKED
 FROM
 (sel ---top 10 *
 min (cal.calendar_date) as WC, max (cal.calendar_date) as WE,
 dagg.route_name, dagg.route_id, delivery_point_ref_num , sum(Volume) AS LARGE_LETTERS
 from EDW_SCVER_CODA_ACCS_VIEWS.v_DP_DAILY_AGG dagg
 inner join SYS_CALENDAR.Calendar cal on dagg.delivery_date = cal.calendar_date
 and dagg.source_system = 'MEARS-ADF'
 and dagg.postal_piece_type_desc = 'LARGE LETTER'
 and dagg.location_name_rln = 'Uxbridge DO'
 Group by 3,4,5) LL

 FULL JOIN
 
 (sel ---top 10 *
 min (cal.calendar_date) as WC, max (cal.calendar_date) as WE,
 dagg.route_name, dagg.route_id, delivery_point_ref_num , sum(Volume) AS LETTERS
 from EDW_SCVER_CODA_ACCS_VIEWS.v_DP_DAILY_AGG dagg
 inner join SYS_CALENDAR.Calendar cal on dagg.delivery_date = cal.calendar_date
 and dagg.source_system = 'MEARS-ADF'
 and dagg.postal_piece_type_desc = 'LETTER'
 and dagg.location_name_rln = 'Uxbridge DO'
 Group by 3,4,5) L
 
 ON  L.route_name                = LL.route_name
 AND L.route_id                  = LL.route_id  
 AND L.delivery_point_ref_num    = LL.delivery_point_ref_num
 
 FULL JOIN
 
 (sel ---top 10 *
  min (cal.calendar_date) as WC, max (cal.calendar_date) as WE,
 dagg.route_name, dagg.route_id, delivery_point_ref_num , sum(Volume) AS PARCELS
 from EDW_SCVER_CODA_ACCS_VIEWS.v_DP_DAILY_AGG dagg
 inner join SYS_CALENDAR.Calendar cal on dagg.delivery_date = cal.calendar_date
 and dagg.source_system = 'PARCELS'
 and dagg.location_name_rln = 'Uxbridge DO'
 Group by 3,4,5 ) P
 
 ON  L.route_name                = P.route_name
 AND L.route_id                  = P.route_id  
 AND L.delivery_point_ref_num    = P.delivery_point_ref_num
 
 FULL JOIN 
 (sel ---top 10 *
 min (cal.calendar_date) as WC, max (cal.calendar_date) as WE,
 dagg.route_name, dagg.route_id, delivery_point_ref_num , sum(Volume) AS TRACKED
 from EDW_SCVER_CODA_ACCS_VIEWS.v_DP_DAILY_AGG dagg
 inner join SYS_CALENDAR.Calendar cal on dagg.delivery_date = cal.calendar_date
 and dagg.source_system IN ('TODS', 'RMGTT')
 and dagg.location_name_rln = 'Uxbridge DO'
 Group by 3,4,5 ) T
 
 ON  L.route_name                = T.route_name
 AND L.route_id                  = T.route_id  
 AND L.delivery_point_ref_num    = T.delivery_point_ref_num
  ;
 
 
 
