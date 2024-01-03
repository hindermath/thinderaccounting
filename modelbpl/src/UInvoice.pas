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
  Aurelius.Mapping.AutoMapping, Aurelius.Mapping.Attributes,
  Aurelius.Mapping.Metadata, Aurelius.Mapping.Explorer, Aurelius.Types.Blob,
  Aurelius.Types.Proxy

    , Bcl.Types.Nullable

    , System.SysUtils, System.DateUtils, System.Generics.Collections

    , UCustomer, UTransaction

    ;

TYPE
  TInvoice = CLASS;

  [Automapping]
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
    FNewProperty: Integer;
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
    function GetAmountDue: Double;
    function GetAmountPaid: Double;
    function GetBillTo: string;
    function GetCanModify: Boolean;
    function GetCustomer: TCustomer;
    function GetStatus: TInvoiceStatus;
    function GetStatusText: string;
    function GetTotalAmount: Double;

    procedure SetCustomer(const Value: TCustomer);

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

function TInvoice.GetAmountDue: Double;
begin
  //Result := ;
  // TODO -cMM: TInvoice.GetAmountDue default body inserted
end;

function TInvoice.GetAmountPaid: Double;
begin
  //Result := ;
  // TODO -cMM: TInvoice.GetAmountPaid default body inserted
end;

function TInvoice.GetBillTo: string;
begin
  //Result := ;
  // TODO -cMM: TInvoice.GetBillTo default body inserted
end;

function TInvoice.GetCanModify: Boolean;
begin
  //Result := ;
  // TODO -cMM: TInvoice.GetCanModify default body inserted
end;

function TInvoice.GetCustomer: TCustomer;
begin
  //Result := ;
  // TODO -cMM: TInvoice.GetCustomer default body inserted
end;

function TInvoice.GetStatus: TInvoiceStatus;
begin
  //Result := ;
  // TODO -cMM: TInvoice.GetStatus default body inserted
end;

function TInvoice.GetStatusText: string;
begin
  //Result := ;
  // TODO -cMM: TInvoice.GetStatusText default body inserted
end;

function TInvoice.GetTotalAmount: Double;
begin
  //Result := ;
  // TODO -cMM: TInvoice.GetTotalAmount default body inserted
end;

procedure TInvoice.SetCustomer(const Value: TCustomer);
begin
  // TODO -cMM: TInvoice.SetCustomer default body inserted
end;

INITIALIZATION

RegisterEntity(TInvoicePayment);
RegisterEntity(TInvoice);
RegisterEntity(TInvoiceItem);

END.
