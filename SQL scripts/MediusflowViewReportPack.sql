

/****** Object:  Schema [Medius.Contract.Entities]    Script Date: 2015-12-07 16:15:09 ******/

if((select count(*) From sys.schemas where name = 'Medius.Reporting') = 0)
begin
	exec sys.sp_sqlexec 'CREATE SCHEMA [Medius.Reporting]'
end


if((select count(*) from sys.views where name = 'SupplierInvoice') = 1)
begin
	exec sys.sp_sqlexec 'Drop View [Medius.Reporting].SupplierInvoice'
end

Go

Create View [Medius.Reporting].SupplierInvoice as
Select si.Document_id As DocumentId, si.InvoiceNumber as InvoiceNumber, si.InvoiceDate as InvoiceDate, c.Name as CompanyName,
c.CompanyId As ERPCompanyId, s.Name As SupplierName, s.SupplierId As ERPSupplierId, si.Gross_Number_Value as GrossAmount, curr.Code as CurrencyCode,
p.Name as PaymentTerm, d.CreatedTimestamp As CreatedTimestamp
From [Medius.PurchaseToPay.Entities].SupplierInvoice si
	Inner Join [Medius.Data].Document d On(d.Id = si.Document_id)
	Inner Join [Medius.Core.Entities].Company c On(c.Id = si.Company_id)
	Inner Join [Medius.Enterprise.Entities].Supplier s On(s.Id = si.Supplier_id)
	Inner Join [Medius.Core.Entities].Currency curr On(curr.Id = si.Gross_Currency_id)
	Inner Join [Medius.Enterprise.Entities].PaymentTerm p On(p.Id = s.PaymentTerm_id)

go

if((select count(*) from sys.views where name = 'WorkflowStep') = 1)
begin
	exec sys.sp_sqlexec 'Drop View [Medius.Reporting].WorkflowStep'
end

Go


Create View [Medius.Reporting].WorkflowStep as
Select dt.Document_id as DocumentId, t.State as State, t.CreatedTimestamp as TaskCreated, t.ChangedTimestamp as TaskClosed,
te.Value as WorkflowStateName, lang.Language as Language, (Case When u.Id is null Then 0 else 1 end) As IsUserRelatedTask,
u.FirstName As ClosedByUserFirstName, u.LastName As ClosedByUserLastName,u.UserName As ClosedByUserUserName
From [Medius.Core.Entities].[DocumentTask] dt
Inner Join [Medius.Data].Task t On(t.Id = dt.Task_id)
Inner Join [Medius.Data].TranslationEntry te On(te.TranslationKey = t.Description)
Inner Join [Medius.Data].Translation lang On(lang.Language = te.Language)
Left Outer Join [Medius.Core.Entities.Workflow].[UserTask] ut On(ut.DocumentTask_id = dt.Task_id)
Left Outer Join [Medius.Core.Entities].[User] u On(u.Id = ut.ClosedBy_id)