{ ******************************************************************************** }
{ * ThinderAccounting Example                                                    * }
{ * -------------------------                                                    * }
{ *                                                                              * }
{ * Copyright (c) 2024 by Thorsten Hindermann, TMyTTMAAP.                        * }
{ * This example based on the book "Modern Software Development with DELPHI"     * }
{ * from Dr. Holger Flick, FlixEngineering, LLC.                                 * }
{ * ISBN: 9798854692526                                                          * }
{ * Please purchase and read this book to understand this sample program.        * }
{ *                                                                              * }
{ * DISCLAIMER:                                                                  * }
{ * This source code is provided as an example for educational and illustrative  * }
{ * purposes only. It is not intended for production use or any specific purpose.* }
{ * The author and the company disclaim all liabilities for any damages or       * }
{ * losses arising from the use or misuse of this code. Use at your own risk.    * }
{ ******************************************************************************** }
UNIT UInvoice;

INTERFACE

USES
      Aurelius.Mapping.AutoMapping
    , Aurelius.Mapping.Attributes
    , Aurelius.Mapping.Metadata
    , Aurelius.Mapping.Explorer
    , Aurelius.Types.Blob
    , Aurelius.Types.Proxy

    , Bcl.Types.Nullable

    , System.SysUtils
    , System.DateUtils
    , System.Generics.Collections

    , UCustomer
    , UTransaction

    ;

TYPE
  TInvoice = CLASS;

  [AutoMapping]
  TInvoiceStatus = (ReadyItems, ReadyPayments, ReadyProcess, Processed,
    Overpaid);

  [Entity]
  [AutoMapping]
  TInvoicePayment = CLASS
  private
    FId: Integer;
    FPaidOn: TDate;
    FAmount: Double;
    [Association([], CascadeTypeAllButRemove)]
    FInvoice: TInvoice;
  public
    CONSTRUCTOR Create;

    PROPERTY ID: Integer read FId write FId;
    PROPERTY PaidOn: TDate read FPaidOn write FPaidOn;
    PROPERTY Amount: Double read FAmount write FAmount;
    PROPERTY Invoice: TInvoice read FInvoice write FInvoice;
  END;

  TInvoicePayments = CLASS(TList<TInvoicePayment>)
  public
    FUNCTION LastPaymentDate: NullableDate;
  END;

  [Entity]
  [AutoMapping]
  TInvoiceItem = CLASS
  private
    FCategory: Integer;
    [Column('Description', [], 5000)]
    FDescription: STRING;
    FId: Integer;
    FIdx: Integer;
    [Association([], CascadeTypeAllButRemove)]
    FInvoice: TInvoice;
    FQuantity: Integer;
    FValue: Integer;
    FUNCTION GetTotalValue: Double;

  public
    PROPERTY Category: Integer read FCategory write FCategory;
    PROPERTY Description: STRING read FDescription write FDescription;
    PROPERTY ID: Integer read FId write FId;
    PROPERTY Idx: Integer read FIdx write FIdx;
    PROPERTY Invoice: TInvoice read FInvoice write FInvoice;
    PROPERTY Quantity: Integer read FQuantity write FQuantity;
    PROPERTY Value: Integer read FValue write FValue;

    PROPERTY TotalValue: Double read GetTotalValue;


  END;

  TInvoiceItems = TList<TInvoiceItem>;

  [Entity]
  [AutoMapping]
  TInvoice = CLASS
  private
    [Association([TAssociationProp.Lazy], CascadeTypeAll)]
    FCustomer: Proxy<TCustomer>;
    FDueOn: TDate;
    FId: Integer;
    FIssuedOn: TDate;
    [ManyValuedAssociation([TAssociationProp.Lazy], CascadeTypeAll, 'FInvoice')]
    [OrderBy('Idx')]
    FItems: Proxy<TInvoiceItems>;
    [Column('Number', [TColumnProp.Unique])]
    FNumber: Integer;
    [ManyValuedAssociation([TAssociationProp.Lazy], CascadeTypeAll, 'FInvoice')]
    [OrderBy('PaidOn')]
    FPayments: Proxy<TInvoicePayments>;
    [Column('ProcessedCopy', [TColumnProp.Lazy])]
    FProcessedCopy: TBlob;
    [Association([TAssociationProp.Lazy], CascadeTypeAllButRemove)]
    FTransactions: Proxy<TTransactions>;

  public
    CONSTRUCTOR Create;
    DESTRUCTOR Destroy; override;
    FUNCTION GetAmountDue: Double;
    FUNCTION GetAmountPaid: Double;
    FUNCTION GetBillTo: STRING;
    FUNCTION GetCanModify: Boolean;
    FUNCTION GetCustomer: TCustomer;
    FUNCTION GetItems: TInvoiceItems;
    FUNCTION GetPayments: TInvoicePayments;
    FUNCTION GetStatus: TInvoiceStatus;
    FUNCTION GetStatusText: STRING;
    FUNCTION GetTotalAmount: Double;
    FUNCTION GetTransactions: TTransactions;

    PROCEDURE SetCustomer(CONST Value: TCustomer);

    PROPERTY ID: Integer read FId write FId;
    PROPERTY Number: Integer read FNumber write FNumber;
    PROPERTY IssuedOn: TDate read FIssuedOn write FIssuedOn;
    PROPERTY DueOn: TDate read FDueOn write FDueOn;
    PROPERTY Customer: TCustomer read GetCustomer write SetCustomer;
    PROPERTY TotalAmount: Double read GetTotalAmount;
    PROPERTY AmountDue: Double read GetAmountDue;
    PROPERTY AmountPaid: Double read GetAmountPaid;
    PROPERTY ProcessedCopy: TBlob read FProcessedCopy write FProcessedCopy;
    PROPERTY BillTo: STRING read GetBillTo;
    PROPERTY Status: TInvoiceStatus read GetStatus;
    PROPERTY StatusText: STRING read GetStatusText;
    PROPERTY CanModify: Boolean read GetCanModify;
    PROPERTY Items: TInvoiceItems read GetItems;
    PROPERTY Payments: TInvoicePayments read GetPayments;
    PROPERTY Transactions: TTransactions read GetTransactions;


  END;

