

/*  SELECTING ONLY POX_BOX ADDRESSES*/

drop table MgrS_LAM.POBOX_ADDRESS;

create multiset table MgrS_LAM.POBOX_ADDRESS as
(
sel distinct pa.party_id, pa.address_id, da.current_record_ind from
EDW_SCVER_CODA_ACCS_VIEWS.V_PARTY_ADDRESS PA
inner join
EDW_SCVER_CODA_ACCS_VIEWS.V_DIM_ADDRESS DA
on pa.address_id = da.address_id
and pa.address_type_id = 1
 and da.prem_pobox is not null
  and da.prem_pobox <> ''
group by 1,2,3
)
with data
;

collect statistics column (PARTY_ID, address_id) 
ON MgrS_LAM.POBOX_ADDRESS;


/*
sel count (*) from MgrS_LAM.POBOX_ADDRESS;
sel top 10 * from MgrS_LAM.POBOX_ADDRESS ;
*/



sel
Organisation_Name,
prem_pobox,
prem_BUILDINGNUMBER,
prem_SUBBUILDING_NAME,
prem_BUILDINGNAME,
loc_PostTown,
Postcode,
current_record_ind,
max(po_box_closure_date),
paf_udprn,
sum(Tods_Cnt),
sum(Rmgtt_Cnt),
sum(Mears_Cnt)

FROM 
(
/*TODS*/
SELECT
da.Organisation_Name,
da.prem_pobox,
da.prem_BUILDINGNUMBER,
da.prem_SUBBUILDING_NAME,
da.prem_BUILDINGNAME,
da.loc_PostTown,
da.Postcode,
da.current_record_ind,
max(da.po_box_closure_date) po_box_closure_date,
da.paf_udprn,
COUNT(DISTINCT EP.Piece_Id) AS Tods_Cnt,
null as Rmgtt_Cnt,
null as Mears_Cnt
FROM
MgrS_LAM.POBOX_ADDRESS PA
INNER JOIN
EDW_SCVER_CODA_ACCS_VIEWS.V_DIM_ADDRESS DA
ON DA.ADDRESS_ID = PA.ADDRESS_ID
LEFT JOIN
EDW_SCVER_CODA_ACCS_VIEWS.V_EVENT_PARTY EP
ON EP.Party_Id=PA.Party_Id
AND EP.event_actual_dt BETWEEN date '2017-09-01' and date '2017-09-30'
LEFT JOIN
EDW_SCVER_CODA_ACCS_VIEWS.V_DELIVERY D
ON D.EVENT_ID = EP.EVENT_ID
AND D.Event_Actual_Date BETWEEN date '2017-09-01' and date '2017-09-30'
AND D.source_system = 'TODS'
GROUP BY 1,2,3,4,5,6,7,8,10

UNION

/*RMGTT*/
SELECT
da.Organisation_Name,
da.prem_pobox,
da.prem_BUILDINGNUMBER,
da.prem_SUBBUILDING_NAME,
da.prem_BUILDINGNAME,
da.loc_PostTown,
da.Postcode,
da.current_record_ind,
max(da.po_box_closure_date) po_box_closure_date,
da.paf_udprn,
null as Tods_Cnt,
COUNT(DISTINCT EP.Piece_Id) AS Rmgtt_Cnt,
null as Mears_Cnt
FROM
MgrS_LAM.POBOX_ADDRESS PA
INNER JOIN 
EDW_SCVER_CODA_ACCS_VIEWS.V_DIM_ADDRESS DA
ON PA.Address_Id = DA.address_id
LEFT JOIN
EDW_SCVER_CODA_ACCS_VIEWS.V_EVENT_PARTY EP
ON EP.event_actual_dt BETWEEN date '2017-09-01' and date '2017-09-30'
AND EP.Party_Id = PA.Party_Id
LEFT JOIN
EDW_SCVER_CODA_ACCS_VIEWS.V_DELIVERY D
ON D.Event_Id = EP.Event_Id 
AND D.Event_Actual_Date BETWEEN date '2017-09-01' and date '2017-09-30'
AND D.source_system = 'RMGTT'
GROUP BY 1,2,3,4,5,6,7,8,10

UNION 

/* MEARS */
SELECT
da.Organisation_Name,
da.prem_pobox,
da.prem_BUILDINGNUMBER,
da.prem_SUBBUILDING_NAME,
da.prem_BUILDINGNAME,
da.loc_PostTown,
da.Postcode,
da.current_record_ind,
max(da.po_box_closure_date) po_box_closure_date,
da.paf_udprn,
null as Tods_Cnt,
null as Rmgtt_Cnt,
Count(distinct ep.Tag_Id) as Mears_Cnt
FROM
MgrS_LAM.POBOX_ADDRESS pa
inner join
edw_scver_coda_accs_views.v_Dim_Address da
on pa.Address_Id = da.Address_ID
left join
edw_scver_coda_accs_views.v_event_party ep
on ep.Party_Id = pa.Party_Id
AND ep.tag_creation_Dt BETWEEN date '2017-09-01' and date '2017-09-30'
AND EP.event_actual_dt BETWEEN date '2017-09-01' and date '2017-09-30'
and ep.data_source_type_id = 8
GROUP BY
1, 2, 3, 4, 5, 6, 7, 8,10
)x

group by 1,2,3,4,5,6,7,8,10
;



