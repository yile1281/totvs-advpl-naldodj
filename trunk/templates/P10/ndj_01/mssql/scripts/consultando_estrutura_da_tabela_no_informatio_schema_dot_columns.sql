SELECT
	*
FROM 
	INFORMATION_SCHEMA.COLUMNS
WHERE
	TABLE_NAME = 'CNBSZ5'
AND
	COLUMN_NAME = 'CNB_DESCRI'
	
--ALTER TABLE CNBSZ5 ALTER COLUMN CNB_DESCRI VARCHAR(60) NOT NULL