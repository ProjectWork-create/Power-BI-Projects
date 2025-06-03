--KPI’s:

--Total Loan Applications:

SELECT COUNT(id) AS [Total Loan Applications] FROM dbo.financial_loan;

-- MTD Loan Application: 

SELECT COUNT(id) AS [MTD_Total Application] FROM financial_loan
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021;


-- Previous MTD Loan Application:

SELECT COUNT(id) AS [PMTD_Total Application] FROM financial_loan
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021;


--- Total Funded Loan Amount:

SELECT SUM(loan_amount) as [Total Funded Amount] from financial_loan


-- Total MTD Funded Loan Amount:
SELECT SUM(loan_amount) as [MTD Total Funded Amount] from financial_loan
where MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021;


-- Total Previous MTD Funded Loan Amount:
SELECT SUM(loan_amount) as [PMTD Total Funded Amount] from financial_loan
where MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021;

--- Total Amount Received:

SELECT SUM(total_payment) AS [Total Amount Recived] FROM financial_loan

--- Total MTD Amount Received:

SELECT SUM(total_payment) AS [MTD Total Amount Recived] FROM financial_loan
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) =2021;


--Total PMTD Amount Received:

SELECT SUM(total_payment) AS [PMTD Total Amount Recived] FROM financial_loan
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) =2021;

--- Average Intest Rate:

SELECT AVG(int_rate)*100 AS [Average Interest Rate] FROM financial_loan;

--- MTD Average Intest Rate:

SELECT AVG(int_rate)*100 AS [MTD Average Interest Rate] FROM financial_loan
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021;

-- PMTD Average Intest Rate:

SELECT AVG(int_rate)*100 AS [PMTD Average Interest Rate] FROM financial_loan
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021;

-- Avg DTI
SELECT AVG(dti)*100 AS [Average DTI] FROM financial_loan;

--MTD Avg DTI
SELECT AVG(dti)*100 AS [MTD Average DTI]FROM financial_loan
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021;

---PMTD Avg DTI
SELECT ROUND(AVG(dti)*100,2) AS [PMTD Average DTI]FROM financial_loan
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021;

--- Good Loan Percentage:

SELECT 
		(COUNT(CASE WHEN loan_status = 'Fully Paid' or loan_status = 'Current'
			THEN id END )*100)/
				COUNT(id)  AS [Good Loan Percentage]
from financial_loan;


--- Good Loan Appliaction

SELECT COUNT(id) AS [Good Loan Apllication]from financial_loan
WHERE loan_status = 'Fully Paid' or loan_status = 'Current';


--- Good Loan Funded Amount

SELECT SUM(loan_amount) AS [Good Loan Funded Amount]from financial_loan
WHERE loan_status = 'Fully Paid' or loan_status = 'Current';


--Good Loan Amount Received

SELECT SUM(total_payment) AS [Good Loan Funded Amount]from financial_loan
WHERE loan_status = 'Fully Paid' or loan_status = 'Current';

--- Bad Loan Percentage:

SELECT 
		(COUNT(CASE WHEN loan_status = 'Charged off' 
			THEN id END )*100)/
				COUNT(id)  AS [Bad Loan Percentage]
from financial_loan;

--- Bad Loan Application

SELECT COUNT(id) AS [Bad Loan Application]from financial_loan
WHERE loan_status = 'Charged Off';

--- Bad Loan Funded Amount

SELECT SUM(loan_amount) AS [Bad Loan Funded Amount]from financial_loan
WHERE loan_status = 'Charged Off';

--- Bad Loan Amount Received

SELECT SUM(total_payment) AS [Bad Loan Funded Received]from financial_loan
WHERE loan_status = 'Charged Off';

--- Loan Status:

SELECT loan_status,
	COUNT(id) AS Total_Loan_Application,
	SUM(total_payment) AS Total_Amount_Received,
	Sum(loan_amount) AS Total_Amount_Funded,
	AVG(int_rate * 100) AS Interest_Rate,
	AVG(dti * 100) AS DTI	
FROM financial_loan
GROUP BY loan_status;

--- MTD Received Amount

SELECT 
	loan_status, 
	SUM(total_payment) AS MTD_Total_Amount_Received, 
	SUM(loan_amount) AS MTD_Total_Funded_Amount 
FROM financial_loan
WHERE MONTH(issue_date) = 12 
GROUP BY loan_status

--- PMTD Received Amount
SELECT 
	loan_status, 
	SUM(total_payment) AS MTD_Total_Amount_Received, 
	SUM(loan_amount) AS MTD_Total_Funded_Amount 
FROM financial_loan
WHERE MONTH(issue_date) = 11
GROUP BY loan_status

---BANK LOAN REPORT | OVERVIEW
-- MONTH
SELECT 
	MONTH(issue_date) AS Month_Munber, 
	DATENAME(MONTH, issue_date) AS Month_name, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM financial_loan
GROUP BY MONTH(issue_date), DATENAME(MONTH, issue_date)
ORDER BY MONTH(issue_date);

--STATE
SELECT 
	address_state AS State, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM financial_loan
GROUP BY address_state
ORDER BY address_state

--TERM
SELECT 
	term AS Term, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM financial_loan
GROUP BY term
ORDER BY term


--- EMPLOYEE LENGTH
SELECT 
	emp_length AS Employee_Length, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM financial_loan
GROUP BY emp_length
ORDER BY emp_length


---PURPOSE
SELECT 
	purpose AS PURPOSE, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM financial_loan
GROUP BY purpose
ORDER BY purpose;


---HOME OWNERSHIP
SELECT 
	home_ownership AS Home_Ownership, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM financial_loan
GROUP BY home_ownership
ORDER BY home_ownership;

--Grade A in the filters for dashboards.
SELECT 
	purpose AS PURPOSE, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM financial_loan
WHERE grade = 'A'
GROUP BY purpose
ORDER BY purpose












