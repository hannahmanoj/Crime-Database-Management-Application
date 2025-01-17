create or replace trigger "trg_prevent_future_witness_dob"
before insert or update on witness
for each row 
begin
    if :new.WITNESS_DATE_OF_BIRTH > trunc(sysdate) then
        raise_application_error(-20001, 'The date of birth cannot be in the future.');
    end if;

end;
