create or replace trigger "trg_prevent_future_witness_statement_date"
before insert or update on witness
for each row 
begin
    if :new.witness_statement_date > trunc(sysdate) then
        raise_application_error(-20001, 'The stataement date cannot be in the future.');
    end if;

end;
