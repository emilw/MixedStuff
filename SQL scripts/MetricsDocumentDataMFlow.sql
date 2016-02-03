Select top 100 si.Document_id, count(ao.DimensionApprovalObject_id), count(das.DimensionApprovalObject_id)
From [Medius.PurchaseToPay.Entities].[SupplierInvoice] si
Left outer join [Medius.Enterprise.Entities.Accounting].[AccountingObject] ao On(si.Accounting_id = ao.DimensionApprovalObject_id)
Left outer join [Medius.Enterprise.Entities.Accounting.Dimensions].DimensionApprovalObject dao On(dao.Id = ao.DimensionApprovalObject_id)
Left outer join [Medius.Enterprise.Entities.Accounting.Dimensions].DimensionApprovalString das On(das.DimensionApprovalObject_id = dao.Id)
Group By si.Document_id
Order by count(das.DimensionApprovalObject_id) desc;

Select top 100 si.Document_id, count(sil.SupplierInvoice_id)
From [Medius.PurchaseToPay.Entities].[SupplierInvoice] si
Inner Join [Medius.OrderbasedInvoice.Entities].OrderbasedInvoice oi On(oi.SupplierInvoice_id = si.Document_id)
Inner Join [Medius.PurchaseToPay.Entities].SupplierInvoiceLine sil On(sil.SupplierInvoice_id = si.Document_id)
Group by si.Document_id
Order by count(sil.SupplierInvoice_id) desc;

Select count(*),'Expense invoice count' From [Medius.ExpenseInvoice.Entities].ExpenseInvoice
Union
Select count(*), 'Orderbased invoice count' From [Medius.OrderbasedInvoice.Entities].OrderbasedInvoice
Union
Select count(*), 'Total document count' From [Medius.Data].Document;