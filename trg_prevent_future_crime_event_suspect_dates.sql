create or replace trigger "trg_prevent_future_crime_event_suspect_dates"
before insert or update on crime_event_suspect
for each row 
begin
    if :new.date_suspect_req > trunc(sysdate) then
        raise_application_error(-20001, 'The date cannot be in the future.');
    end if;

end;