IMPLEMENTATION

CONSTRUCTOR TInvoicePayment.Create;
BEGIN
  INHERITED;

END;

FUNCTION TInvoicePayments.LastPaymentDate: NullableDate;
BEGIN
  IF self.Count = 0 THEN
  BEGIN
    Result := SNull;
    Exit;
  END;

  Result := self.Items[0].PaidOn;

  FOR VAR i := 1 TO self.Count - 1 DO
  BEGIN
    VAR
    LPayment := self.Items[i];
    IF Result < LPayment.PaidOn THEN
      Result := LPayment.PaidOn;
  END;
END;

FUNCTION TInvoiceItem.GetTotalValue: Double;
BEGIN
  Result := Quantity * Value;
END;

CONSTRUCTOR TInvoice.Create;
BEGIN
  INHERITED;

  FItems.SetInitialValue(TInvoiceItems.Create);
  FPayments.SetInitialValue(TInvoicePayments.Create);
  FTransactions.SetInitialValue(TTransactions.Create);

  FIssuedOn := TDateTime.ToDay;
  FDueOn := TDateTime.Now.IncDay(7);
END;

DESTRUCTOR TInvoice.Destroy;
BEGIN
  FTransactions.DestroyValue;
  FPayments.DestroyValue;
  FItems.DestroyValue;

  INHERITED;
END;

FUNCTION TInvoice.GetAmountDue: Double;
BEGIN
  Result := TotalAmount + AmountPaid;
END;

FUNCTION TInvoice.GetAmountPaid: Double;
BEGIN
  Result := 0;
  FOR VAR LPayment IN self.Payments DO
      Result := Result + LPayment.FAmount;
END;

FUNCTION TInvoice.GetBillTo: STRING;
BEGIN
  Result := STRING.Empty;

  IF Assigned( self.Customer ) THEN
    Result := self.Customer.AddressExcel;
END;

FUNCTION TInvoice.GetCanModify: Boolean;
BEGIN
  Result := (Transactions.Count = 0) AND (Payments.Count = 0);
END;

FUNCTION TInvoice.GetCustomer: TCustomer;
BEGIN
  Result := FCustomer.Value;
END;

FUNCTION TInvoice.GetItems: TInvoiceItems;
BEGIN
  Result := FItems.Value;
END;

FUNCTION TInvoice.GetPayments: TInvoicePayments;
BEGIN
  Result := FPayments.Value;
END;

FUNCTION TInvoice.GetStatus: TInvoiceStatus;
BEGIN
  Result := TInvoiceStatus.ReadyItems;
  IF self.TotalAmount > 0 THEN
    IF self.AmountDue > 0 THEN
      Result := TInvoiceStatus.ReadyPayments
    ELSE
      IF self.AmountDue < 0 THEN
        Result := TInvoiceStatus.Overpaid
      ELSE
        IF self.Transactions.Count = 0 THEN
          Result := TInvoiceStatus.ReadyProcess
        ELSE
          Result := TInvoiceStatus.Processed
END;

FUNCTION TInvoice.GetStatusText: STRING;
BEGIN
  CASE Status OF
    ReadyItems: Result := 'Add items';
    ReadyPayments: Result := 'Make payments';
    ReadyProcess: Result := 'Ready to process';
    Processed: Result := 'Processed';
    Overpaid:  Result := 'Overpaid';
  END;
END;

FUNCTION TInvoice.GetTotalAmount: Double;
BEGIN
  Result := 0;
  FOR VAR LItem IN Items DO
    Result := Result + LItem.TotalValue;
END;

FUNCTION TInvoice.GetTransactions: TTransactions;
BEGIN
  Result := FTransactions.Value;
END;

PROCEDURE TInvoice.SetCustomer(CONST Value: TCustomer);
BEGIN
  FCustomer.Value := Value;
END;

INITIALIZATION
  RegisterEntity(TInvoice);

END.
