create or replace TRIGGER trg_generate_witness_id
BEFORE INSERT ON Witness
FOR EACH ROW
BEGIN
    -- Generate a new WITNESS_ID using the sequence and a prefix
    :NEW.WITNESS_ID := 'W' || LPAD(witness_id_seq.NEXTVAL, 9, '0');
END;
