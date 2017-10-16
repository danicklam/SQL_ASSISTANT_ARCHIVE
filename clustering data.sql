select 1, i.party_id, psd.address_id ,
da.Thfare_Id,  da.Locality_ID, i.Name_Prefix, i.Forename, i.Lastname, i.Name_Suffix, i.Gender_Ind,
CURRENT_DATE AS SCVER_LOAD_DTTM, 
CURRENT_DATE AS SCVER_UPD_DTTM, 
3 AS ETL_MODULE_RUN_ID,

PSD.address_id as address_grpng_key
from EDW_SCVER_CODA_ACCS_VIEWS.v_PARTY_SOURCE_DTL psd
, EDW_SCVER_CODA_ACCS_VIEWS.v_individual i
, EDW_SCVER_CODA_ACCS_VIEWS.v_dim_address da
, MgrS_LAM.SN_SELECTION mgr
where psd.party_id = i.party_id
and psd.address_id = da.address_id
and mgr.party_id = psd.party_id
and mgr.address_id = da.address_id
and psd.address_type_id = 1
;

