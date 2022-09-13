WBVardef today=@"select to_char(current_date,'mmddyyyy')";
WBExport -type=text
                 -file='c:/shoutbomb/FTP/text_patrons/text_patrons$[today].txt'
                 -delimiter='|'
                 -quotechar='"'
                 -quoteCharEscaping=escape
                 -lineEnding=crlf
                 -encoding=utf8;

SELECT
	vv1.field_content AS phone_number,
	pv.barcode AS barcode,
	pv.iii_language_pref_code as language
FROM sierra_view.patron_view AS pv
	JOIN sierra_view.varfield_view AS vv1 
		ON (pv.record_num = vv1.record_num)
	JOIN sierra_view.varfield_view AS vv2 
		ON (pv.record_num = vv2.record_num)
WHERE vv1.record_type_code = 'p'
	AND vv1.varfield_type_code = 'o'
	AND vv2.varfield_type_code = 'e'
	AND (vv2.field_content LIKE 't' OR vv2.field_content LIKE 'T')
	AND pv.barcode is not null
ORDER BY barcode;
