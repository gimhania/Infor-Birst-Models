SELECT summaryUltra.MonthYear,
	SUM(summaryUltra.SINVAS3) AS SINVAS3,
	SUM(summaryUltra.SINVAS2) AS SINVAS2,
	SUM(summaryUltra.SINVAS4) AS SINVAS4,
	SUM(summaryUltra.SINVAS1) AS SINVAS1,
	SUM(summaryUltra.SINADDHNM) AS SINADDHNM,
	SUM(summaryUltra.SINADDSTM) AS SINADDSTM,
	SUM(summaryUltra.SINADDSTL) AS SINADDSTL,
	SUM(summaryUltra.SINDAILYCAPM) AS SINDAILYCAPM,
	SUM(summaryUltra.SINDAILYCAPL) AS SINDAILYCAPL,
	SUM(summaryUltra.SINADDHNL) AS SINADDHNL
FROM (
	SELECT FORMAT(summary.charge_date, 'MM-yyyy') AS MonthYear,
		SUM(summary.total_charge_qty_SINVAS3) AS SINVAS3,
		SUM(summary.total_charge_qty_SINVAS2) AS SINVAS2,
		SUM(summary.total_charge_qty_SINVAS4) AS SINVAS4,
		SUM(summary.total_charge_qty_SINVAS1) AS SINVAS1,
		0 AS SINADDHNM,
		SUM(summary.total_charge_qty_SINADDSTM) AS SINADDSTM,
		SUM(summary.total_charge_qty_SINADDSTL) AS SINADDSTL,
		SUM(summary.total_charge_qty_SINDAILYCAPM) AS SINDAILYCAPM,
		SUM(summary.total_charge_qty_SINDAILYCAPL) AS SINDAILYCAPL,
		0 AS SINADDHNL
	FROM (
		SELECT CAST(DATEADD(minute, 30, DATEADD(hour, 5, charge_date)) AS DATE) AS charge_date,
			SUM(charge_qty) AS total_charge_qty_SINVAS3,
			0 AS total_charge_qty_SINVAS2,
			0 AS total_charge_qty_SINVAS4,
			0 AS total_charge_qty_SINVAS1,
			0 AS total_charge_qty_SINADDHNM,
			0 AS total_charge_qty_SINADDSTM,
			0 AS total_charge_qty_SINADDSTL,
			0 AS total_charge_qty_SINDAILYCAPM,
			0 AS total_charge_qty_SINDAILYCAPL,
			0 AS SUM_EXTRA_QTY_SINADDHNL
		FROM BILLADMIN.BIC_CHARGE
		WHERE charge_code = 'SINVAS3'
			AND cust_code = 'SINGERHIGH'
		GROUP BY CAST(DATEADD(minute, 30, DATEADD(hour, 5, charge_date)) AS DATE)
		
		UNION ALL
		
		SELECT CAST(DATEADD(minute, 30, DATEADD(hour, 5, charge_date)) AS DATE) AS charge_date,
			0 AS total_charge_qty_SINVAS3,
			SUM(charge_qty) AS total_charge_qty_SINVAS2,
			0 AS total_charge_qty_SINVAS4,
			0 AS total_charge_qty_SINVAS1,
			0 AS total_charge_qty_SINADDHNM,
			0 AS total_charge_qty_SINADDSTM,
			0 AS total_charge_qty_SINADDSTL,
			0 AS total_charge_qty_SINDAILYCAPM,
			0 AS total_charge_qty_SINDAILYCAPL,
			0 AS SUM_EXTRA_QTY_SINADDHNL
		FROM BILLADMIN.BIC_CHARGE
		WHERE charge_code = 'SINVAS2'
			AND cust_code = 'SINGERHIGH'
		GROUP BY CAST(DATEADD(minute, 30, DATEADD(hour, 5, charge_date)) AS DATE)
		
		UNION ALL
		
		SELECT CAST(DATEADD(minute, 30, DATEADD(hour, 5, charge_date)) AS DATE) AS charge_date,
			0 AS total_charge_qty_SINVAS3,
			0 AS total_charge_qty_SINVAS2,
			SUM(charge_qty) AS total_charge_qty_SINVAS4,
			0 AS total_charge_qty_SINVAS1,
			0 AS total_charge_qty_SINADDHNM,
			0 AS total_charge_qty_SINADDSTM,
			0 AS total_charge_qty_SINADDSTL,
			0 AS total_charge_qty_SINDAILYCAPM,
			0 AS total_charge_qty_SINDAILYCAPL,
			0 AS SUM_EXTRA_QTY_SINADDHNL
		FROM BILLADMIN.BIC_CHARGE
		WHERE charge_code = 'SINVAS4'
			AND cust_code = 'SINGERHIGH'
		GROUP BY CAST(DATEADD(minute, 30, DATEADD(hour, 5, charge_date)) AS DATE)
		
		UNION ALL
		
		SELECT CAST(DATEADD(minute, 30, DATEADD(hour, 5, charge_date)) AS DATE) AS charge_date,
			0 AS total_charge_qty_SINVAS3,
			0 AS total_charge_qty_SINVAS2,
			0 AS total_charge_qty_SINVAS4,
			SUM(charge_qty) AS total_charge_qty_SINVAS1,
			0 AS total_charge_qty_SINADDHNM,
			0 AS total_charge_qty_SINADDSTM,
			0 AS total_charge_qty_SINADDSTL,
			0 AS total_charge_qty_SINDAILYCAPM,
			0 AS total_charge_qty_SINDAILYCAPL,
			0 AS SUM_EXTRA_QTY_SINADDHNL
		FROM BILLADMIN.BIC_CHARGE
		WHERE charge_code = 'SINVAS1'
			AND cust_code = 'SINGERHIGH'
		GROUP BY CAST(DATEADD(minute, 30, DATEADD(hour, 5, charge_date)) AS DATE)
		
		UNION ALL
		
		--======== 5 Additional Storage - Mobile Phones=====================================================Daily
		SELECT CAST(DATEADD(minute, 30, DATEADD(hour, 5, cd.charge_date)) AS DATE) AS charge_date,
			0 AS total_charge_qty_SINVAS3,
			0 AS total_charge_qty_SINVAS2,
			0 AS total_charge_qty_SINVAS4,
			0 AS total_charge_qty_SINVAS1,
			0 AS total_charge_qty_SINADDHNM,
			SUM(cd.EXTRA_QTY) AS total_charge_qty_SINADDSTM,
			0 AS total_charge_qty_SINADDSTL,
			0 AS total_charge_qty_SINDAILYCAPM,
			0 AS total_charge_qty_SINDAILYCAPL,
			0 AS SUM_EXTRA_QTY_SINADDHNL
		FROM (
			SELECT biSum.CHARGE_RATE 'CHARGE_RATE',
				biSum.RATE_GROUP 'RATE_GROUP',
				sum(biSum.SUM_QTY) 'SUM_QTY',
				IIF(SUM(biSum.SUM_QTY) > 68976, (SUM(biSum.SUM_QTY) - 68976), 0) 'EXTRA_QTY',
				biSum.CHARGE_DATE 'CHARGE_DATE'
			FROM (
				SELECT c.CHARGE_RATE CHARGE_RATE,
					c.RATE_GROUP RATE_GROUP,
					sum(c.CHARGE_QTY) SUM_QTY,
					DateAdd(Day, - 1, cast(c.CHARGE_DATE AS DATE)) 'CHARGE_DATE'
				FROM BILLADMIN.BIC_CHARGE c
				INNER JOIN BILLADMIN.BIC_CHARGE_CODE CHG_CODE ON c.CHARGE_CODE = CHG_CODE.CHARGE_CODE
				WHERE c.RATE_GROUP = 'SIGERHIGHPHONE'
					AND c.CHARGE_CODE IN ('SINST')
					AND c.DELETE_FLAG = 0 --AND c.CHARGE_DATE >='2024-12-02' AND c.CHARGE_DATE <='2025-01-01'
					--AND c.CHARGE_DATE >=DateAdd(Day,1,cast ('V{Kes_CurrentMonthStartDate}' as Date)) AND c.CHARGE_DATE <=DateAdd(Day,1,cast ('V{Kes_CurrentMonthEndDate}' as Date))
				GROUP BY c.CHARGE_RATE,
					c.RATE_GROUP,
					c.CHARGE_DATE
				
				UNION
				
				SELECT c.CHARGE_RATE CHARGE_RATE,
					c.RATE_GROUP RATE_GROUP,
					sum(c.CHARGE_QTY) SUM_QTY,
					c.CHARGE_DATE 'CHARGE_DATE'
				FROM BILLADMIN.BIC_CHARGE c
				INNER JOIN BILLADMIN.BIC_CHARGE_CODE CHG_CODE ON c.CHARGE_CODE = CHG_CODE.CHARGE_CODE
				WHERE c.RATE_GROUP = 'SIGERHIGHPHONE'
					AND c.CHARGE_CODE IN ('SINOUTHN')
					AND c.BIll_LEVEL != 'ITEMGROUP'
					AND c.DELETE_FLAG = 0 --AND c.CHARGE_DATE >='2024-12-01' AND c.CHARGE_DATE <='2024-12-31'
					--AND c.CHARGE_DATE >='V{Kes_CurrentMonthStartDate}' AND c.CHARGE_DATE <='V{Kes_CurrentMonthEndDate}'
				GROUP BY c.CHARGE_RATE,
					c.RATE_GROUP,
					c.CHARGE_DATE
				) biSum
			GROUP BY biSum.CHARGE_RATE,
				biSum.RATE_GROUP,
				biSum.CHARGE_DATE
			) cd
		GROUP BY cd.CHARGE_RATE,
			cd.RATE_GROUP,
			CAST(DATEADD(minute, 30, DATEADD(hour, 5, cd.charge_date)) AS DATE)
		
		UNION ALL
		
		SELECT CAST(DATEADD(minute, 30, DATEADD(hour, 5, cd.charge_date)) AS DATE) AS charge_date,
			0 AS total_charge_qty_SINVAS3,
			0 AS total_charge_qty_SINVAS2,
			0 AS total_charge_qty_SINVAS4,
			0 AS total_charge_qty_SINVAS1,
			0 AS total_charge_qty_SINADDHNM,
			0 AS total_charge_qty_SINADDSTM,
			SUM(cd.EXTRA_QTY) AS total_charge_qty_SINADDSTL,
			0 AS total_charge_qty_SINDAILYCAPM,
			0 AS total_charge_qty_SINDAILYCAPL,
			0 AS SUM_EXTRA_QTY_SINADDHNL
		FROM (
			SELECT biSum.CHARGE_RATE 'CHARGE_RATE',
				biSum.RATE_GROUP 'RATE_GROUP',
				sum(biSum.SUM_QTY) 'SUM_QTY',
				IIF(SUM(biSum.SUM_QTY) > 6274, (SUM(biSum.SUM_QTY) - 6274), 0) 'EXTRA_QTY',
				biSum.CHARGE_DATE 'CHARGE_DATE'
			FROM (
				SELECT c.CHARGE_RATE CHARGE_RATE,
					c.RATE_GROUP RATE_GROUP,
					sum(c.CHARGE_QTY) SUM_QTY,
					DateAdd(Day, - 1, cast(c.CHARGE_DATE AS DATE)) 'CHARGE_DATE'
				FROM BILLADMIN.BIC_CHARGE c
				INNER JOIN BILLADMIN.BIC_CHARGE_CODE CHG_CODE ON c.CHARGE_CODE = CHG_CODE.CHARGE_CODE
				WHERE c.RATE_GROUP = 'SIGERHIGHLAPTOPS'
					AND c.CHARGE_CODE IN ('SINST')
					AND c.DELETE_FLAG = 0
				GROUP BY c.CHARGE_RATE,
					c.RATE_GROUP,
					c.CHARGE_DATE
				
				UNION
				
				SELECT c.CHARGE_RATE CHARGE_RATE,
					c.RATE_GROUP RATE_GROUP,
					sum(c.CHARGE_QTY) SUM_QTY,
					c.CHARGE_DATE 'CHARGE_DATE'
				FROM BILLADMIN.BIC_CHARGE c
				INNER JOIN BILLADMIN.BIC_CHARGE_CODE CHG_CODE ON c.CHARGE_CODE = CHG_CODE.CHARGE_CODE
				WHERE c.RATE_GROUP = 'SIGERHIGHLAPTOPS'
					AND c.CHARGE_CODE IN ('SINOUTHN')
					AND c.BIll_LEVEL != 'ITEMGROUP'
					AND c.DELETE_FLAG = 0
				GROUP BY c.CHARGE_RATE,
					c.RATE_GROUP,
					c.CHARGE_DATE
				) biSum
			GROUP BY biSum.CHARGE_RATE,
				biSum.RATE_GROUP,
				biSum.CHARGE_DATE
			) cd
		GROUP BY cd.CHARGE_RATE,
			cd.RATE_GROUP,
			CAST(DATEADD(minute, 30, DATEADD(hour, 5, cd.charge_date)) AS DATE)
		
		UNION ALL
		
		--======== 7 Daily cap 4000 pcs Additional Storage - Mobile Phones==================================Daily
		SELECT CAST(DATEADD(minute, 30, DATEADD(hour, 5, cd.charge_date)) AS DATE) AS charge_date,
			0 AS total_charge_qty_SINVAS3,
			0 AS total_charge_qty_SINVAS2,
			0 AS total_charge_qty_SINVAS4,
			0 AS total_charge_qty_SINVAS1,
			0 AS total_charge_qty_SINADDHNM,
			0 AS total_charge_qty_SINADDSTM,
			0 AS total_charge_qty_SINADDSTL,
			SUM(cd.EXTRA_QTY) AS total_charge_qty_SINDAILYCAPM,
			0 AS total_charge_qty_SINDAILYCAPL,
			0 AS SUM_EXTRA_QTY_SINADDHNL
		FROM (
			SELECT c.CHARGE_RATE CHARGE_RATE,
				c.RATE_GROUP RATE_GROUP,
				sum(c.CHARGE_QTY) SUM_QTY,
				IIF(SUM(c.CHARGE_QTY) > 3184, (SUM(c.CHARGE_QTY) - 3184), 0) EXTRA_QTY,
				c.CHARGE_DATE
			FROM BILLADMIN.BIC_CHARGE c
			INNER JOIN BILLADMIN.BIC_CHARGE_CODE CHG_CODE ON c.CHARGE_CODE = CHG_CODE.CHARGE_CODE
			WHERE c.RATE_GROUP = 'SIGERHIGHPHONE'
				AND c.CHARGE_CODE IN (
					'SINST',
					'SINOUTHN'
					)
				AND c.BIll_LEVEL != 'ITEMGROUP'
				AND c.DELETE_FLAG = 0
			GROUP BY c.CHARGE_RATE,
				c.RATE_GROUP,
				c.CHARGE_DATE
			) cd
		GROUP BY CAST(DATEADD(minute, 30, DATEADD(hour, 5, cd.charge_date)) AS DATE),
			cd.RATE_GROUP,
			cd.CHARGE_RATE
		
		UNION ALL
		
		--======== 8 Daily cap 4000 pcs Additional Storage - Laptops/Computers==============================Daily
		SELECT CAST(DATEADD(minute, 30, DATEADD(hour, 5, cd.charge_date)) AS DATE) AS charge_date,
			0 AS total_charge_qty_SINVAS3,
			0 AS total_charge_qty_SINVAS2,
			0 AS total_charge_qty_SINVAS4,
			0 AS total_charge_qty_SINVAS1,
			0 AS total_charge_qty_SINADDHNM,
			0 AS total_charge_qty_SINADDSTM,
			0 AS total_charge_qty_SINADDSTL,
			0 AS total_charge_qty_SINDAILYCAPM,
			SUM(cd.EXTRA_QTY) AS total_charge_qty_SINDAILYCAPL,
			0 AS SUM_EXTRA_QTY_SINADDHNL
		FROM (
			SELECT c.CHARGE_RATE CHARGE_RATE,
				c.RATE_GROUP RATE_GROUP,
				sum(c.CHARGE_QTY) SUM_QTY,
				IIF(SUM(c.CHARGE_QTY) > 816, (SUM(c.CHARGE_QTY) - 816), 0) EXTRA_QTY,
				c.CHARGE_DATE
			FROM BILLADMIN.BIC_CHARGE c
			INNER JOIN BILLADMIN.BIC_CHARGE_CODE CHG_CODE ON c.CHARGE_CODE = CHG_CODE.CHARGE_CODE
			WHERE c.RATE_GROUP = 'SIGERHIGHLAPTOPS'
				AND c.CHARGE_CODE IN (
					'SINST',
					'SINOUTHN'
					)
				AND c.BIll_LEVEL != 'ITEMGROUP'
				AND c.DELETE_FLAG = 0
			GROUP BY c.CHARGE_RATE,
				c.RATE_GROUP,
				c.CHARGE_DATE
			) cd
		GROUP BY CAST(DATEADD(minute, 30, DATEADD(hour, 5, cd.charge_date)) AS DATE)
		) summary
	GROUP BY FORMAT(summary.charge_date, 'MM-yyyy')
	
	UNION
	
	SELECT cd.DATEPART AS MonthYear,
		0 AS SINVAS3,
		0 AS SINVAS2,
		0 AS SINVAS4,
		0 AS SINVAS1,
		0 AS SINADDHNM,
		0 AS SINADDSTM,
		0 AS SINADDSTL,
		0 AS SINDAILYCAPM,
		0 AS SINDAILYCAPL,
		SUM(cd.SUM_EXTRA_QTY) AS SINADDHNL
	FROM (
		SELECT FORMAT(biSum.DATEPART, 'MM-yyyy') AS DATEPART,
			IIF(SUM(biSum.SUM_QTY) > 4500, (SUM(biSum.SUM_QTY) - 4500), 0) SUM_EXTRA_QTY
		FROM (
			SELECT c.RATE_GROUP RATE_GROUP,
				MIN(c.CHARGE_RATE) CHARGE_RATE,
				SUM(c.CHARGE_QTY) SUM_QTY,
				CAST(DATEADD(minute, 30, DATEADD(hour, 5, c.charge_date)) AS DATE) 'DATEPART'
			FROM BILLADMIN.BIC_CHARGE c
			INNER JOIN BILLADMIN.BIC_CHARGE_CODE CHG_CODE ON c.CHARGE_CODE = CHG_CODE.CHARGE_CODE
			WHERE c.RATE_GROUP = 'SIGERHIGHLAPTOPS'
				AND c.CHARGE_CODE = 'SININBHN'
				AND c.BIll_LEVEL != 'ITEMGROUP'
				AND c.DELETE_FLAG = 0
			GROUP BY c.CHARGE_CODE,
				c.CHARGE_RATE,
				c.RATE_GROUP,
				CHG_CODE.CHARGE_DESC,
				CAST(DATEADD(minute, 30, DATEADD(hour, 5, c.charge_date)) AS DATE)
			) biSum
		GROUP BY FORMAT(biSum.DATEPART, 'MM-yyyy')
		
		UNION ALL
		
		SELECT FORMAT(biSum.DATEPART, 'MM-yyyy') AS DATEPART,
			IIF(SUM(biSum.SUM_QTY) > 4500, (SUM(biSum.SUM_QTY) - 4500), 0) SUM_EXTRA_QTY
		FROM (
			SELECT c.RATE_GROUP RATE_GROUP,
				MIN(c.CHARGE_RATE) CHARGE_RATE,
				SUM(c.CHARGE_QTY) SUM_QTY,
				CAST(DATEADD(minute, 30, DATEADD(hour, 5, c.charge_date)) AS DATE) 'DATEPART'
			FROM BILLADMIN.BIC_CHARGE c
			INNER JOIN BILLADMIN.BIC_CHARGE_CODE CHG_CODE ON c.CHARGE_CODE = CHG_CODE.CHARGE_CODE
			WHERE c.RATE_GROUP = 'SIGERHIGHLAPTOPS'
				AND c.CHARGE_CODE = 'SINOUTHN'
				AND c.BIll_LEVEL != 'ITEMGROUP'
				AND c.DELETE_FLAG = 0
			GROUP BY c.CHARGE_CODE,
				c.CHARGE_RATE,
				c.RATE_GROUP,
				CHG_CODE.CHARGE_DESC,
				CAST(DATEADD(minute, 30, DATEADD(hour, 5, c.charge_date)) AS DATE)
			) biSum
		GROUP BY FORMAT(biSum.DATEPART, 'MM-yyyy')
		) cd
	GROUP BY cd.DATEPART
	
	UNION
	
	SELECT cd.DATEPART AS MonthYear,
		0 AS SINVAS3,
		0 AS SINVAS2,
		0 AS SINVAS4,
		0 AS SINVAS1,
		SUM(cd.SUM_EXTRA_QTY) AS SINADDHNM,
		0 AS SINADDSTM,
		0 AS SINADDSTL,
		0 AS SINDAILYCAPM,
		0 AS SINDAILYCAPL,
		0 AS SINADDHNL
	FROM (
		SELECT FORMAT(biSum.DATEPART, 'MM-yyyy') AS DATEPART,
			IIF(SUM(biSum.SUM_QTY) > 60000, (SUM(biSum.SUM_QTY) - 60000), 0) SUM_EXTRA_QTY
		FROM (
			SELECT c.RATE_GROUP RATE_GROUP,
				MIN(c.CHARGE_RATE) CHARGE_RATE,
				SUM(c.CHARGE_QTY) SUM_QTY,
				CAST(DATEADD(minute, 30, DATEADD(hour, 5, c.charge_date)) AS DATE) 'DATEPART'
			FROM BILLADMIN.BIC_CHARGE c
			INNER JOIN BILLADMIN.BIC_CHARGE_CODE CHG_CODE ON c.CHARGE_CODE = CHG_CODE.CHARGE_CODE
			WHERE c.RATE_GROUP = 'SIGERHIGHPHONE'
				AND c.CHARGE_CODE = 'SININBHN'
				AND c.BIll_LEVEL != 'ITEMGROUP'
				AND c.DELETE_FLAG = 0
			GROUP BY c.CHARGE_CODE,
				c.CHARGE_RATE,
				c.RATE_GROUP,
				CHG_CODE.CHARGE_DESC,
				CAST(DATEADD(minute, 30, DATEADD(hour, 5, c.charge_date)) AS DATE)
			) biSum
		GROUP BY FORMAT(biSum.DATEPART, 'MM-yyyy')
		
		UNION ALL
		
		SELECT FORMAT(biSum.DATEPART, 'MM-yyyy') AS DATEPART,
			IIF(SUM(biSum.SUM_QTY) > 60000, (SUM(biSum.SUM_QTY) - 60000), 0) SUM_EXTRA_QTY
		FROM (
			SELECT c.RATE_GROUP RATE_GROUP,
				MIN(c.CHARGE_RATE) CHARGE_RATE,
				SUM(c.CHARGE_QTY) SUM_QTY,
				CAST(DATEADD(minute, 30, DATEADD(hour, 5, c.charge_date)) AS DATE) 'DATEPART'
			FROM BILLADMIN.BIC_CHARGE c
			INNER JOIN BILLADMIN.BIC_CHARGE_CODE CHG_CODE ON c.CHARGE_CODE = CHG_CODE.CHARGE_CODE
			WHERE c.RATE_GROUP = 'SIGERHIGHPHONE'
				AND c.CHARGE_CODE = 'SINOUTHN'
				AND c.BIll_LEVEL != 'ITEMGROUP'
				AND c.DELETE_FLAG = 0
			GROUP BY c.CHARGE_CODE,
				c.CHARGE_RATE,
				c.RATE_GROUP,
				CHG_CODE.CHARGE_DESC,
				CAST(DATEADD(minute, 30, DATEADD(hour, 5, c.charge_date)) AS DATE)
			) biSum
		GROUP BY FORMAT(biSum.DATEPART, 'MM-yyyy')
		) cd
	GROUP BY cd.DATEPART
	) summaryUltra
GROUP BY summaryUltra.MonthYear
