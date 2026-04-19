DROP TABLE sales_pipeline;
DROP TABLE accounts;
DROP TABLE sales_teams;
DROP TABLE products;


-- 1. Məhsullar cədvəli
CREATE TABLE products (
    product VARCHAR(255) PRIMARY KEY,
    series VARCHAR(100),
    sales_price INT
);

-- 2. Satış komandası cədvəli
CREATE TABLE sales_teams (
    sales_agent VARCHAR(255) PRIMARY KEY,
    manager VARCHAR(255),
    regional_office VARCHAR(100)
);

-- 3. Şirkətlər (Hesablar) cədvəli
CREATE TABLE accounts (
    account VARCHAR(255) PRIMARY KEY,
    sector VARCHAR(100),
    year_established INT,
    revenue DECIMAL(15, 2),
    employees INT,
    office_location VARCHAR(100),
    subsidiary_of VARCHAR(255)
);

-- 4. Satış prosesi (Əsas cədvəl - hər kəslə əlaqəlidir)
CREATE TABLE sales_pipeline (
    opportunity_id VARCHAR(50) PRIMARY KEY,
    sales_agent    VARCHAR(255), -- REFERENCES silindi
    product        VARCHAR(255), -- REFERENCES silindi
    account        VARCHAR(255), -- REFERENCES silindi
    deal_stage     VARCHAR(50),
    engage_date    DATE,
    close_date     DATE,
    close_value    NUMBER
);


select * from accounts;
select * from products;
select * from sales_pipeline;
select * from sales_teams;


--1. Satış Komandalarının Müqayisəli Performansı
-- Hansı komanda liderdir, hansı region daha gəlirlidir?


SELECT 
    t.manager, 
    t.regional_office,
    SUM(p.close_value) AS total_revenue,
    COUNT(p.opportunity_id) AS total_deals,
    ROUND(AVG(p.close_value), 2) AS avg_deal_value
FROM sales_pipeline p
JOIN sales_teams t ON p.sales_agent = t.sales_agent
WHERE p.deal_stage = 'Won'
GROUP BY t.manager, t.regional_office
ORDER BY total_revenue DESC;

--2. Geri Qalan (Lagging) Satış Agentlərinin Tapılması
-- Kimlərin təlimə ehtiyacı var və ya kimlər satış hədəflərindən çox geri qalır?

SELECT 
    sales_agent,
    COUNT(opportunity_id) AS total_attempts,
    SUM(CASE WHEN deal_stage = 'Won' THEN 1 ELSE 0 END) AS won_deals,
    ROUND(SUM(CASE WHEN deal_stage = 'Won' THEN 1 ELSE 0 END) * 100.0 / COUNT(opportunity_id), 2) AS win_rate_percent,
    SUM(close_value) AS total_revenue
FROM sales_pipeline
GROUP BY sales_agent
HAVING COUNT(opportunity_id) > 5 
ORDER BY total_revenue ASC;

--3. Rüblük (Quarter-over-Quarter) Trendlər
-- Satışlarda mövsümilik varmı? Hansı rübdə artım və ya azalma müşahidə olunur?

SELECT 
    TO_CHAR(close_date, 'YYYY') AS sales_year,
    TO_CHAR(close_date, 'Q') AS sales_quarter,
    SUM(close_value) AS revenue,
    COUNT(opportunity_id) AS deals_closed
FROM sales_pipeline
WHERE deal_stage = 'Won'
GROUP BY TO_CHAR(close_date, 'YYYY'), TO_CHAR(close_date, 'Q')
ORDER BY sales_year, sales_quarter;

--4. Məhsulların Qazanma Faizi (Product Win Rates)
-- Hansı məhsullar bazar tərəfindən daha çox bəyənilir? Zəif məhsullar üçün qiymət və ya marketinq dəyişikliyi lazımdırmı?

SELECT 
    product,
    COUNT(*) AS total_opportunities,
    SUM(CASE WHEN deal_stage = 'Won' THEN 1 ELSE 0 END) AS won_count,
    ROUND(SUM(CASE WHEN deal_stage = 'Won' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS win_rate
FROM sales_pipeline
WHERE deal_stage IN ('Won', 'Lost') 
GROUP BY product
ORDER BY win_rate DESC;

--5. Hər Agent üçün Orta Bağlanma Müddəti (Avg Week to Close)


SELECT 
    sales_agent,
    ROUND(AVG(close_date - engage_date) / 7.0, 1) AS avg_weeks_to_close
FROM sales_pipeline
WHERE deal_stage = 'Won'
GROUP BY sales_agent
ORDER BY avg_weeks_to_close ASC;

--6. Agentlərin Aylıq Satış Performansı


SELECT 
    sales_agent,
    TO_CHAR(close_date, 'Month') AS sales_month,
    SUM(close_value) AS monthly_revenue,
    COUNT(opportunity_id) AS deals_won
FROM sales_pipeline
WHERE deal_stage = 'Won'
GROUP BY sales_agent, TO_CHAR(close_date, 'Month')
ORDER BY sales_month DESC, monthly_revenue DESC;

--7. Bağlanma Potensialı (Potential to Close)

SELECT 
    sp.sales_agent,
    COUNT(sp.opportunity_id) AS open_deals_count,
    SUM(COALESCE(NULLIF(sp.close_value, 0), p.sales_price)) AS potential_to_close_revenue
FROM sales_pipeline sp
LEFT JOIN products p ON sp.product = p.product
WHERE sp.deal_stage NOT IN ('Won', 'Lost') AND sp.engage_date >= '01.10.2016' 
    AND sp.engage_date <= '31.12.2017'
    AND EXTRACT(YEAR FROM sp.engage_date) = 2017
GROUP BY sp.sales_agent
ORDER BY potential_to_close_revenue DESC;


