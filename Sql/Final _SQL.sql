--Total Customers
SELECT COUNT(*) AS TotalCustomers
FROM Customers;

--New Customers by Year
SELECT YEAR(JoinDate) AS JoinYear, COUNT(*) AS NewCustomers
FROM Customers
GROUP BY YEAR(JoinDate)
ORDER BY JoinYear;

--Active/Inactive Customers
SELECT
 COUNT(DISTINCT CASE WHEN t.TransactionID IS NOT NULL THEN c.CustomerID END) AS
ActiveCustomers,
 COUNT(DISTINCT CASE WHEN t.TransactionID IS NULL THEN c.CustomerID END) AS
InactiveCustomers
FROM Customers c
LEFT JOIN Accounts a ON c.CustomerID = a.CustomerID
LEFT JOIN Transactions t ON a.AccountID = t.AccountID;--Total Active CustomersSELECT COUNT(DISTINCT a.CustomerID) AS Total_Active_Customers
FROM Transactions t
JOIN Accounts a ON t.AccountID = a.AccountID
WHERE t.TransactionDate >= DATEADD(MONTH, -12, '2025-05-17')

--Churn Risks
SELECT COUNT(DISTINCT c.CustomerID) AS Churn_Risk_Customers
FROM Customers c
LEFT JOIN Accounts a ON c.CustomerID = a.CustomerID
LEFT JOIN Transactions t ON a.AccountID = t.AccountID
WHERE t.TransactionID IS NULL OR t.TransactionDate < DATEADD(MONTH, -6, '2025-05-17');

--Average Accounts per Customer
SELECT CAST(COUNT(a.AccountID) AS FLOAT) / COUNT(DISTINCT a.CustomerID) AS
Avg_Accounts_Per_Customer
FROM Accounts a;

--Monthly New CustomersSELECT
 DATENAME(MONTH, JoinDate) AS MonthName,
 DATEPART(MONTH, JoinDate) AS MonthNumber,
 COUNT(DISTINCT CustomerID) AS Total_New_Customers
FROM Customers
GROUP BY DATENAME(MONTH, JoinDate), DATEPART(MONTH, JoinDate)
ORDER BY MonthNumber;

--RFM Analysis
CREATE VIEW RFM_View AS
SELECT
 c.CustomerID,
 DATEDIFF(DAY, MAX(t.TransactionDate), '2025-05-17') AS Recency,
 COUNT(DISTINCT t.TransactionID) AS Frequency,
 SUM(t.Amount) AS Monetary
FROM Customers c
LEFT JOIN Accounts a ON c.CustomerID = a.CustomerID
LEFT JOIN Transactions t ON a.AccountID = t.AccountID
GROUP BY c.CustomerID;
SELECT TOP 10 * FROM RFM_View
ORDER BY Recency ASC, Frequency DESC, Monetary DESC;

--Account & Balance Analysis
SELECT COUNT(*) AS TotalAccounts
FROM Accounts;
-- Account Type Distribution
SELECT AccountType, COUNT(*) AS AccountCount
FROM Accounts
GROUP BY AccountType
ORDER BY AccountCount DESC;

--Total Balance by Account Type
SELECT AccountType, SUM(Balance) AS TotalBalance
FROM Accounts
GROUP BY AccountType
ORDER BY TotalBalance DESC;
--Average Balance by Account Type
SELECT AccountType, AVG(Balance) AS AvgBalance
FROM Accounts
GROUP BY AccountType
ORDER BY AvgBalance DESC;

