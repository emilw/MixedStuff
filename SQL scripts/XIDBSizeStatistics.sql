set nocount on

Select * Into #TablesAndTheirSizes
From 
(Select o.name As Name, p.rows As NumberOfRows, ps.used_page_count*8 As TotalSize, ps.in_row_data_page_count*8 As DataSize,
(ps.used_page_count-ps.in_row_data_page_count)*8 + nc.NonClusteredIndexTotalSize As TotalIndexSize, CASE When p.rows = 0 Then 0 Else Convert(numeric(18,4),ps.used_page_count*8)/Convert(numeric(18,4),p.rows) End As RecordSizeKb,
(Select COUNT(*) from sys.indexes Where object_id = o.object_id) As NumberOfIndexes
FROM sys.partitions p
     INNER JOIN sys.dm_db_partition_stats ps On(ps.partition_id = p.partition_id
												and ps.partition_number = p.partition_number
												and ps.index_id = 1)
     Inner Join sys.objects o On(o.object_id = p.object_id)
     Left Outer Join (Select ix2.object_id As ObjectId, Sum(used_page_count*8) as NonClusteredIndexTotalSize
					From sys.indexes ix2 Inner Join sys.dm_db_partition_stats ps2 On(ps2.object_id = ix2.object_id and ps2.index_id = ix2.index_id)
					Where type_desc <> 'CLUSTERED' Group By ix2.object_id) nc On(nc.ObjectId = o.object_id)
Where o.is_ms_shipped = 0
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

Select Name, NumberOfRows, TotalSize/1024 As SizeInMb, DataSize/1024 As DataSizeMb, TotalIndexSize/1024 As IndexSizeMb,
TotalSize/1024/1024 As SizeInGb, DataSize/1024/1024 As DataSizeGb, TotalIndexSize/1024/1024 As IndexSizeGb
From #TablesAndTheirSizes
Where TotalSize > 100*1024 --(To get it to Kb)
Order by TotalSize Desc

--List all missing indexes
Select * From sys.dm_db_missing_index_details

Select 'Business figures'
Select 'All documents' As ObjectType, COUNT(*) As NumberOfRecords From [Medius.ExpenseInvoice.Entities].ExpenseInvoice
Union
Select 'Expense invoices', COUNT(*) From [Medius.ExpenseInvoice.Entities].ExpenseInvoice
Union
Select 'Orderbased invoices', COUNT(*) From [Medius.OrderbasedInvoice.Entities].OrderbasedInvoice
Union
Select 'Companies', COUNT(*) From [Medius.Core.Entities].Company
Union
Select 'Suppliers', COUNT(*) From [Medius.Enterprise.Entities].Supplier
Union
Select 'Dimensions', COUNT(*) From [Medius.Enterprise.Entities.Accounting.Dimensions].DimensionValue
Union
Select 'Users', COUNT(*) From [Medius.Core.Entities].[User]


Select 'Full table information output...'
Select * From #TablesAndTheirSizes
Order by NumberOfRows Desc

Drop Table #TablesAndTheirSizes