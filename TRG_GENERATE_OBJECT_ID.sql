create or replace TRIGGER trg_generate_object_id
BEFORE INSERT ON object
FOR EACH ROW
BEGIN
   :NEW.object_id := 'OBJ' || LPAD(object_id_sequence.NEXTVAL, 9, '0');
END;