--Account Creation by YearSELECT YEAR(CreatedDate) AS CreationYear, COUNT(*) AS NewAccounts
FROM Accounts
GROUP BY YEAR(CreatedDate)
ORDER BY CreationYear; Description:
--Customer-Account Link
SELECT c.CustomerID, COUNT(a.AccountID) AS AccountCount
FROM Customers c
LEFT JOIN Accounts a ON c.CustomerID = a.CustomerID
GROUP BY c.CustomerID;
--Accounts with No Transaction
SELECT COUNT(DISTINCT a.AccountID) AS InactiveAccounts
FROM Accounts a
LEFT JOIN Transactions t ON a.AccountID = t.AccountID
WHERE t.TransactionID IS NULL;--Top 5 Accounts by BalanceSELECT TOP 5 AccountID, Balance
FROM Accounts
ORDER BY Balance DESC;--Accounts per CustomerSELECT CustomerID, COUNT(AccountID) AS AccountCount
FROM Accounts
GROUP BY CustomerID
HAVING COUNT(AccountID) > 1--Average Balance per CustomerSELECT a.CustomerID, AVG(a.Balance) AS AvgCustomerBalance
FROM Accounts a
GROUP BY a.CustomerID;-- Total TransactionsSELECT COUNT(*) AS TotalTransactions
FROM Transactions;--Transaction Type DistributionSELECT TransactionType, COUNT(*) AS TransactionCount
FROM Transactions
GROUP BY TransactionType
ORDER BY TransactionCount DESC;;--Total and Average Amount by Transaction Type
SELECT
 TransactionType,
 SUM(Amount) AS TotalAmount,
 AVG(Amount) AS AvgAmount
FROM Transactions
GROUP BY TransactionType
ORDER BY TotalAmount DESC;--Transaction Analysis by MonthSELECT
    DATEPART(YEAR, TransactionDate) AS TransactionYear,
    DATENAME(MONTH, TransactionDate) AS TransactionMonth,
    COUNT(*) AS TransactionCount,
    SUM(Amount) AS TotalAmount
FROM Transactions
GROUP BY DATEPART(YEAR, TransactionDate),DATENAME(MONTH, TransactionDate),
 DATEPART(MONTH, TransactionDate)
ORDER BY   TransactionYear,DATEPART(MONTH, TransactionDate);-- Transaction-Customer LinkSelect a.CustomerID,COUNT(t.TransactionID) AS TransactionCount,SUM(t.Amount) AS TotalTransactionAmount
FROM Transactions t
JOIN Accounts a ON t.AccountID = a.AccountID
GROUP BY a.CustomerID;--Transactions by AmountSELECT TOP 5 TransactionID, Amount, TransactionType, TransactionDate
FROM Transactions
ORDER BY Amount DESC;-- Average Transaction Value by Account TypeSELECT a.AccountType,AVG(t.Amount) AS AvgTransactionValue
FROM Transactions t
JOIN Accounts a ON t.AccountID = a.AccountID
GROUP BY a.AccountType
ORDER BY AvgTransactionValue DESC;--Top Transaction TypeSELECT TOP 1 TransactionType, COUNT(*) AS TransactionCount
FROM Transactions
GROUP BY TransactionType
ORDER BY TransactionCount DESC;-- Total LoansSELECT COUNT(*) AS TotalLoans
FROM Loans;--Loan Type DistributionSELECT LoanType, COUNT(*) AS LoanCount
FROM Loans
GROUP BY LoanType
ORDER BY LoanCount DESC;--Total Loan Amount by TypeSELECT LoanType, SUM(LoanAmount) AS TotalLoanAmount
FROM Loans
GROUP BY LoanType
ORDER BY TotalLoanAmount DESC;--Total and Average Loan Amount by TypeSELECT LoanType,SUM(LoanAmount) AS TotalLoanAmount,AVG(LoanAmount) AS AvgLoanAmount
FROM Loans
GROUP BY LoanType
ORDER BY TotalLoanAmount DESC;--Average Interest Rate per Loan TypeSELECT LoanType, AVG(InterestRate) AS AvgInterestRate
FROM Loans
GROUP BY LoanType
ORDER BY AvgInterestRate DESC;--Interest Rate AnalysisSELECT LoanType,MIN(InterestRate) AS MinInterestRate,MAX(InterestRate) AS MaxInterestRate,
 AVG(InterestRate) AS AvgInterestRate
