create or replace trigger "trg_prevent_future_event_dates"
before insert or update on crime_event
for each row 
begin
    if :new.event_date > trunc(sysdate) then
        raise_application_error(-20001, 'The event date cannot be in the future.');
    end if;

end;
