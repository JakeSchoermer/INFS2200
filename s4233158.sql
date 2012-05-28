/*Task 1a*/
SELECT * FROM ALL_CONSTRAINTS WHERE TABLE_NAME='EMP';

/*Task 1b*/
ALTER TABLE DEPT ADD CONSTRAINT UN_DNAME UNIQUE(DEPT.DNAME);
ALTER TABLE PURCHASE MODIFY Amount NUMBER(4) NOT NULL;
ALTER TABLE EMP MODIFY EName VARCHAR2(20) NOT NULL;
ALTER TABLE DEPT MODIFY DName VARCHAR2(20) NOT NULL;
ALTER TABLE CLIENT MODIFY CName VARCHAR2(20) NOT NULL;
ALTER TABLE PURCHASE MODIFY ReceiptNo NUMBER(6) NOT NULL;
ALTER TABLE PURCHASE ADD CONSTRAINT CK_SERVICETYPE
CHECK (
	(ServiceType = 'Training') OR
	(ServiceType = 'Data Recovery') OR
	(ServiceType = 'Consultation') OR
	(ServiceType = 'Software Installation') OR
	(ServiceType = 'Software Repair')
);
ALTER TABLE PURCHASE ADD CONSTRAINT CK_PAYMENTTYPE
CHECK (
	(PaymentType = 'Debit') OR
	(PaymentType = 'Cash') OR
	(PaymentType = 'Credit') 
);
ALTER TABLE PURCHASE ADD CONSTRAINT CK_GST
CHECK (
	(GST = 'Yes') OR
	(GST = 'No')
);
ALTER TABLE EMP ADD CONSTRAINT FK_DEPTNO FOREIGN KEY (DEPTNO) REFERENCES
DEPT(DeptNo);
ALTER TABLE PURCHASE ADD CONSTRAINT FK_EMPNO FOREIGN KEY (ServedBy) REFERENCES
EMP(EMPNO);
ALTER TABLE PURCHASE ADD CONSTRAINT FK_CLIENTNO FOREIGN KEY (ClientNo) REFERENCES
CLIENT(ClientNo);

/*----------------- Task 2a -------------------*/

/* Write an SQL Statement to fin the company's top client. A top client the one
 * who has purchased the most (i.e. the one with the highest total purchase
 * amount (in dollars) among all the company's clients).
 *
 * Your statement should display: client number, client name, and the total
 * purchase amount by that client.
 */

SELECT CLIENT.CLIENTNO, CLIENT.CNAME, SUM(PURCHASE.AMOUNT) AS AMOUNT
FROM CLIENT
INNER JOIN PURCHASE
ON CLIENT.CLIENTNO = PURCHASE.CLIENTNO
WHERE CLIENT.CLIENTNO IN (
	SELECT CLIENTNO
	FROM (
		SELECT PURCHASE.CLIENTNO, SUM(PURCHASE.AMOUNT) AS AMOUNT
		FROM PURCHASE
		GROUP BY PURCHASE.CLIENTNO
		ORDER BY AMOUNT DESC
	)
WHERE ROWNUM = 1)
GROUP BY CLIENT.CLIENTNO, CLIENT.CNAME;

/*---------------- Task 2b --------------------*/


/* Write a SQL statement to create an Oracle trigger that applies a 15% discount to
 * any future purchases made by the top client found in Task 2a.
 * 
 * Hint: Your trigger should use the value obtained from Task 2a. In particular,
 * it should apply a 15% reduction to the purchase amount whenever a new purchase
 * made by that top client is inserted into the PURCHASE table.
 */


/*---------------- Task 3a ---------------------*/

/* Write a SQL statement to create a (regular) view called V_DEPT_AMOUNT that 
 * lists the names  and  numbers of all the company departments together with the 
 * maximum, minimum, average, and total purchase amount contributed by each of 
 * those departments. 
 */

CREATE VIEW V_DEPT_AMOUNT AS
SELECT EMP.DEPTNO, MAX(PURCHASE.AMOUNT) AS MAX_AMOUNT,
MIN(PURCHASE.AMOUNT) AS MIN_AMOUNT, AVG(PURCHASE.AMOUNT) AS AVG_AMOUNT,
DEPT.DNAME
FROM EMP
INNER JOIN PURCHASE
ON EMP.EMPNO = PURCHASE.SERVEDBY
INNER JOIN DEPT
ON EMP.DEPTNO = DEPT.DEPTNO
GROUP BY EMP.DEPTNO, DEPT.DNAME
ORDER BY EMP.DEPTNO;

/*-------------------------- Task 3b -----------------------*/

/* Write a SQL statement to create a materialized view called MV_DEPT_AMOUNT
 * that lists the same information as in Task 3a
 */

CREATE MATERIALIZED VIEW MV_DEPT_AMOUNT AS
SELECT EMP.DEPTNO, MAX(PURCHASE.AMOUNT) AS MAX_AMOUNT,
MIN(PURCHASE.AMOUNT) AS MIN_AMOUNT, AVG(PURCHASE.AMOUNT) AS AVG_AMOUNT,
DEPT.DNAME
FROM EMP
INNER JOIN PURCHASE
ON EMP.EMPNO = PURCHASE.SERVEDBY
INNER JOIN DEPT
ON EMP.DEPTNO = DEPT.DEPTNO
GROUP BY EMP.DEPTNO, DEPT.DNAME
ORDER BY EMP.DEPTNO;

/*----------------------- Task 3c --------------------------*/






