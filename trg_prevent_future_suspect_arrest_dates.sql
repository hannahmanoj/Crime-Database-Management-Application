create or replace trigger "trg_prevent_future_suspect_arrest_dates"
before insert or update on suspect
for each row 
begin
    if :new.arrest_date > trunc(sysdate) then
        raise_application_error(-20001, 'The arrest date cannot be in the future.');
    end if;

end;
