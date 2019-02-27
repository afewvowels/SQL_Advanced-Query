/****** Script for SelectTopNRows command from SSMS  ******/
SELECT 
	  [ContactID]
      ,con.[CustomerID]
	  ,cus.CustomerName
      ,[ContactName]
      ,[JobTitle]
      ,con.[Email]
      ,con.[PhoneNumber]
      ,[Notes]
      ,[IsAuthorizedForProjectsContact]
  FROM [IDMI-Projects_Dev].[dbo_customer].[Contact] con
  left join [dbo_customer].[Customer] cus ON cus.CustomerID = con.CustomerID
  WHERE con.CustomerID in (SELECT CustomerID FROM dbo_customer.Contact GROUP BY CustomerID HAVING count(ContactID) > 1)
  ORDER BY [CustomerID]


  --WHERE CustomerID=11 OR CustomerID=192 OR CustomerID=356 OR CustomerID=380 OR CustomerID=657 OR CustomerID=871 OR CustomerID=1032 OR CustomerID=1054 OR CustomerID=1439 OR CustomerID=1465 OR CustomerID=1480 OR CustomerID=1548 OR CustomerID=1800 OR CustomerID=1837 OR CustomerID=1856 OR CustomerID=1895 OR CustomerID=1903 OR CustomerID=1937
  -- WHERE CustomerID in (11,192,356...)

SELECT DISTINCT cus.[CustomerName]
      ,cus.[CustomerID]
	  ,cus.[WebsiteAddress]
	  , STUFF((SELECT ', ' + w.URL FROM	dbo_customer.Website as w WHERE w.CustomerID = cus.CustomerID FOR XML PATH('')), 1, 2, '') AS "URL"
  FROM [IDMI-Projects].[dbo_customer].[Website] web
  left join [IDMI-Projects].[dbo_customer].[Customer] cus ON cus.CustomerID = web.CustomerID
  WHERE web.IsActive = 1 AND cus.IsActive = 1
  ORDER BY cus.[CustomerID]
