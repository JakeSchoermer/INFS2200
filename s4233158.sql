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
GROUP BY CLIENT.CLIENTNO, CLIENT.CNAME


/*---------------- Task 2b --------------------*/















