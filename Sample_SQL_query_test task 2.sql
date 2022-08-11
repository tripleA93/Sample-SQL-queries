ALTER TABLE dbo.Pact ADD Valid_From DATE
GO

ALTER TABLE dbo.Pact ADD Valid_To DATE
GO

UPDATE dbo.Pact
SET Valid_From = '2022-07-01', 
Valid_To = '9999-12-31';

SELECT
p.Vendor,
p.PartNumber,
p.Code,
p.Plant,
p.Valid_From,
p.Valid_To,
p.TP_Calculated,
NTILE(5) OVER (ORDER BY TP_Calculated) AS Tile


FROM dbo.commMatrix cm 
JOIN dbo.pact p
ON cm.SOrg = p.code
JOIN dbo.entrpStr e
ON p.code = e.Sales_Org

WHERE 
	p.TP_Diff BETWEEN -10 AND 10 
AND p.TP_Diff IS NOT NULL
AND p.TransferPriceQC = 'Not Loaded'
AND p.TP_Calculated > 0
AND p.TP_Validation_Name LIKE 'Approved'
OR  p.TP_Validation_Name LIKE 'Auto Approved'
AND e.BUSINESS_AREA = 'IT'