FROM Loans
GROUP BY LoanType
ORDER BY AvgInterestRate DESC;--Loan DurationSELECT LoanID,
 DATEDIFF(MONTH, loanstartdate,loanenddate) AS LoanDurationMonths
FROM Loans
ORDER BY LoanDurationMonths DESC;--Loan Issue by YearSELECT YEAR(LoanStartDate) AS Year, COUNT(*) AS LoanCount
FROM Loans
GROUP BY YEAR(LoanStartDate)
ORDER BY Year;--Customer-Loan LinkSELECT CustomerID,COUNT(LoanID) AS LoanCount,SUM(LoanAmount) AS TotalLoanAmount
FROM Loans
GROUP BY CustomerID;--Top 5 Customers by Loan AmountSELECT TOP 5 CustomerID,SUM(LoanAmount) AS TotalLoanAmount
FROM Loans
GROUP BY CustomerID
ORDER BY TotalLoanAmount DESC;--Upcoming Loan MaturitiesSELECT LoanID,CustomerID,LoanEndDate
FROM Loans
WHERE LoanEndDate BETWEEN '2025-05-17' AND DATEADD(MONTH, 6,
'2025-05-17')
ORDER BY LoanEndDate;--Upcoming Maturity TrendsSELECT YEAR(LoanEndDate) AS MaturityYear,MONTH(LoanEndDate) AS MaturityMonth,COUNT(*) AS LoanCount
FROM Loans
WHERE LoanEndDate >= '2025-05-17'
GROUP BY YEAR(LoanEndDate), MONTH(LoanEndDate)
ORDER BY MaturityYear, MaturityMonth;--Loan Interest Rate AnalysisSELECT LoanType,AVG(LoanAmount) AS AvgLoanAmount,AVG(InterestRate) AS AvgInterestRate
FROM Loans
GROUP BY LoanType
HAVING AVG(InterestRate) > (SELECT AVG(InterestRate) FROM Loans);--Total CardsSELECT COUNT(*) AS TotalCards
FROM Cards;--Card Type DistributionSELECT CardType, COUNT(*) AS CardCount
FROM Cards
GROUP BY CardType
ORDER BY CardCount DESC;--Card Issuance Trend (Monthly)SELECT YEAR(IssuedDate) AS IssueYear,DATENAME(MONTH, IssuedDate) AS IssueMonth, 
DATEPART(MONTH, IssuedDate) AS IssueMonthNumber,
COUNT(*) AS CardCount
FROM Cards
GROUP BY YEAR(IssuedDate), DATENAME(MONTH, IssuedDate),DATEPART(MONTH, IssuedDate)
ORDER BY  IssueYear,IssueMonthNumber;--Cards Expiring by YearSELECT YEAR(ExpirationDate) AS ExpiryYear, COUNT(*) AS CardCount
FROM Cards
GROUP BY YEAR(ExpirationDate)
ORDER BY ExpiryYear;--Customer-Card LinkSELECT CustomerID, COUNT(CardID) AS CardCount
FROM Cards
GROUP BY CustomerID;--Active vs Expired CardsSELECT COUNT(CASE WHEN ExpirationDate >= '2025-05-17' THEN CardID END) ASActiveCards,
 COUNT(CASE WHEN ExpirationDate < '2025-05-17' THEN CardID END) AS
ExpiredCards
FROM Cards;--Average Cards per CustomerSELECT CAST(COUNT(CardID) AS FLOAT) / COUNT(DISTINCT
CustomerID) AS AvgCardsPerCustomer
FROM Cards;--Total Number of Support CallsSELECT COUNT(*) AS TotalSupportCalls
FROM SupportCalls;--Top Issue CategoriesSELECT IssueType, COUNT(*) AS CallCount
FROM SupportCalls
GROUP BY IssueType
ORDER BY CallCount DESC;--Calls by MonthSELECT YEAR(CallDate) AS CallYear,DATENAME(MONTH, CallDate) AS CallMonth,
 COUNT(*) AS CallCount
