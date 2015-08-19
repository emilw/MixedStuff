set nocount on

Select * Into #TablesAndTheirSizes
From 
( Select o.name As Name, p.rows As NumberOfRows, ps.used_page_count*8 As TotalSize, ps.in_row_data_page_count*8 As DataSize,
(ps.used_page_count-ps.in_row_data_page_count)*8 As IndexSize, CASE When p.rows = 0 Then 0 Else Convert(numeric(18,4),ps.used_page_count*8)/Convert(numeric(18,4),p.rows) End As RecordSizeKb,
--(Select COUNT(*) from sys.indexes Where object_id = o.object_id) As NumberOfIndexes
COUNT(ix.object_id) As NumberOfIndexes
FROM sys.partitions p
     INNER JOIN sys.dm_db_partition_stats ps On(ps.partition_id = p.partition_id
												and ps.partition_number = p.partition_number)
     Inner Join sys.objects o On(o.object_id = p.object_id)
     Right Outer Join sys.indexes ix On(ix.object_id = o.object_id)
Where o.is_ms_shipped = 0
Group by o.name, p.rows, ps.used_page_count*8, ps.in_row_data_page_count*8,
(ps.used_page_count-ps.in_row_data_page_count)*8, CASE When p.rows = 0 Then 0 Else Convert(numeric(18,4),ps.used_page_count*8)/Convert(numeric(18,4),p.rows) End
) As Dude

Select 'Transaction tables with large records'
Select * From #TablesAndTheirSizes
Where NumberOfRows > 100
And RecordSizeKb > 1
Order by RecordSizeKb Desc

Select 'Tables with large record size and overuse of indexes'

Select * from #TablesAndTheirSizes
Where RecordSizeKb > 1
And NumberOfIndexes > 3
Order by NumberOfRows Desc, NumberOfIndexes Desc

Select 'Largest tables'

Select Name, NumberOfRows, TotalSize/1024 As SizeInMb, DataSize/1024 As DataSizeMb, IndexSize/1024 As IndexSizeMb,
TotalSize/1024/1024 As SizeInGb, DataSize/1024/1024 As DataSizeGb, IndexSize/1024/1024 As IndexSizeGb
From #TablesAndTheirSizes
Where TotalSize > 100*1024 --(To get it to Kb)
Order by TotalSize Desc

--List all missing indexes
Select * From sys.dm_db_missing_index_details

Select 'Business figures'
Select COUNT(*), 'Expense invoices' From [Medius.ExpenseInvoice.Entities].ExpenseInvoice
Select COUNT(*), 'Orderbased invoices' From [Medius.OrderbasedInvoice.Entities].OrderbasedInvoice
Select COUNT(*), 'Companies' From [Medius.Core.Entities].Company
Select COUNT(*), 'Suppliers' From [Medius.Enterprise.Entities].Supplier
Select COUNT(*), 'Dimensions' From [Medius.Enterprise.Entities.Accounting.Dimensions].DimensionValue
Select COUNT(*), 'Users' From [Medius.Core.Entities].[User]


Select 'Full table information output...'
Select * From #TablesAndTheirSizes
Order by NumberOfRows Desc

Drop Table #TablesAndTheirSizes