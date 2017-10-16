

Sel ep.* , sp.*, ind.*
from EDW_SCVER_CODA_ACCS_VIEWS.V_Event_Party ep
        inner join EDW_SCVER_CODA_ACCS_VIEWS.V_INDIVIDUAL Ind
        on ind.party_id = ep.party_id
        inner join EDW_SCVER_CODA_ACCS_VIEWS.V_Shipper_Piece SP
        on EP.Piece_Id = SP.Piece_Id
		inner join MgrS_LAM.SN_SELECTION SN
		on SN.party_id = Ind.Party_id
where ep.data_source_type_id = 11
and ep.event_actual_dt          between date '2017-02-01' and date'2017-02-10'
and SP.event_actual_date     between date '2017-02-01' and date'2017-02-10' 

UNION 

Sel ep.* , sp.*, ind.*
from EDW_SCVER_CODA_ACCS_VIEWS.V_Event_Party ep
        inner join EDW_SCVER_CODA_ACCS_VIEWS.V_INDIVIDUAL Ind
        on ind.party_id = ep.party_id
        inner join EDW_SCVER_CODA_ACCS_VIEWS.V_Shipper_Piece SP
        on EP.Piece_Id = SP.Piece_Id
		inner join MgrS_LAM.SN_SELECTION SN
		on SN.party_id = Ind.Party_id
where ep.data_source_type_id = 11
and ep.event_actual_dt         between date '2017-02-11' and date'2017-02-20'
and SP.event_actual_date     between date '2017-02-11' and date'2017-02-20'

UNION

Sel ep.* , sp.*, ind.*
from EDW_SCVER_CODA_ACCS_VIEWS.V_Event_Party ep
        inner join EDW_SCVER_CODA_ACCS_VIEWS.V_INDIVIDUAL Ind
        on ind.party_id = ep.party_id
        inner join EDW_SCVER_CODA_ACCS_VIEWS.V_Shipper_Piece SP
        on EP.Piece_Id = SP.Piece_Id
		inner join MgrS_LAM.SN_SELECTION SN
		on SN.party_id = Ind.Party_id
where ep.data_source_type_id = 11
and ep.event_actual_dt    between     date '2017-02-21' and date'2017-02-28'
and SP.event_actual_date    between  date '2017-02-21' and date'2017-02-28'
;

--and event_actual_dt between date '2017-01-11' and date'2017-01-20'
--and event_actual_dt between date '2017-01-21' and date'2017-01-31'
--and event_actual_dt between date '2017-02-01' and date'2017-02-10'
--and event_actual_dt between date '2017-02-11' and date'2017-02-20'
--and event_actual_dt between date '2017-02-21' and date'2017-02-28'








sel top 100 * from
EDW_SCVER_CODA_ACCS_VIEWS.V_Event_Party
;


sel event_actual_dt, count (*) from
EDW_SCVER_CODA_ACCS_VIEWS.V_Event_Party
where event_actual_dt > date '2017-02-01'
and data_source_type_id = 11
group by 1
;