FROM SupportCalls
GROUP BY YEAR(CallDate), DATENAME(MONTH, CallDate)
ORDER BY CallYear, DATENAME(MONTH, CallDate);--Customer-Call LinkSELECT CustomerID,COUNT(CallID) AS CallCount
FROM SupportCalls
GROUP BY CustomerID;--Resolution Rate by Issue TypeSELECT
 IssueType,COUNT(CASE WHEN Resolved = 1 THEN CallID END) AS ResolvedCalls,
 COUNT(CallID) AS TotalCalls,CAST(COUNT(CASE WHEN Resolved = 1 THEN CallID END) AS FLOAT) /
COUNT(CallID) AS ResolutionRate
FROM SupportCalls
GROUP BY IssueType
ORDER BY ResolutionRate DESC;
--Additional Analytics--
--Customer Profitability Score
SELECT  a.CustomerID,FORMAT(SUM(t.Amount), 'N2') AS TotalTransactionAmount,
 FORMAT(SUM(l.LoanAmount * l.InterestRate / 100), 'N2') AS TotalLoanInterest,
 FORMAT((SUM(t.Amount) + SUM(l.LoanAmount * l.InterestRate / 100)), 'N2') AS ProfitabilityScore
FROM Accounts a
LEFT JOIN Transactions t ON a.AccountID = t.AccountID
LEFT JOIN Loans l ON a.CustomerID = l.CustomerID
GROUP BY a.CustomerID
ORDER BY  SUM(t.Amount) + SUM(l.LoanAmount * l.InterestRate / 100) DESC;
--Customer Risk Score
SELECT c.CustomerID,COUNT(DISTINCT l.LoanID) AS LoanCount,SUM(l.LoanAmount) AS TotalLoanAmount,
COUNT(DISTINCT sc.CallID) AS SupportCallCount,
(COUNT(DISTINCT l.LoanID) + COUNT(DISTINCT sc.CallID)) AS RiskScore
FROM Customers c
LEFT JOIN Loans l ON c.CustomerID = l.CustomerID
LEFT JOIN SupportCalls sc ON c.CustomerID = sc.CustomerID
GROUP BY c.CustomerID
ORDER BY RiskScore DESC;

--Support Risk Factor
SELECT sc.CustomerID,COUNT(sc.CallID) AS SupportCallCount,
 COUNT(CASE WHEN sc.Resolved = 0 THEN sc.CallID END) AS
UnresolvedCalls,
 CAST(COUNT(CASE WHEN sc.Resolved = 0 THEN sc.CallID END) AS FLOAT)
/ COUNT(sc.CallID) AS SupportRiskFactor
FROM SupportCalls sc
GROUP BY sc.CustomerID
HAVING COUNT(sc.CallID) > 0
ORDER BY SupportRiskFactor DESC;

--Clients Nearing Loan Repayment DeadlinesSELECT l.CustomerID,COUNT(l.LoanID) AS LoanCount,
  MIN(l.LoanEndDate) AS NearestMaturityDate
FROM Loans l
WHERE l.LoanEndDate BETWEEN '2025-05-17' AND DATEADD(MONTH, 3, '2025-05-17')
GROUP BY l.CustomerID
ORDER BY NearestMaturityDate;

--New Customers by State
SELECT c.State,
 COUNT(*) AS NewCustomerCount
FROM Customers c
WHERE c.JoinDate >= DATEADD(YEAR, -1, '2025-05-17')
GROUP BY c.State
ORDER BY NewCustomerCount DESC;

