sel 
count (*) (Float), count (distinct party_id) (FLOAT),
count (distinct party_id||address_id) (FLOAT)
from
EDW_SCVER_CODA_ACCS_VIEWS.v_party_address
--where party_type_id = 1
where address_type_id = 1
;

sel count (*) (Float), 'Row_Count' from
EDW_SCVER_CODA_ACCS_VIEWS.v_party_address
--where party_type_id = 1
where address_type_id = 1
UNION
sel count (distinct party_id) (FLOAT) , 'istinct_parties'from
EDW_SCVER_CODA_ACCS_VIEWS.v_party_address
--where party_type_id = 1
where address_type_id = 1
;

sel top 10 * from 
EDW_SCVER_CODA_ACCS_VIEWS.v_party_address
;

