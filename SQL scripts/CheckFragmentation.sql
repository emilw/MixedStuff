Declare @strDatabaseName varchar(100)
Set @strDatabaseName = 'MediusFlowArchive_92'
 
Select ips.object_id As ObjectId, t.name As TableName, ips.index_id As IndexId, ix.name As IndexName, index_type_desc As TypeOfIndex,
avg_fragmentation_in_percent As FragmentationPercentage, avg_fragment_size_in_pages As PageFragmentation
From sys.dm_db_index_physical_stats(DB_ID(@strDatabaseName), null, null, null, null) ips
           Inner Join sys.indexes ix On(ix.object_id = ips.object_id And ix.index_id = ips.index_id)
           Inner Join sys.tables t On(t.object_id = ix.object_id)