--Inactive Customers by StateSELECT c.State,COUNT(DISTINCT c.CustomerID) AS InactiveCustomerCount
FROM Customers c
LEFT JOIN Accounts a ON c.CustomerID = a.CustomerID
LEFT JOIN Transactions t ON a.AccountID = t.AccountID
WHERE t.TransactionID IS NULL
GROUP BY c.State
ORDER BY InactiveCustomerCount DESC;--Transaction Volume by StateSELECT c.State,FORMAT(COUNT(t.TransactionID), 'N0') AS TransactionCount,  
FORMAT(SUM(t.Amount), 'N2') AS TotalTransactionAmount       
FROM Customers c
JOIN Accounts a ON c.CustomerID = a.CustomerID
JOIN Transactions t ON a.AccountID = t.AccountID
GROUP BY c.State
ORDER BY COUNT(t.TransactionID) DESC;

--Issue Analysis for Inactive Customers
SELECT sc.IssueType,COUNT(sc.CallID) AS CallCount
FROM SupportCalls sc
JOIN Customers c ON sc.CustomerID = c.CustomerID
LEFT JOIN Accounts a ON c.CustomerID = a.CustomerID
LEFT JOIN Transactions t ON a.AccountID = t.AccountID
WHERE t.TransactionID IS NULL
GROUP BY sc.IssueType
ORDER BY CallCount DESC;

--Transactions Before/After Complaints
SELECT sc.CustomerID,COUNT(DISTINCT CASE WHEN t.TransactionDate < sc.CallDate THEN
t.TransactionID END) AS TransactionsBefore,
 COUNT(DISTINCT CASE WHEN t.TransactionDate >= sc.CallDate THEN
t.TransactionID END) AS TransactionsAfter
FROM SupportCalls sc
JOIN Accounts a ON sc.CustomerID = a.CustomerID
LEFT JOIN Transactions t ON a.AccountID = t.AccountID
GROUP BY sc.CustomerID;

--Days Between Call and TransactionSELECT sc.CustomerID,
MIN(DATEDIFF(DAY, sc.CallDate, t.TransactionDate)) AS MinDaysToTransaction
FROM SupportCalls sc
JOIN Accounts a ON sc.CustomerID = a.CustomerID
JOIN Transactions t ON a.AccountID = t.AccountID
WHERE t.TransactionDate >= sc.CallDate
GROUP BY sc.CustomerID
HAVING MIN(DATEDIFF(DAY, sc.CallDate, t.TransactionDate)) IS NOT NULL;------------------------------------------
--Peak Loan Years by Type and StateSELECT c.State,  YEAR(l.LoanStartDate) AS PeakYear, l.LoanType, COUNT(*) AS LoanCount
FROM Loans l
JOIN Customers c ON l.CustomerID = c.CustomerID
GROUP BY c.State, YEAR(l.LoanStartDate), l.LoanType
HAVING COUNT(*) = (
        SELECT MAX(cnt)
        FROM (
            SELECT COUNT(*) AS cnt
            FROM Loans l2
            JOIN Customers c2 ON l2.CustomerID = c2.CustomerID
            WHERE c2.State = c.State
            AND l2.LoanType = l.LoanType
            GROUP BY YEAR(l2.LoanStartDate)
        ) AS MaxCounts
    )
ORDER BY 
    c.State;
-------------------------------------------------------------------------------------------
--Distribution of Card Types by Email Domain
SELECT SUBSTRING(c.Email, CHARINDEX('@', c.Email) + 1, LEN(c.Email)) AS EmailDomain,
d.CardType,COUNT(*) AS Count
FROM Customers c
JOIN Cards d ON c.CustomerID = d.CustomerID
GROUP BY SUBSTRING(c.Email, CHARINDEX('@', c.Email) + 1, LEN(c.Email)),d.CardType
ORDER BY EmailDomain, Count DESC;

-------------------------------------------------------------------------------------------
--Analysis of customer complaints and transactions
SELECT c.CustomerID,c.FirstName + ' ' + c.LastName AS CustomerName,c.Phone,
 c.Email,MAX(sc.CallDate) AS ComplaintDate,COUNT(t.TransactionID) AS TransactionsAfterComplaint,
 MAX(t.TransactionDate) AS LastTransactionDate
