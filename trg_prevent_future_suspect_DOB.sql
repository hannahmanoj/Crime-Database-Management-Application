create or replace trigger "trg_prevent_future_suspect_DOB"
before insert or update on suspect
for each row 
begin
    if :new.suspect_date_of_birth > trunc(sysdate) then
        raise_application_error(-20001, 'The date of birth cannot be in the future.');
    end if;

end;
