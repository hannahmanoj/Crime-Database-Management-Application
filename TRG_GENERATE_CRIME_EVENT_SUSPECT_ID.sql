create or replace TRIGGER trg_generate_crime_event_suspect_id
BEFORE INSERT ON crime_event_suspect
FOR EACH ROW
BEGIN
   :NEW.crime_event_suspect_ID := 'CS' || LPAD(crime_event_suspect_ID_seq.NEXTVAL, 9, '0');
END;