FROM dbo.Customers c
JOIN dbo.SupportCalls sc ON c.CustomerID = sc.CustomerID
JOIN dbo.Accounts a ON c.CustomerID = a.CustomerID
JOIN dbo.Transactions t ON a.AccountID = t.AccountID  
WHERE 
    sc.Resolved = 0
    AND t.TransactionDate > sc.CallDate 
GROUP BY 
    c.CustomerID, c.FirstName, c.LastName, c.Phone, c.Email
ORDER BY 
    TransactionsAfterComplaint DESC, 
    LastTransactionDate DESC;

-------------------------------------------------------------------------------------------
--Comparison between number of transactions before and after the complaint
SELECT c.CustomerID,c.FirstName + ' ' + c.LastName AS CustomerName,sc.CallDate,
SUM(CASE WHEN t.TransactionDate < sc.CallDate THEN 1 ELSE 0 END) AS TransactionsBeforeComplaint,
SUM(CASE WHEN t.TransactionDate >= sc.CallDate THEN 1 ELSE 0 END) AS TransactionsAfterComplaint
FROM dbo.Customers c
JOIN dbo.SupportCalls sc ON c.CustomerID = sc.CustomerID
JOIN dbo.Accounts a ON c.CustomerID = a.CustomerID
JOIN dbo.Transactions t ON a.AccountID = t.AccountID
WHERE 
    sc.Resolved = 1
    AND sc.CallDate IS NOT NULL
GROUP BY 
    c.CustomerID, c.FirstName, c.LastName, sc.CallDate
ORDER BY 
    TransactionsAfterComplaint DESC;

-------------------------------------------------------------------------------------------
--First transaction after the complaint: How much Time taken to initiate the first transaction
SELECT c.CustomerID, c.FirstName + ' ' + c.LastName AS CustomerName, sc.IssueType,
sc.CallDate,MIN(t.TransactionDate) AS FirstTransactionAfterCall,
DATEDIFF(DAY, sc.CallDate, MIN(t.TransactionDate)) AS DaysBetweenCallAndFirstTransaction
FROM Customers c
JOIN SupportCalls sc ON c.CustomerID = sc.CustomerID
JOIN Accounts a ON c.CustomerID = a.CustomerID
JOIN Transactions t ON a.AccountID = t.AccountID
WHERE 
    sc.IssueType IN ('Card Issue', 'Transaction Dispute')
    AND t.TransactionDate > sc.CallDate                     
GROUP BY 
    c.CustomerID, c.FirstName, c.LastName, sc.IssueType, sc.CallDate
ORDER BY 
    DaysBetweenCallAndFirstTransaction desc;

-------------------------------------------------------------------------------------------
--Time Between Support Calls and Subsequent Transactions by Issue Type
SELECT sc.IssueType,
 MIN(DATEDIFF(DAY, sc.CallDate, t.TransactionDate)) AS MinDaysBetweenCallAndTransaction,
 MAX(DATEDIFF(DAY, sc.CallDate, t.TransactionDate)) AS MaxDaysBetweenCallAndTransaction
FROM Customers c
JOIN SupportCalls sc ON c.CustomerID = sc.CustomerID
JOIN Accounts a ON c.CustomerID = a.CustomerID
JOIN Transactions t ON a.AccountID = t.AccountID
WHERE t.TransactionDate > sc.CallDate
    AND t.TransactionDate = (
        SELECT MIN(t2.TransactionDate)
        FROM Accounts a2
        JOIN Transactions t2 ON a2.AccountID = t2.AccountID
        WHERE a2.CustomerID = c.CustomerID
          AND t2.TransactionDate > sc.CallDate
    )
GROUP BY sc.IssueType;
-------------------------------------------------------------------------------------------
--CustomerTenureDays
ALTER TABLE Customers
ADD CustomerTenureDays INT;

