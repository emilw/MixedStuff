Declare @strOrderNumber varchar(100)

--Input your ordernumber below
Set @strOrderNumber = '4500212391'


Select 'Order overview'
Select p.OrderIdentifier, s.Name, s.SupplierId, p.OrderType, p.RegisterDate, p.DueDate, p.IsActive, p.ExternalSystemId, p.ImportedTimestamp,
Count(pl.Id) As NumberOfOrderLines, Count(dl.Id) As NumberOfDeliveryLines
From [Medius.PurchaseToPay.Entities.PurchaseOrder].PurchaseOrder p Inner Join [Medius.Enterprise.Entities].Supplier s On(s.Id = p.Supplier_id)
Left Outer join [Medius.PurchaseToPay.Entities.PurchaseOrder].PurchaseOrderLine pl on(pl.PurchaseOrder_id = p.Id)
Left Outer Join [Medius.PurchaseToPay.Entities.PurchaseOrder].DeliveryLine dl On(dl.PurchaseOrderLine_id = pl.Id)
Where p.OrderIdentifier = @strOrderNumber
Group by p.OrderIdentifier, s.Name, s.SupplierId, p.OrderType, p.RegisterDate, p.DueDate, p.IsActive, p.ExternalSystemId, p.ImportedTimestamp



Select 'Order lines'
Select p.OrderIdentifier, pl.LineNumber, pl.ItemNumber, pl.UnitPrice_Number_Value, pl.Amount_Number_Value As Value, c.Code,
pl.Quantity_Number_Value As Quantity, pl.DeliveryDate, Count(dl.Id) As NumberOfDeliveryLines
From [Medius.PurchaseToPay.Entities.PurchaseOrder].PurchaseOrder p Inner join [Medius.PurchaseToPay.Entities.PurchaseOrder].PurchaseOrderLine pl on(pl.PurchaseOrder_id = p.Id)
Inner Join [Medius.Core.Entities].Currency c On(c.Id = pl.Amount_Currency_id)
Left Outer Join [Medius.PurchaseToPay.Entities.PurchaseOrder].DeliveryLine dl On(dl.PurchaseOrderLine_id = pl.Id)
Where p.OrderIdentifier = @strOrderNumber
Group By p.OrderIdentifier, pl.LineNumber, pl.ItemNumber, pl.UnitPrice_Number_Value, pl.Amount_Number_Value, c.Code,
pl.Quantity_Number_Value, pl.DeliveryDate


Select 'Delivery lines'
Select p.OrderIdentifier, pl.ItemNumber, dl.DeliveryNumber, dl.DeliveryNote, pl.UnitPrice_Number_Value, pl.Amount_Number_Value As Value, c.Code,
pl.Quantity_Number_Value As Quantity, pl.DeliveryDate, dl.Amount_Number_Value As DeliveredAmount,
dl.Quantity_Number_Value As DeliveredQuantity, dl.UnitPrice_Number_Value As DeliveredUnitPrice,
dl.ExternalSystemId, dl.DeliveredDate
From [Medius.PurchaseToPay.Entities.PurchaseOrder].PurchaseOrder p Inner join [Medius.PurchaseToPay.Entities.PurchaseOrder].PurchaseOrderLine pl on(pl.PurchaseOrder_id = p.Id)
Inner Join [Medius.Core.Entities].Currency c On(c.Id = pl.Amount_Currency_id)
Inner Join [Medius.PurchaseToPay.Entities.PurchaseOrder].DeliveryLine dl On(dl.PurchaseOrderLine_id = pl.Id)
Where p.OrderIdentifier = @strOrderNumber

Select 'Orders that seems to be stuck in import queue'
Select * From [Medius.Core.Entities.Integration].[MasterDataError]
Where MasterDataExternalSystemId Like '%' + @strOrderNumber + '%'
