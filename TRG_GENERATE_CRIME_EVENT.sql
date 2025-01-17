create or replace TRIGGER trg_generate_crime_event
BEFORE INSERT ON crime_event
FOR EACH ROW
BEGIN
   :NEW.crime_event_ID := 'CS' || LPAD(crime_event_ID_seq.NEXTVAL, 9, '0');
END;
