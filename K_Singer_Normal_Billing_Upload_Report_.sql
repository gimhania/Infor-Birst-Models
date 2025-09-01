K_Singer_Normal_Billing_Upload_Report

SELECT
	Summary.DatePart,
    ROUND(SUM(Summary.SINNCUI40FT),3) AS SINNCUI40FT,
    ROUND(SUM(Summary.SINNCUI20FT),3) AS SINNCUI20FT,
    ROUND(SUM(Summary.SINNCUILCL),3) AS SINNCUILCL,
    ROUND(SUM(Summary.SINNINBHN),3) AS SINNINBHN,
    ROUND(SUM(Summary.SINNOUTHN),3) AS SINNOUTHN,
    ROUND(SUM(Summary.SINNST),3) AS SINNST

FROM
(
		SELECT SINNCUI40FT.DatePart,
			   SINNCUI40FT.SINNCUI40FT,
			   0 AS SINNCUI20FT,
			   0 AS SINNCUILCL,
			   0 AS SINNINBHN,
			   0 AS SINNOUTHN,
			   0 AS SINNST
			   
		FROM (
			SELECT 9 'No',
				'Container Unloading  40ft_Local' 'Description',
				FORMAT(DATEADD(minute, 30, DATEADD(hour, 5, c.CHARGE_DATE)), 'MM-yyyy') 'DatePart',
				YEAR(DATEADD(minute, 30, DATEADD(hour, 5, c.CHARGE_DATE))) 'Year',
				((SUM(c.CHARGE_QTY)) / 1000000) 'SINNCUI40FT'
			FROM BILLADMIN.BIC_CHARGE c
			INNER JOIN BILLADMIN.BIC_CHARGE_CODE CHG_CODE ON c.CHARGE_CODE = CHG_CODE.CHARGE_CODE
			WHERE c.CHARGE_CODE = 'SIN-N-CUL-40FT'
				AND c.DELETE_FLAG = 0
			GROUP BY FORMAT(DATEADD(minute, 30, DATEADD(hour, 5, c.CHARGE_DATE)), 'MM-yyyy'),
				YEAR(DATEADD(minute, 30, DATEADD(hour, 5, c.CHARGE_DATE)))
			
			UNION
			
			SELECT 9 'No',
				'Container Unloading  40ft_Import' 'Description',
				FORMAT(DATEADD(minute, 30, DATEADD(hour, 5, c.CHARGE_DATE)), 'MM-yyyy') 'DatePart',
				YEAR(DATEADD(minute, 30, DATEADD(hour, 5, c.CHARGE_DATE))) 'Year',
				((SUM(c.CHARGE_QTY)) / 1000000) 'SINNCUI40FT'
			FROM BILLADMIN.BIC_CHARGE c
			INNER JOIN BILLADMIN.BIC_CHARGE_CODE CHG_CODE ON c.CHARGE_CODE = CHG_CODE.CHARGE_CODE
			WHERE c.CHARGE_CODE = 'SIN-N-CUI-40FT'
				AND c.DELETE_FLAG = 0
			GROUP BY FORMAT(DATEADD(minute, 30, DATEADD(hour, 5, c.CHARGE_DATE)), 'MM-yyyy'),
				YEAR(DATEADD(minute, 30, DATEADD(hour, 5, c.CHARGE_DATE)))
			) SINNCUI40FT
		
		UNION ALL
		
		SELECT SINNCUI20FT.DatePart,
			   0 AS SINNCUI40FT,
			   SINNCUI20FT.SINNCUI20FT,
			   0 AS SINNCUILCL,
			   0 AS SINNINBHN,
			   0 AS SINNOUTHN,
			   0 AS SINNST
			   
			   
		FROM (
			SELECT 10 'No',
				'Container Unloading  20ft_Local' 'Description',
				FORMAT(DATEADD(minute, 30, DATEADD(hour, 5, c.CHARGE_DATE)), 'MM-yyyy') 'DatePart',
				YEAR(DATEADD(minute, 30, DATEADD(hour, 5, c.CHARGE_DATE))) 'Year',
				((SUM(c.CHARGE_QTY)) / 1000000) 'SINNCUI20FT'
			FROM BILLADMIN.BIC_CHARGE c
			INNER JOIN BILLADMIN.BIC_CHARGE_CODE CHG_CODE ON c.CHARGE_CODE = CHG_CODE.CHARGE_CODE
			WHERE c.CHARGE_CODE = 'SIN-N-CUL-20FT'
				AND c.DELETE_FLAG = 0
			GROUP BY FORMAT(DATEADD(minute, 30, DATEADD(hour, 5, c.CHARGE_DATE)), 'MM-yyyy'),
				YEAR(DATEADD(minute, 30, DATEADD(hour, 5, c.CHARGE_DATE)))
			
			UNION
			
			SELECT 10 'No',
				'Container Unloading  20ft_Import' 'Description',
				FORMAT(DATEADD(minute, 30, DATEADD(hour, 5, c.CHARGE_DATE)), 'MM-yyyy') 'DatePart',
				YEAR(DATEADD(minute, 30, DATEADD(hour, 5, c.CHARGE_DATE))) 'Year',
				((SUM(c.CHARGE_QTY)) / 1000000) 'SINNCUI20FT'
			FROM BILLADMIN.BIC_CHARGE c
			INNER JOIN BILLADMIN.BIC_CHARGE_CODE CHG_CODE ON c.CHARGE_CODE = CHG_CODE.CHARGE_CODE
			WHERE c.CHARGE_CODE = 'SIN-N-CUI-20FT'
				AND c.DELETE_FLAG = 0
			GROUP BY FORMAT(DATEADD(minute, 30, DATEADD(hour, 5, c.CHARGE_DATE)), 'MM-yyyy'),
				YEAR(DATEADD(minute, 30, DATEADD(hour, 5, c.CHARGE_DATE)))
			) SINNCUI20FT
		
		UNION ALL
		
		SELECT SINNCUILCL.DatePart,
			   0 AS SINNCUI40FT,
			   0 AS SINNCUI20FT,
			   SINNCUILCL.SINNCUILCL,
			   0 AS SINNINBHN,
			   0 AS SINNOUTHN,
			   0 AS SINNST
			   
		FROM (
			SELECT 11 'No',
				'Container Unloading  LCL_Local' 'Description',
				FORMAT(DATEADD(minute, 30, DATEADD(hour, 5, c.CHARGE_DATE)), 'MM-yyyy') 'DatePart',
				YEAR(DATEADD(minute, 30, DATEADD(hour, 5, c.CHARGE_DATE))) 'Year',
				((SUM(c.CHARGE_QTY)) / 1000000) 'SINNCUILCL'
			FROM BILLADMIN.BIC_CHARGE c
			INNER JOIN BILLADMIN.BIC_CHARGE_CODE CHG_CODE ON c.CHARGE_CODE = CHG_CODE.CHARGE_CODE
			WHERE c.CHARGE_CODE = 'SIN-N-CUL-LCL'
				AND c.DELETE_FLAG = 0
			GROUP BY FORMAT(DATEADD(minute, 30, DATEADD(hour, 5, c.CHARGE_DATE)), 'MM-yyyy'),
				YEAR(DATEADD(minute, 30, DATEADD(hour, 5, c.CHARGE_DATE)))
			
			UNION
			
			SELECT 11 'No',
				'Container Unloading  LCL_Import' 'Description',
				FORMAT(DATEADD(minute, 30, DATEADD(hour, 5, c.CHARGE_DATE)), 'MM-yyyy') 'DatePart',
				YEAR(DATEADD(minute, 30, DATEADD(hour, 5, c.CHARGE_DATE))) 'Year',
				((SUM(c.CHARGE_QTY)) / 1000000) 'SINNCUILCL'
			FROM BILLADMIN.BIC_CHARGE c
			INNER JOIN BILLADMIN.BIC_CHARGE_CODE CHG_CODE ON c.CHARGE_CODE = CHG_CODE.CHARGE_CODE
			WHERE c.CHARGE_CODE = 'SIN-N-CUI-LCL'
				AND c.DELETE_FLAG = 0
			GROUP BY FORMAT(DATEADD(minute, 30, DATEADD(hour, 5, c.CHARGE_DATE)), 'MM-yyyy'),
				YEAR(DATEADD(minute, 30, DATEADD(hour, 5, c.CHARGE_DATE)))
			) SINNCUILCL
		
		UNION ALL
		
		SELECT SINNINBHN.DatePart,
			   0 AS SINNCUI40FT,
			   0 AS SINNCUI20FT,
			   0 AS SINNCUILCL,
			   SINNINBHN.SINNINBHN,
			   0 AS SINNOUTHN,
			   0 AS SINNST
			   
		FROM (
			SELECT 2 'No',
				'Additional Handling - Inbound (CBM)' 'Description',
				FORMAT(DATEADD(minute, 30, DATEADD(hour, 5, c.CHARGE_DATE)), 'MM-yyyy') 'DatePart',
				YEAR(DATEADD(minute, 30, DATEADD(hour, 5, c.CHARGE_DATE))) 'Year',
				--((SUM(c.CHARGE_QTY))/1000000)- 12750 'SINNINBHN'
				CASE 
					WHEN SUM(c.CHARGE_QTY) > 12750000000
						THEN (SUM(c.CHARGE_QTY) / 1000000) - 12750
					ELSE 0
					END 'SINNINBHN'
			FROM BILLADMIN.BIC_CHARGE c
			INNER JOIN BILLADMIN.BIC_CHARGE_CODE CHG_CODE ON c.CHARGE_CODE = CHG_CODE.CHARGE_CODE
			WHERE c.CHARGE_CODE = 'SIN-N-INBHN'
				AND c.DELETE_FLAG = 0
			GROUP BY FORMAT(DATEADD(minute, 30, DATEADD(hour, 5, c.CHARGE_DATE)), 'MM-yyyy'),
				YEAR(DATEADD(minute, 30, DATEADD(hour, 5, c.CHARGE_DATE)))
			) SINNINBHN
		
		UNION ALL
		
		SELECT SINNOUTHN.DatePart,
			   0 AS SINNCUI40FT,
			   0 AS SINNCUI20FT,
			   0 AS SINNCUILCL,
			   0 AS SINNINBHN,
			   SINNOUTHN.SINNOUTHN,
			   0 AS SINNST
			   
		FROM (
			SELECT 3 'No',
				'Additional Handling - Outbound (CBM)' 'Description',
				FORMAT(DATEADD(minute, 30, DATEADD(hour, 5, c.CHARGE_DATE)), 'MM-yyyy') 'DatePart',
				YEAR(DATEADD(minute, 30, DATEADD(hour, 5, c.CHARGE_DATE))) 'Year',
				--((SUM(c.CHARGE_QTY))/1000000)- 12750 'SINNOUTHN'
				CASE 
					WHEN SUM(c.CHARGE_QTY) > 12750000000
						THEN (SUM(c.CHARGE_QTY) / 1000000) - 12750
					ELSE 0
					END 'SINNOUTHN'
			FROM BILLADMIN.BIC_CHARGE c
			INNER JOIN BILLADMIN.BIC_CHARGE_CODE CHG_CODE ON c.CHARGE_CODE = CHG_CODE.CHARGE_CODE
			WHERE c.CHARGE_CODE = 'SIN-N-OUTHN'
				AND c.DELETE_FLAG = 0
			GROUP BY FORMAT(DATEADD(minute, 30, DATEADD(hour, 5, c.CHARGE_DATE)), 'MM-yyyy'),
				YEAR(DATEADD(minute, 30, DATEADD(hour, 5, c.CHARGE_DATE)))
			) SINNOUTHN
		
		UNION ALL
		
		SELECT SINNST.DatePart,
			   0 AS SINNCUI40FT,
			   0 AS SINNCUI20FT,
			   0 AS SINNCUILCL,
			   0 AS SINNINBHN,
			   0 AS SINNOUTHN,
			   SINNST.SINNST
			   
		FROM (
			SELECT 4 'No',
				'Additional Storage (CBM)' 'Description',
				FORMAT(DATEADD(minute, 30, DATEADD(hour, 5, d.CHARGE_DATE)), 'MM-yyyy') AS "DatePart",
				YEAR(DATEADD(minute, 30, DATEADD(hour, 5, d.CHARGE_DATE))) AS "Year",
				SUM(d.Excess) 'SINNST'
			FROM (
				SELECT c.CHARGE_DATE,
					SUM(c.CHARGE_QTY) / 1000000 'DailyTotal',
					CASE 
						WHEN (SUM(c.CHARGE_QTY) / 1000000) > 23000
							THEN (SUM(c.CHARGE_QTY) / 1000000) - 23000
						ELSE 0
						END AS Excess
				FROM BILLADMIN.BIC_CHARGE c
				WHERE c.CHARGE_CODE IN (
						'SIN-N-ST',
						'SIN-N-OUTHN'
						)
					AND c.DELETE_FLAG = 0
				GROUP BY c.CHARGE_DATE
				) d
			GROUP BY FORMAT(DATEADD(minute, 30, DATEADD(hour, 5, d.CHARGE_DATE)), 'MM-yyyy'),
				YEAR(DATEADD(minute, 30, DATEADD(hour, 5, d.CHARGE_DATE)))
			) SINNST
		) Summary
		
		GROUP BY Summary.DatePart
