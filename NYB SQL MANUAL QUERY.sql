SELECT
da.Organisation_Name,
da.prem_BUILDINGNUMBER,
da.prem_SUBBUILDING_NAME,
da.prem_BUILDINGNAME,
da.loc_PostTown,
da.Postcode,
da.Not_Yet_Build,
da.paf_udprn,



  Count(distinct ep.Tag_Id || ep.Tag_Creation_Dt) as  countof
FROM
 edw_scver_coda_accs_views.v_Dim_Address da
 inner join
   edw_scver_coda_accs_views.v_party_address pa
   on  pa.Address_Id = da.Address_ID 
    inner join
   edw_scver_coda_accs_views.v_event_party ep
   on ep.Party_Id = pa.Party_Id  
--   inner join 
--  edw_scver_coda_accs_views.v_mears_shipper_piece mscv
--  on mscv.mears_Event_Id = ep.Event_Id  
  
  
  --edw_scver_coda_accs_views.v_paf_address paf
WHERE  --AND  ( mscv.RECORD_STATUS='M'  )
  ep.tag_creation_Dt between date '2017-03-01'  and date '2017-03-27'
  AND EP.event_actual_dt between date '2017-03-01' and date '2017-03-27'
  AND  da.Not_Yet_Build  = 'Y'  
  and ep.data_source_type_id = 8
 and da.current_record_ind = 1
GROUP BY
  1, 2, 3, 4, 5, 6, 7, 8
  ;
  
  
  
  SELECT
da.Organisation_Name,
da.prem_BUILDINGNUMBER,
da.prem_SUBBUILDING_NAME,
da.prem_BUILDINGNAME,
da.loc_PostTown,
da.Postcode,
da.Not_Yet_Build,
da.paf_udprn,
	COUNT(DISTINCT EP.Piece_Id) AS Rmgtt_Cnt
	FROM
  	EDW_SCVER_CODA_ACCS_VIEWS.V_DIM_ADDRESS DA,
  	EDW_SCVER_CODA_ACCS_VIEWS.V_DELIVERY D,
  	EDW_SCVER_CODA_ACCS_VIEWS.V_EVENT_PARTY EP,
  	EDW_SCVER_CODA_ACCS_VIEWS.V_PARTY_ADDRESS PA
	WHERE
  	( D.Event_Id=EP.Event_Id  )
  	AND   PA.Address_Id = DA.address_id  
  	AND   EP.Party_Id=PA.Party_Id  
	AND  D.Event_Actual_Date  BETWEEN  '2017-03-01' AND '2017-03-28' 
   	AND DA.Not_Yet_Build  = 'Y'  
  	AND D.source_system = 'RMGTT'
 and da.current_record_ind = 1
	GROUP BY 1,2,3,4,5,6,7,8;
	
	
	
  SELECT
da.Organisation_Name,
da.prem_BUILDINGNUMBER,
da.prem_SUBBUILDING_NAME,
da.prem_BUILDINGNAME,
da.loc_PostTown,
da.Postcode,
da.Not_Yet_Build,
da.paf_udprn,
COUNT(DISTINCT EP.Piece_Id) AS Tods_Cnt
	FROM
  	EDW_SCVER_CODA_ACCS_VIEWS.V_DIM_ADDRESS DA,
  	EDW_SCVER_CODA_ACCS_VIEWS.V_DELIVERY D,
  	EDW_SCVER_CODA_ACCS_VIEWS.V_EVENT_PARTY EP,
  	EDW_SCVER_CODA_ACCS_VIEWS.V_PARTY_ADDRESS PA
	WHERE
  	( D.Event_Id=EP.Event_Id  )
  	AND  ( PA.Address_Id=DA.address_id  )
  	AND  ( EP.Party_Id=PA.Party_Id  )
  	AND  
  	(
   	D.Event_Actual_Date  BETWEEN  '2017-03-01' AND '2017-03-28' 
   	AND DA.Not_Yet_Build  IN  ( 'Y'  )
  	)
  	AND D.source_system = 'TODS'
	 and da.current_record_ind = 1
	GROUP BY 1,2,3,4,5,6,7,8 
	;
  
  
  sel distinct paf_UDPRN from 
   	EDW_SCVER_CODA_ACCS_VIEWS.V_DIM_ADDRESS
	where current_record_ind = 1
	 	AND Not_Yet_Build = 'Y'  
		;
  
  
  
  