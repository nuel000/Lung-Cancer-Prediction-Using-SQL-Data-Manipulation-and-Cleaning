--ABOUT THE DATASET

--Total no. of attributes:16 
--Attribute information: 
--1. Gender: M(male), F(female) 
--2. Age: Age of the patient 
--3. Smoking: YES=2 , NO=1. 
--4. Yellow fingers: YES=2 , NO=1. 
--5. Anxiety: YES=2 , NO=1. 
--6. Peer_pressure: YES=2 , NO=1. 
--7. Chronic Disease: YES=2 , NO=1. 
--8. Fatigue: YES=2 , NO=1. 
--9. Allergy: YES=2 , NO=1. 
--10. Wheezing: YES=2 , NO=1. 
--11. Alcohol: YES=2 , NO=1. 
--12. Coughing: YES=2 , NO=1. 
--13. Shortness of Breath: YES=2 , NO=1. 
--14. Swallowing Difficulty: YES=2 , NO=1. 
--15. Chest pain: YES=2 , NO=1. 
--16. Lung Cancer: YES , NO.


--Exploring the dateset


SELECT *
FROM cancer

-- Answer some questions to gain insights
--Q1. we want to determine the average age of men diagnose with lung cancer

SELECT AVG(AGE), GENDER
FROM cancer
WHERE GENDER='M' AND LUNG_CANCER = 'YES'

--When I ran the first quuery, I got the following error "Msg 8117, Level 16, State 1, Line 13
--Operand data type varchar is invalid for avg operator." So I need to Convert the datatype to int

SELECT GENDER,AVG(CAST (AGE AS int)) AS Average_men_with_Lung_Cancer
FROM cancer
WHERE GENDER='M' AND LUNG_CANCER = 'YES'
GROUP BY GENDER
--Average Age of men diagnosed with Lung Cancer is 63 years old

--Lets do same for women
SELECT GENDER,AVG(CAST (AGE AS int)) AS Average_women_with_Lung_Cancer
FROM cancer
WHERE GENDER='F' AND LUNG_CANCER = 'YES'
GROUP BY GENDER

--Average Age of men diagnosed with Lung Cancer is 62 years old



--Q2. What Percentage of individuals diagnosed with Lung Cancer are smokers?

SELECT A.somkers_lung_cancer, A.total_lung_cancer, ROUND( CAST(A.somkers_lung_cancer AS float)/ CAST(A.total_lung_cancer AS float), 3)*100 as percentage_smokers_with_LC


FROM

(SELECT
	(SELECT COUNT(SMOKING)
	FROM cancer
	WHERE SMOKING = 2 AND LUNG_CANCER ='YES') AS somkers_lung_cancer,

	(SELECT COUNT(LUNG_CANCER)
	FROM cancer
	WHERE  LUNG_CANCER ='YES') AS total_lung_cancer
)A

--from our query 57% of individuals diagnosed with Lung Cancer are smokers

--Q3: Determine The Age	of the youngest and Oldest smokers in the group

SELECT MIN(AGE) youngest_alc,MAX(AGE) oldest_alc
FROM cancer
WHERE [ALCOHOL CONSUMING] = 2
GROUP BY [ALCOHOL CONSUMING]
--The youngest is 39 and the oldest is 81 years old

--Q4: How many Men and How many Women has lung Cancer from the group?

SELECT COUNT(GENDER) Men_with_LC
FROM cancer
WHERE GENDER='M' AND LUNG_CANCER='YES'

SELECT COUNT(GENDER) Women_with_LC
FROM cancer
WHERE GENDER='F' AND LUNG_CANCER='YES'

--there are 145 men with lung cancer and 125 Women with Lung Cancer


--Q5: Lets determined who smokes more between men and women

SELECT COUNT(GENDER) men_smokers
FROM cancer
WHERE GENDER='M' AND SMOKING= 2

SELECT COUNT(GENDER) Women_smokers
FROM cancer
WHERE GENDER='F' AND SMOKING= 2

--so from the dataset we have 94 male smokers and 80 female smokers

--Since we already deduced that more men are diagnosed with Lung cancer than women, its most likely that smoking is a key factor that causes lung Cancer

--Finally lets determine the Key factors that can predict that somene will likely be diagnosed with lung cancer

--First we create a table of all individuals diagnosed with cancer, then we look at the count of each feature to determine which factors have the highest counts

SELECT SUM (CASE B.SMOKING WHEN 2 THEN 1
			ELSE 0
			END) Smokers_LC,
			SUM (CASE B.YELLOW_FINGERS WHEN 2 THEN 1
			ELSE 0
			END) Yellow_Fingers_LC,
			SUM (CASE B.ANXIETY WHEN 2 THEN 1
			ELSE 0
			END) Anxiety_LC,
			SUM (CASE B.PEER_PRESSURE WHEN 2 THEN 1
			ELSE 0
			END) Peer_Pressure_LC,
			SUM (CASE B.[CHRONIC DISEASE] WHEN 2 THEN 1
			ELSE 0
			END) Chronic_LC,
			SUM (CASE B.[FATIGUE ] WHEN 2 THEN 1
			ELSE 0
			END) Fatigued_LC,
			SUM (CASE B.[ALLERGY ] WHEN 2 THEN 1
			ELSE 0
			END) Allergy_LC,
			SUM (CASE B.WHEEZING WHEN 2 THEN 1
			ELSE 0
			END) Wheezing_LC,
			SUM (CASE B.[ALCOHOL CONSUMING] WHEN 2 THEN 1
			ELSE 0
			END) Alcohol_LC,
			SUM (CASE B.COUGHING WHEN 2 THEN 1
			ELSE 0
			END) Coughing_LC,
			SUM (CASE B.[SHORTNESS OF BREATH] WHEN 2 THEN 1
			ELSE 0
			END) Short_breathe_LC,
			SUM (CASE B.[SWALLOWING DIFFICULTY] WHEN 2 THEN 1
			ELSE 0
			END) Swallowing_Dificulty_LC,
			SUM (CASE B.[CHEST PAIN] WHEN 2 THEN 1
			ELSE 0
			END) Chest_pain_LC

FROM (SELECT *
FROM cancer
WHERE LUNG_CANCER='YES') AS B

--From this Query, we can easily deduce that

--1. A patience is likely to be diagnosed of Lung cancer if they complain of the following: Fatigue, Shortness of breathe, and Coughing
-- As these are the Highest counts of symtoms present amonng Pateints diagnosed with Lung Cancer


--.........THANKS FOR READING





