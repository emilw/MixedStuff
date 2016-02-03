

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
c.CompanyId As ERPCompanyId, s.Name As SupplierName, s.SupplierId As ERPSupplierId, si.Gross_Number_Value, curr.Code as CurrencyCode,
p.Name as PaymentTerm
From [Medius.PurchaseToPay.Entities].SupplierInvoice si
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
te.Value as WorkflowStateName, lang.Language as Languagae, DATEDIFF(MIN
From [Medius.Core.Entities].[DocumentTask] dt
Inner Join [Medius.Data].Task t On(t.Id = dt.Task_id)
Inner Join [Medius.Data].TranslationEntry te On(te.TranslationKey = t.Description)
Inner Join [Medius.Data].Translation lang On(lang.Language = te.Language)