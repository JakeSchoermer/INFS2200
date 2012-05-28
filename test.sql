CREATE OR REPLACE TRIGGER "APPLY_15_PERCENT_DISCOUNT"
	BEFORE INSERT OR UPDATE ON "PURCHASE"
	/*Will apply only to this row*/
	
BEGIN
	IF :NEW.CLIENT.CLIENTNO = 24535 then
		dbms_output.put_line('Trigger');
	END IF;
end;
