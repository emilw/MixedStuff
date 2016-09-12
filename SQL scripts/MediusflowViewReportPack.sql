

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

Go

if((select count(*) from sys.views where name = 'SupplierInvoiceCoding') = 1)
begin
	exec sys.sp_sqlexec 'Drop View [Medius.Reporting].SupplierInvoiceCoding'
end

Go

Create View [Medius.Reporting].SupplierInvoiceCoding As
Select si.Document_id As DocumentId, cs.LineNumber As LineNumber, cs.InvoiceLineNumber as InvoiceLineNumber,
d1.Value As Dim1Value, d1.Description As Dim1Descriptiom, d2.Value As Dim2Value, d2.Description As Dim2Descriptiom,
d3.Value As Dim3Value, d3.Description As Dim3Descriptiom, d4.Value As Dim4Value, d4.Description As Dim4Descriptiom,
d5.Value As Dim5Value, d5.Description As Dim5Descriptiom, d6.Value As Dim6Value, d6.Description As Dim6Descriptiom,
d7.Value As Dim7Value, d7.Description As Dim7Descriptiom, d8.Value As Dim8Value, d8.Description As Dim8Descriptiom,
d9.Value As Dim9Value, d9.Description As Dim9Descriptiom, d10.Value As Dim10Value, d10.Description As Dim10Descriptiom,
d11.Value As Dim11Value, d11.Description As Dim11Descriptiom, d12.Value As Dim12Value, d12.Description As Dim12Descriptiom,
ds.Dimensions_FreeText1, ds.Dimensions_FreeText2, ds.Dimensions_FreeText3, ds.Dimensions_FreeText4, ds.Dimensions_FreeText5
From [Medius.Enterprise.Entities.Accounting].[CodeString] cs Inner Join [Medius.Enterprise.Entities.Accounting.Dimensions].[DimensionString] ds On(ds.Id = cs.DimensionApprovalString_id)
Inner Join [Medius.Enterprise.Entities.Accounting.Dimensions].[DimensionAmountString] das On(das.DimensionString_id = ds.Id)
Inner Join [Medius.Enterprise.Entities.Accounting.Dimensions].DimensionApprovalString dass On(dass.DimensionAmountString_id = das.DimensionString_id)
Inner Join [Medius.Enterprise.Entities.Accounting.Dimensions].DimensionApprovalObject da On(dass.DimensionApprovalObject_id = da.Id)
Inner Join [Medius.Enterprise.Entities.Accounting].[AccountingObject] ao On(ao.DimensionApprovalObject_id = da.Id)
Inner Join [Medius.PurchaseToPay.Entities].SupplierInvoice si On(si.Accounting_id = ao.DimensionApprovalObject_id)
Left Outer Join [Medius.Enterprise.Entities.Accounting.Dimensions].DimensionValue d1 On(d1.Id = ds.Dimensions_Dimension1_id)
Left Outer Join [Medius.Enterprise.Entities.Accounting.Dimensions].DimensionValue d2 On(d2.Id = ds.Dimensions_Dimension2_id)
Left Outer Join [Medius.Enterprise.Entities.Accounting.Dimensions].DimensionValue d3 On(d3.Id = ds.Dimensions_Dimension3_id)
Left Outer Join [Medius.Enterprise.Entities.Accounting.Dimensions].DimensionValue d4 On(d4.Id = ds.Dimensions_Dimension4_id)
Left Outer Join [Medius.Enterprise.Entities.Accounting.Dimensions].DimensionValue d5 On(d5.Id = ds.Dimensions_Dimension5_id)
Left Outer Join [Medius.Enterprise.Entities.Accounting.Dimensions].DimensionValue d6 On(d6.Id = ds.Dimensions_Dimension6_id)
Left Outer Join [Medius.Enterprise.Entities.Accounting.Dimensions].DimensionValue d7 On(d7.Id = ds.Dimensions_Dimension7_id)
Left Outer Join [Medius.Enterprise.Entities.Accounting.Dimensions].DimensionValue d8 On(d8.Id = ds.Dimensions_Dimension8_id)
Left Outer Join [Medius.Enterprise.Entities.Accounting.Dimensions].DimensionValue d9 On(d9.Id = ds.Dimensions_Dimension9_id)
Left Outer Join [Medius.Enterprise.Entities.Accounting.Dimensions].DimensionValue d10 On(d10.Id = ds.Dimensions_Dimension10_id)
Left Outer Join [Medius.Enterprise.Entities.Accounting.Dimensions].DimensionValue d11 On(d11.Id = ds.Dimensions_Dimension11_id)
Left Outer Join [Medius.Enterprise.Entities.Accounting.Dimensions].DimensionValue d12 On(d12.Id = ds.Dimensions_Dimension12_id)
