WbVarDef today=@"select to_char(current_date,'mmddyyyy')";
WbExport -type=text
                 -file='C:\portableApps\FTP\voice_patrons\voice_patrons$[today].txt'
                 -delimiter='|'
                 -quoteAlways=true
                 -lineEnding=crlf
                 -encoding=utf8;


SELECT
	phone_number, 
	barcode,
	iii_language_pref_code
	
FROM sierra_view.patron_view v

JOIN sierra_view.patron_record_phone r  ON v.id = r.patron_record_id
JOIN sierra_view.patron_record_phone_type ty  ON r.patron_record_phone_type_id = ty.id

WHERE notification_medium_code = 'p' and code = 't' AND expiration_date_gmt > current_date
ORDER BY barcode;