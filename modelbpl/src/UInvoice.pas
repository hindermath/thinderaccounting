{********************************************************************************}
{* ThinderAccounting Example                                                    *}
{* -------------------------                                                    *}
{*                                                                              *}
{* Copyright (c) 2024 by Thorsten Hindermann, TMyTTMAAP.                        *}
{* This example based on the book "Modern Software Development with DELPHI"     *}
{* from Dr. Holger Flick, FlixEngineering, LLC.                                 *}
{* ISBN: 9798854692526                                                          *}
{* Please purchase and read this book to understand this sample program.        *}
{*                                                                              *}
{* DISCLAIMER:                                                                  *}
{* This source code is provided as an example for educational and illustrative  *}
{* purposes only. It is not intended for production use or any specific purpose.*}
{* The author and the company disclaim all liabilities for any damages or       *}
{* losses arising from the use or misuse of this code. Use at your own risk.    *}
{********************************************************************************}
UNIT UInvoice;

INTERFACE
USES
	 Aurelius.Mapping.AutoMapping
 , Aurelius.Mapping.Attributes
 , Aurelius.Mapping.Metadata
 , Aurelius.Mapping.Explorer
 , Aurelius.Types.Blob

 , Bcl.Types.Nullable

 , System.SysUtils
 , System.Generics.Collections


 ;

TYPE
  TInvoice = CLASS;

  TInvoiceStatus = (
    ReadyItems,
    ReadyPayments,
    ReadyProcess,
    Processed,
    Overpaid
  );

  [Entity]
  [Automapping]
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

  TInvoicePayments = CLASS( TList<TInvoicePayment> )
  public
    FUNCTION LastPaymentDate: NullableDate;
  END;

  [Entity]
  [Automapping]
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
    PROPERTY Id: Integer read FId write FId;
    PROPERTY Idx: Integer read FIdx write FIdx;
    PROPERTY Invoice: TInvoice read FInvoice write FInvoice;
    PROPERTY Quantity: Integer read FQuantity write FQuantity;
    PROPERTY Value: Integer read FValue write FValue;

  END;

  TInvoiceItems = TList<TInvoiceItem>;

  [Entity]
  [Automapping]
  TInvoice = CLASS
  private
    FDueOn: Integer;
    FId: Integer;
    FIssuedOn: TDate;
    FNewProperty: Integer;
    [Column('Number', [TColumnProp.Unique])]
    FNumber: Integer;

  public
    constructor Create;
    destructor Destroy; override;
    property DueOn: Integer read FDueOn write FDueOn;
    property Id: Integer read FId write FId;
    property IssuedOn: TDate read FIssuedOn write FIssuedOn;
    property Number: Integer read FNumber write FNumber;

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
    VAR LPayment := self.Items[i];
    IF Result < LPayment.PaidOn THEN
      Result := LPayment.PaidOn;
  END;
END;

FUNCTION TInvoiceItem.GetTotalValue: Double;
BEGIN
  Result := Quantity * Value;
END;

constructor TInvoice.Create;
begin
  inherited Create;
end;

destructor TInvoice.Destroy;
begin
  inherited Destroy;
end;


INITIALIZATION
  RegisterEntity(TInvoicePayment);
  RegisterEntity(TInvoice);
  RegisterEntity(TInvoiceItem);
END.
