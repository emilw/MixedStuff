
--Edi documents import times
--Assumption, diff is between doc is created and last save. The last save involves setting the doc id in the "real" flow
--Includes all without an error
Select 'EDI docs: ', LEFT(CONVERT(varchar, d.CreatedTimestamp,112),6) As YearMonth, AVG(DATEDIFF(MILLISECOND, d.CreatedTimestamp, d.ChangedTimestamp)) as ImportTimeMs, COUNT(*) as NumberOfDocs
/*d.Id As EDIDocId, d.CreatedTimestamp, d.ChangedTimestamp, t.Created, edi.SavedDocument_id As RealDocId*/
From [Medius.Core.Entities.Integration].EDIDocumentImport edi Inner Join [Medius.Data].Document d On(d.Id = edi.Document_id) 
 Inner Join [Medius.Core.Entities].DocumentTask dt On(dt.Document_id = d.Id) Inner Join [Medius.Data].Task task On(task.Id = dt.Task_id)
Where edi.Status = 'Registered'
And Not d.ViewId In (Select er.SourceEntity_EntityViewId From [Medius.Core.Entities.EntityMetadata].EntityError er Where er.SourceEntity_EntityType = 'Medius.Core.Entities.Integration.EDIDocumentImport')
Group By LEFT(CONVERT(varchar, d.CreatedTimestamp,112),6)

--Expense invoice import speed
--Assumption that it is tracked to documentIsRegistered
Select 'Expense docs: ', LEFT(CONVERT(varchar, d.CreatedTimestamp,112),6) As YearMonth, AVG(DATEDIFF(MILLISECOND, d.CreatedTimestamp, task.Created)) as ImportTimeMs, COUNT(*) as NumberOfDocs
/*d.Id as DocumentId, d.CreatedTimestamp, d.ChangedTimestamp, task.Created, */
from [Medius.Data].Document d Inner Join [Medius.PurchaseToPay.Entities].SupplierInvoice si On(si.Document_id = d.Id)
Inner Join [Medius.ExpenseInvoice.Entities].ExpenseInvoice e On(e.SupplierInvoice_id = d.Id)
Inner Join (Select Created, [Description], Document_id
from [Medius.Data].Task t Inner Join [Medius.Core.Entities].DocumentTask dt On(dt.Task_id = t.Id)) task On(task.Document_id = d.Id)
Where task.Description = '#Core/documentRegistered'
Group By LEFT(CONVERT(varchar, d.CreatedTimestamp,112),6)

--Match invoice import speed
--Assumption that it is tracked to document is registered
Select 'Match docs: ', LEFT(CONVERT(varchar, d.CreatedTimestamp,112),6) As YearMonth, AVG(DATEDIFF(MILLISECOND, d.CreatedTimestamp, task.Created)) as ImportTimeMs, COUNT(*) as NumberOfDocs
/*d.Id as DocumentId, d.CreatedTimestamp, d.ChangedTimestamp, task.Created, */
from [Medius.Data].Document d Inner Join [Medius.PurchaseToPay.Entities].SupplierInvoice si On(si.Document_id = d.Id)
Inner Join [Medius.OrderbasedInvoice.Entities].OrderbasedInvoice o On(o.SupplierInvoice_id = d.Id)
Inner Join (Select Created, [Description], Document_id
from [Medius.Data].Task t Inner Join [Medius.Core.Entities].DocumentTask dt On(dt.Task_id = t.Id)) task On(task.Document_id = d.Id)
Where task.Description = '#Core/documentRegistered'
Group By LEFT(CONVERT(varchar, d.CreatedTimestamp,112),6)

--EDI document with errors
Select 'EDI errors: ', LEFT(CONVERT(varchar, er.CreatedTimestamp,112),6) As YearMonth, Count(distinct er.SourceEntity_EntityViewId) As DocumentsWithErrors
/*d.Id As EDIDocId, d.CreatedTimestamp, d.ChangedTimestamp, t.Created, edi.SavedDocument_id As RealDocId*/
From [Medius.Core.Entities.EntityMetadata].EntityError er
Where er.SourceEntity_EntityType = 'Medius.Core.Entities.Integration.EDIDocumentImport'
Group By LEFT(CONVERT(varchar, er.CreatedTimestamp,112),6)
