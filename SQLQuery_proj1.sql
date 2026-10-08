

USE Flat_resale

-- Bang  từ 2010 -> tháng 1 năm 2022
SELECT *
From Flat_Resale_2010

SELECT distinct 
DATEPART(YEAR,[_Date]) as _Year,
COUNT(_Date) as Total_Transactions
From Flat_resale_2010
GROUP by DATEPART(YEAR,[_Date])
ORDER BY COUNT(_Date) DESC

SELECT Top 10
_Town,
COUNT(_Date) as Transactions_of_Towns
From Flat_Resale_2010
GROUP by _Town
Order BY COUNT(_Date) DESC

SELECT Top 10
_StreetNname,
COUNT(_Date) as Transactions_by_Streetname
From Flat_Resale_2010
GROUP by _StreetNname
Order BY COUNT(_Date) DESC

SELECT
_ComplexType,
COUNT(_Date) as Transactions_by_ComplexType
FROM (
SELECT *, 
CASE 
    when _LeaseCommenceDate < 2000 then 'Old'
    Else 'New'
end as _ComplexType
From Flat_Resale_2010) as ComplexType
GROUP BY _ComplexType

SELECT
_FlatCategory,
COUNT(_Date) as Transactions_by_FlatCategory,
SUM(_ResalePrice) as PriceforEachCate
FROM 
(
SELECT *, 
CASE 
    when _ResalePrice < 300000 then 'Affordable'
    when 300000 <= _ResalePrice and _ResalePrice < 650000   then 'Standard'
    when 650000 <= _ResalePrice and _ResalePrice < 1000000   then 'Luxury'
    Else 'Grand Luxury'
end as _FlatCategory,
CASE 
    when _LeaseCommenceDate < 2000 then 'Old'
    Else 'New'
end as _ComplexType
From Flat_Resale_2010
) as FlatCategory
GROUP by _FlatCategory 

SELECT distinct _StoreysRange,
COUNT(_Date) as Transactions_by_Floor
From Flat_Resale_2010
GROUP BY _StoreysRange
ORDER by _StoreysRange ASC 

SELECT _RangeSummary,
COUNT(_Date) as  Transactions_by_RangeSummary
From
(
SELECT *, 
CASE 
    when _StoreysRange = '01 TO 03' OR _StoreysRange ='01 TO 05' OR _StoreysRange = '04 TO 06' OR _StoreysRange = '06 TO 10' OR _StoreysRange = '07 TO 09' OR _StoreysRange = '10 TO 12' OR _StoreysRange = '11 TO 15' OR _StoreysRange = '13 TO 15'THEN 'FROM 01 TO 15 FLOOR'
    WHEN _StoreysRange = '16 TO 18' OR _StoreysRange = '16 TO 20' OR _StoreysRange = ' 19 TO 21' OR _StoreysRange = '21 TO 25' OR _StoreysRange = '22 TO 24' THEN 'FROM 16 TO 25 FLOOR'
    WHEN _StoreysRange = '25 TO 27' OR _StoreysRange = '26 TO 30' OR _StoreysRange = '28 TO 30' OR _StoreysRange = '31 TO 33' OR _StoreysRange = '31 TO 35' OR _StoreysRange = '34 TO 36' THEN 'FROM 25 TO 36 FLOOR'
    ELSE 'FROM ABOVE 36 FLOOR'
END AS _RangeSummary
From Flat_Resale_2010) as A
GROUP by _RangeSummary
ORDER by _RangeSummary ASC


-- Bang  từ 2015 -> tháng 1 năm 2022

SELECT *, 
CASE 
    when _RemainingLease < 50 then 'Short'
    When _RemainingLease > 70 then 'Long'
    Else 'Medium'
end as _Duration
From Flat_resale_2015
Where DATEPART(YEAR, _Date) = 2021

SELECT 
_Duration,
COUNT(_Date) AS 'Số giao dịch'
FROM 
(
SELECT *, 
CASE 
    when _RemainingLease < 50 then 'Short'
    When _RemainingLease > 70 then 'Long'
    Else 'Medium'
end as _Duration
From Flat_resale_2015
-- Where DATEPART(YEAR, _Date) = 2016
) as A
GROUP BY _Duration

SELECT 
_RemainingLease,
COUNT(_Date)
From Flat_resale_2015
GROUP BY _RemainingLease
order by COUNT(_Date) DESC