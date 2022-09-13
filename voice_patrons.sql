WBVardef today=@"select to_char(current_date,'mmddyyyy')";
WBExport -type=text
                 -file='c:/shoutbomb/FTP/voice_patrons/voice_patrons$[today].txt'
                 -delimiter='|'
                 -quotechar='"'
                 -quoteCharEscaping=escape
                 -lineEnding=crlf
                 -encoding=utf8;

SELECT
	prp.phone_number AS phone_number,
	pv.barcode AS barcode,
	pv.iii_language_pref_code as language
FROM sierra_view.patron_view AS pv
	JOIN sierra_view.patron_record_phone AS prp
		ON (pv.id = prp.patron_record_id)
	JOIN sierra_view.varfield_view AS vv
	   ON (pv.record_num = vv.record_num)
WHERE prp.patron_record_phone_type_id = 1
	AND vv.record_type_code = 'p'
	AND vv.varfield_type_code = 'e'
	AND (vv.field_content LIKE 'p' OR vv.field_content LIKE 'P')
	and pv.barcode is not null
ORDER BY pv.barcode;
