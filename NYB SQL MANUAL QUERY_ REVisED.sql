

/*  SELECTING ONLY NYB ADDRESSES*/

drop table MgrS_LAM.NYB_ADDRESS;

create multiset table MgrS_LAM.NYB_ADDRESS as
(
sel distinct pa.party_id, pa.address_id from
EDW_SCVER_CODA_ACCS_VIEWS.V_PARTY_ADDRESS PA
inner join
EDW_SCVER_CODA_ACCS_VIEWS.V_DIM_ADDRESS DA
on pa.address_id = da.address_id
and pa.address_type_id = 1
AND DA.Not_Yet_Build IN ( 'Y' )
AND da.current_record_ind = 1
group by 1,2
)
with data
;

collect statistics column (PARTY_ID, address_id) 
ON MgrS_LAM.NYB_ADDRESS;


/*
sel count (*) from MgrS_LAM.NYB_ADDRESS ;
sel top 10 * from MgrS_LAM.NYB_ADDRESS ;
*/



sel
Organisation_Name,
prem_BUILDINGNUMBER,
prem_SUBBUILDING_NAME,
prem_BUILDINGNAME,
loc_PostTown,
Postcode,
Not_Yet_Build,
paf_udprn,
sum(Tods_Cnt),
sum(Rmgtt_Cnt),
sum(Mears_Cnt)

FROM 
(
/*TODS*/
SELECT
da.Organisation_Name,
da.prem_BUILDINGNUMBER,
da.prem_SUBBUILDING_NAME,
da.prem_BUILDINGNAME,
da.loc_PostTown,
da.Postcode,
da.Not_Yet_Build,
da.paf_udprn,
COUNT(DISTINCT EP.Piece_Id) AS Tods_Cnt,
null as Rmgtt_Cnt,
null as Mears_Cnt
FROM
EDW_SCVER_CODA_ACCS_VIEWS.V_DIM_ADDRESS DA,
EDW_SCVER_CODA_ACCS_VIEWS.V_DELIVERY D,
EDW_SCVER_CODA_ACCS_VIEWS.V_EVENT_PARTY EP,
MgrS_LAM.NYB_ADDRESS PA
WHERE
( D.Event_Id=EP.Event_Id )
AND ( PA.Address_Id=DA.address_id )
AND ( EP.Party_Id=PA.Party_Id )
AND
(
D.Event_Actual_Date BETWEEN date '2017-08-18' and date '2017-09-15'
AND EP.event_actual_dt BETWEEN date '2017-08-18' and date '2017-09-15'
AND DA.Not_Yet_Build IN ( 'Y' )
AND da.current_record_ind = 1
)
AND D.source_system = 'TODS'
GROUP BY 1,2,3,4,5,6,7,8

UNION

/*RMGTT*/
SELECT
da.Organisation_Name,
da.prem_BUILDINGNUMBER,
da.prem_SUBBUILDING_NAME,
da.prem_BUILDINGNAME,
da.loc_PostTown,
da.Postcode,
da.Not_Yet_Build,
da.paf_udprn,
null as Tods_Cnt,
COUNT(DISTINCT EP.Piece_Id) AS Rmgtt_Cnt,
null as Mears_Cnt
FROM
EDW_SCVER_CODA_ACCS_VIEWS.V_DIM_ADDRESS DA,
EDW_SCVER_CODA_ACCS_VIEWS.V_DELIVERY D,
EDW_SCVER_CODA_ACCS_VIEWS.V_EVENT_PARTY EP,
MgrS_LAM.NYB_ADDRESS PA
WHERE
( D.Event_Id=EP.Event_Id )
AND PA.Address_Id = DA.address_id
AND EP.Party_Id=PA.Party_Id
AND D.Event_Actual_Date BETWEEN date '2017-08-18' and date '2017-09-15'
AND EP.event_actual_dt BETWEEN date '2017-08-18' and date '2017-09-15'
AND DA.Not_Yet_Build = 'Y'
and da.current_record_ind = 1
AND D.source_system = 'RMGTT'
GROUP BY 1,2,3,4,5,6,7,8

UNION 

/* MEARS */
SELECT
da.Organisation_Name,
da.prem_BUILDINGNUMBER,
da.prem_SUBBUILDING_NAME,
da.prem_BUILDINGNAME,
da.loc_PostTown,
da.Postcode,
da.Not_Yet_Build,
da.paf_udprn,
null as Tods_Cnt,
null as Rmgtt_Cnt,
Count(distinct ep.Tag_Id || ep.Tag_Creation_Dt) as Mears_Cnt
FROM
edw_scver_coda_accs_views.v_Dim_Address da
inner join
MgrS_LAM.NYB_ADDRESS pa
on pa.Address_Id = da.Address_ID
inner join
edw_scver_coda_accs_views.v_event_party ep
on ep.Party_Id = pa.Party_Id

WHERE --AND ( mscv.RECORD_STATUS='M' )
ep.tag_creation_Dt BETWEEN date '2017-08-18' and date '2017-09-15'
AND EP.event_actual_dt BETWEEN date '2017-08-18' and date '2017-09-15'
AND da.Not_Yet_Build = 'Y'
and ep.data_source_type_id = 8
--and pa.address_type_id = 1
and da.current_record_ind = 1
GROUP BY
1, 2, 3, 4, 5, 6, 7, 8
)x

group by 1,2,3,4,5,6,7,8
;