UPDATE Customers
SET CustomerTenureDays = DATEDIFF(DAY, JoinDate, GETDATE());
--ActiveCustomer
ALTER TABLE Customers
ADD sActiveCustomer VARCHAR(10) DEFAULT 'Inactive';

UPDATE c
SET c.sActiveCustomer = 
    CASE
        WHEN EXISTS (
            SELECT 1 FROM Transactions t 
            JOIN Accounts a ON t.AccountID = a.AccountID
            WHERE a.CustomerID = c.CustomerID
            AND t.TransactionDate >= DATEADD(day, -90, GETDATE())
        )
        OR EXISTS (
            SELECT 1 FROM Cards 
            WHERE CustomerID = c.CustomerID
            AND IssuedDate >= DATEADD(day, -90, GETDATE())
        )
        OR EXISTS (
            SELECT 1 FROM Loans 
            WHERE CustomerID = c.CustomerID
            AND LoanStartDate >= DATEADD(day, -90, GETDATE())
        )
        OR EXISTS (
            SELECT 1 FROM SupportCalls 
            WHERE CustomerID = c.CustomerID
            AND CallDate >= DATEADD(day, -90, GETDATE())
        )
        THEN 'Active'
        ELSE 'Inactive'
    END
FROM Customers c;

--AccountAgeDays
ALTER TABLE Accounts
ADD AccountAgeDays INT NULL;   

UPDATE Accounts
SET AccountAgeDays = DATEDIFF(DAY,CreatedDate, GETDATE());

--BalanceToAgeRatio
ALTER TABLE Accounts
ADD BalanceToAgeRatio DECIMAL(18,2);

UPDATE Accounts
SET BalanceToAgeRatio = CAST(Balance / NULLIF(DATEDIFF(DAY, CreatedDate, GETDATE()), 0) AS DECIMAL(18,2));

--IsHighValueTransaction
ALTER TABLE Transactions
ADD IsHighValueTransaction BIT NULL;

WITH RankedTransactions AS (
    SELECT 
        TransactionID,
        Amount,
        NTILE(10) OVER (PARTITION BY AccountID ORDER BY Amount DESC) AS PercentileRank
    FROM Transactions
)
UPDATE t
SET t.IsHighValueTransaction = CASE WHEN r.PercentileRank = 1 THEN 1 ELSE 0 END
FROM Transactions t
JOIN RankedTransactions r ON t.TransactionID = r.TransactionID;

--Rolling30dTxnCount
ALTER TABLE Transactions
ADD Rolling30dTxnCount INT NULL;

UPDATE t
SET t.Rolling30dTxnCount = (
    SELECT COUNT(*) 
    FROM Transactions t2 
    WHERE t2.AccountID = t.AccountID
    AND t2.TransactionDate BETWEEN DATEADD(DAY, -30, t.TransactionDate) AND t.TransactionDate
)
FROM Transactions t;

--LoanDurationDays
ALTER TABLE Loans
ADD LoanDurationDays AS DATEDIFF(DAY, loanStartDate, loanEndDate);

--LoanStatus
ALTER TABLE Loans
ADD LoanStatus AS (
    CAST(
        CASE 
            WHEN GETDATE() < loanStartDate THEN 'Upcoming'
            WHEN GETDATE() BETWEEN loanStartDate AND loanEndDate THEN 'Active'
            WHEN GETDATE() > loanEndDate THEN 'Closed'
        END AS VARCHAR(20)
    )
);
--DaysUntilExpiry
ALTER TABLE Cards
ADD DaysUntilExpiry AS (CAST(DATEDIFF(DAY, GETDATE(), ExpirationDate) AS INT));

--DaysToResolve
ALTER TABLE Cards
ADD IsExpired AS (CASE WHEN GETDATE() > ExpirationDate THEN 1 ELSE 0 END);



