--Q1 ROWS ---- A=1793
SELECT COUNT(title)
FROM data_analyst_jobs
;


--Q2 1st 10 ROWS ---- A=ExxonMobil
SELECT *
FROM data_analyst_jobs
LIMIT 10
;


--Q3a TN Postings ---- A=21
SELECT COUNT(location) AS tn_total
FROM data_analyst_jobs
WHERE location = 'TN'
;


--Q3b TN&KY Postings ---- A=27
SELECT COUNT(location) AS tn_ky_total
FROM data_analyst_jobs
WHERE location = 'TN' OR location = 'KY'
;


--Q4 TN rating >4 ---- A=3
SELECT COUNT(star_rating) AS tn_rating_over_4
FROM data_analyst_jobs
WHERE location = 'TN' AND star_rating > 4
;


--Q5 Review Count ---- A=151
SELECT COUNT(review_count) AS review_between_500_1000
FROM data_analyst_jobs
WHERE review_count BETWEEN 500 AND 1000
;


--Q6 Avg Star Rating ---- A=Nebraska
SELECT DISTINCT location AS state, ROUND(AVG(star_rating),2) AS avg_rating
FROM data_analyst_jobs
GROUP BY location
ORDER BY avg_rating DESC
;


--Q7 Unique Job Tiltes ---- A=881
SELECT COUNT(DISTINCT title) AS unique_titles
FROM data_analyst_jobs
;


--Q8 Unique Cal. Companies ---- A=230
SELECT COUNT(DISTINCT title) AS unique_job, location
FROM data_analyst_jobs
WHERE location = 'CA'
GROUP BY location
;


--Q9 5000 Review Compaines ---- A=See Below
SELECT DISTINCT company AS companies_over_5k_reviews,
	   ROUND(AVG(star_rating),2) AS avg_star_rating
FROM data_analyst_jobs
WHERE review_count >5000
GROUP BY company;
--Q9b ---- A=40 (& 1 without a company name [null])
SELECT COUNT(DISTINCT company) AS companies_over_5k_reviews, 
       ROUND(AVG(star_rating),2) AS avg_star_rating
FROM data_analyst_jobs
WHERE review_count >5000
;


-------------------LONG CUT FOR Q9----------------------------------------
SELECT DISTINCT company AS companies_over_5k_reviews,
	ROUND(AVG(CASE WHEN review_count >5000 THEN star_rating
	END),2) AS avg_star_rating
FROM data_analyst_jobs 
WHERE CASE WHEN review_count >5000 THEN star_rating
	END IS NOT null AND company IS NOT null
GROUP BY company
;

---
SELECT COUNT(DISTINCT company) AS companies_over_5k_reviews,
	ROUND(AVG(CASE WHEN review_count >5000 THEN star_rating
	END),2) AS avg_star_rating
FROM data_analyst_jobs 
WHERE CASE WHEN review_count >5000 THEN star_rating
	END IS NOT null
;
--------------------------------------------------------------	


--Q10 Highest Star Rating ---- A=American Express, 4.20
SELECT DISTINCT company AS companies_over_5k_reviews,
	   ROUND(AVG(star_rating),2) AS avg_star_rating
FROM data_analyst_jobs
WHERE review_count >5000
GROUP BY company
ORDER BY avg_star_rating DESC
;


--Q11 Analyst Job Titles ---- A=See Below
SELECT title
FROM data_analyst_jobs
WHERE title ILIKE '%Analyst%'
;
--Q11b ---- A=1669
SELECT COUNT(title) AS titles_w_analyst
FROM data_analyst_jobs
WHERE title ILIKE '%Analyst%'
;


--Q12 Titles w/o "analyst" ---- A=4
SELECT COUNT(title)
FROM data_analyst_jobs
WHERE title NOT ILIKE '%Analyst%' 
	AND title NOT ILIKE '%Analytics%'
; 
--Q12b ---- A=Tableau
SELECT title
FROM data_analyst_jobs
WHERE title NOT ILIKE '%Analyst%' 
	AND title NOT ILIKE '%Analytics%'
;


--BONUS ---- A=62,61,57,52
SELECT COUNT(title) AS hard_to_fill_jobs, domain AS industry
FROM data_analyst_jobs
WHERE skill ILIKE '%SQL%' 
	AND (days_since_posting / 7.0) > 3.0
	AND domain IS NOT null
GROUP BY domain
ORDER BY hard_to_fill_jobs DESC
LIMIT 4
;



--STATIC TABLE
SELECT *
FROM data_analyst_jobs;                                                                                                                                                                                               