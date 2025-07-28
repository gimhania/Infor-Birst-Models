SELECT SUBSTRING(CAST(summary.charge_date AS VARCHAR), 1, 7) AS MonthYear,
	SUM(summary.total_charge_qty_SINVAS3) AS SINVAS3,
	SUM(summary.total_charge_qty_SINVAS2) AS SINVAS2,
	SUM(summary.total_charge_qty_SINVAS4) AS SINVAS4,
	SUM(summary.total_charge_qty_SINVAS1) AS SINVAS1,
	SUM(summary.total_charge_qty_SINADDHNM) AS SINADDHNM,
	SUM(summary.total_charge_qty_SINADDSTM) AS SINADDSTM,
	SUM(summary.total_charge_qty_SINADDSTL) AS SINADDSTL,
	SUM(summary.total_charge_qty_SINDAILYCAPM) AS SINDAILYCAPM,
	SUM(summary.total_charge_qty_SINDAILYCAPL) AS SINDAILYCAPL,
	SUM(summary.total_charge_qty_SINADDHNL) AS SINADDHNL
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
		0 AS total_charge_qty_SINADDHNL
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
		0 AS total_charge_qty_SINADDHNL
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
		0 AS total_charge_qty_SINADDHNL
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
		0 AS total_charge_qty_SINADDHNL
	FROM BILLADMIN.BIC_CHARGE
	WHERE charge_code = 'SINVAS1'
		AND cust_code = 'SINGERHIGH'
	GROUP BY CAST(DATEADD(minute, 30, DATEADD(hour, 5, charge_date)) AS DATE)
	
	UNION ALL
	
	SELECT AdhMob.DATEPART AS charge_date,
		0 AS total_charge_qty_SINVAS3,
		0 AS total_charge_qty_SINVAS2,
		0 AS total_charge_qty_SINVAS4,
		0 AS total_charge_qty_SINVAS1,
		SUM(AdhMob.SUM_QTY) AS total_charge_qty_SINADDHNM,
		0 AS total_charge_qty_SINADDSTM,
		0 AS total_charge_qty_SINADDSTL,
		0 AS total_charge_qty_SINDAILYCAPM,
		0 AS total_charge_qty_SINDAILYCAPL,
		0 AS total_charge_qty_SINADDHNL
	FROM (
		--======== 1 SIGERHIGHPHONE (Additional Handling - Mobile Phones (Inbound))===================Monthly
		SELECT 3 'GroupChargeId',
			'SIN-ADDHN-M' 'GroupChargeCode',
			1 'GroupId',
			c.CHARGE_CODE,
			'Additional Handling Inbound - Mobile Phones' CHARGE_DESC,
			c.RATE_GROUP RATE_GROUP,
			MIN(c.CHARGE_RATE) CHARGE_RATE,
			SUM(c.CHARGE_QTY) SUM_QTY,
			IIF(SUM(c.CHARGE_QTY) > 60000, (SUM(c.CHARGE_QTY) - 60000), 0) SUM_EXTRA_QTY,
			CAST(DATEADD(minute, 30, DATEADD(hour, 5, charge_date)) AS DATE) AS 'DATEPART'
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
			CAST(DATEADD(minute, 30, DATEADD(hour, 5, charge_date)) AS DATE)
		
		UNION
		
		--======== 2 SIGERHIGHPHONE (Additional Handling - Mobile Phones (Outbound))===================Monthly
		SELECT 3 'GroupChargeId',
			'SIN-ADDHN-M' 'GroupChargeCode',
			2 'GroupId',
			c.CHARGE_CODE,
			'Additional Handling Outbound - Mobile Phones' CHARGE_DESC,
			c.RATE_GROUP RATE_GROUP,
			MIN(c.CHARGE_RATE) CHARGE_RATE,
			SUM(c.CHARGE_QTY) SUM_QTY,
			IIF(SUM(c.CHARGE_QTY) > 60000, (SUM(c.CHARGE_QTY) - 60000), 0) SUM_EXTRA_QTY,
			CAST(DATEADD(minute, 30, DATEADD(hour, 5, charge_date)) AS DATE) AS 'DATEPART'
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
			CAST(DATEADD(minute, 30, DATEADD(hour, 5, charge_date)) AS DATE)
		) AdhMob
	GROUP BY AdhMob.DATEPART
	
	UNION ALL
	
	--======== 5 Additional Storage - Mobile Phones=====================================================Daily
	SELECT CAST(DATEADD(minute, 30, DATEADD(hour, 5, cd.charge_date)) AS DATE) AS charge_date,
		0 AS total_charge_qty_SINVAS3,
		0 AS total_charge_qty_SINVAS2,
		0 AS total_charge_qty_SINVAS4,
		0 AS total_charge_qty_SINVAS1,
		0 AS total_charge_qty_SINADDHNM,
		SUM(cd.SUM_QTY) AS total_charge_qty_SINADDSTM,
		0 AS total_charge_qty_SINADDSTL,
		0 AS total_charge_qty_SINDAILYCAPM,
		0 AS total_charge_qty_SINDAILYCAPL,
		0 AS total_charge_qty_SINADDHNL
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
		SUM(cd.SUM_QTY) AS total_charge_qty_SINADDSTL,
		0 AS total_charge_qty_SINDAILYCAPM,
		0 AS total_charge_qty_SINDAILYCAPL,
		0 AS total_charge_qty_SINADDHNL
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
		SUM(cd.SUM_QTY) AS total_charge_qty_SINDAILYCAPM,
		0 AS total_charge_qty_SINDAILYCAPL,
		0 AS total_charge_qty_SINADDHNL
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
		SUM(cd.SUM_QTY) AS total_charge_qty_SINDAILYCAPL,
		0 AS total_charge_qty_SINADDHNL
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
	
	UNION ALL
	
	SELECT AdhLap.DATEPART AS charge_date,
		0 AS total_charge_qty_SINVAS3,
		0 AS total_charge_qty_SINVAS2,
		0 AS total_charge_qty_SINVAS4,
		0 AS total_charge_qty_SINVAS1,
		0 AS total_charge_qty_SINADDHNM,
		0 AS total_charge_qty_SINADDSTM,
		0 AS total_charge_qty_SINADDSTL,
		0 AS total_charge_qty_SINDAILYCAPM,
		0 AS total_charge_qty_SINDAILYCAPL,
		SUM(AdhLap.SUM_QTY) AS total_charge_qty_SINADDHNL
	FROM (
		--======== 3 SIGERHIGHLAPTOPS Additional Handling - Laptops/Computers  (Inbound)====================Monthly
		SELECT 2 'GroupChargeId',
			'SIN-ADDHN-L' 'GroupChargeCode',
			3 'GroupId',
			c.CHARGE_CODE,
			'Additional Handling Inbound - Laptops/Computers' CHARGE_DESC,
			c.RATE_GROUP RATE_GROUP,
			MIN(c.CHARGE_RATE) CHARGE_RATE,
			SUM(c.CHARGE_QTY) SUM_QTY,
			IIF(SUM(c.CHARGE_QTY) > 4500, (SUM(c.CHARGE_QTY) - 4500), 0) SUM_EXTRA_QTY,
			CAST(DATEADD(minute, 30, DATEADD(hour, 5, charge_date)) AS DATE) AS 'DATEPART'
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
			CAST(DATEADD(minute, 30, DATEADD(hour, 5, charge_date)) AS DATE)
		
		UNION
		
		--======== 4 SIGERHIGHLAPTOPS Additional Handling - Laptops/Computers  (Outbound)===================Monthly
		SELECT 2 'GroupChargeId',
			'SIN-ADDHN-L' 'GroupChargeCode',
			4 'GroupId',
			c.CHARGE_CODE,
			'Additional Handling Outbound - Laptops/Computers' CHARGE_DESC,
			c.RATE_GROUP RATE_GROUP,
			MIN(c.CHARGE_RATE) CHARGE_RATE,
			SUM(c.CHARGE_QTY) SUM_QTY,
			IIF(SUM(c.CHARGE_QTY) > 4500, (SUM(c.CHARGE_QTY) - 4500), 0) SUM_EXTRA_QTY,
			CAST(DATEADD(minute, 30, DATEADD(hour, 5, charge_date)) AS DATE) AS 'DATEPART'
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
			CAST(DATEADD(minute, 30, DATEADD(hour, 5, charge_date)) AS DATE)
		) AdhLap
	GROUP BY AdhLap.DATEPART
	) summary
GROUP BY SUBSTRING(CAST(summary.charge_date AS VARCHAR), 1, 7)