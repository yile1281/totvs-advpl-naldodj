UPDATE SC1010 SET SC1010.C1_XPANEXO = 'T' FROM SC1010 WHERE EXISTS (
SELECT 
	1
FROM
	ACB010 ACB
WHERE
	SUBSTRING(ACB.ACB_OBJETO,1,2)='SC' AND SUBSTRING(ACB.ACB_OBJETO,1,8)= 'SC'+SC1010.C1_NUM
	)
