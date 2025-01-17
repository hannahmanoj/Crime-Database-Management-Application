create or replace trigger trg_generate_suspect_id
before insert on suspect
for each row
begin
:new.Suspect_ID := 'S' || LPAD(suspect_ID_seq.nextval, 9, '0');
end;
