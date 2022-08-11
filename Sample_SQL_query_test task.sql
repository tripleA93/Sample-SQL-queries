SELECT p.Code,
	   cm.Name,
	   COUNT(*) as Count
	   
FROM dbo.commMatrix cm 

JOIN dbo.pact p
ON cm.SOrg = p.code
JOIN dbo.entrpStr e
ON p.code = e.Sales_Org

WHERE e.BUSINESS_AREA = 'IT'
GROUP BY p.Code, cm.Name
ORDER BY p.Code