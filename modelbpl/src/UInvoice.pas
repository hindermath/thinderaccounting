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

type
  TInvoice = class;

  TInvoiceStatus = (
    ReadyItems,
    ReadyPayments,
    ReadyProcess,
    Processed,
    Overpaid
  );

  [Entity]
  [Automapping]
  TInvoicePayment = class
  private
    FId: Integer;
    FPaidOn: TDate;
    FAmount: Double;
    [Association([], CascadeTypeAllButRemove)]
    FInvoice: TInvoice;
  public
    constructor Create;

    property ID: Integer read FId write FId;
    property PaidOn: TDate read FPaidOn write FPaidOn;
    property Amount: Double read FAmount write FAmount;
    property Invoice: TInvoice read FInvoice write FInvoice;
  end;

  [Entity]
  [Automapping]
  TInvoice = class
  private

  public

  end;

  TInvoicePayments = class( TList<TInvoicePayment> )
  public
    function LastPaymentDate: NullableDate;
  end;

  [Entity]
  [Automapping]
  TInvoiceItem = class
  private
    FCategory: Integer;
    [Column('Description', [], 5000)]
    FDescription: String;
    FId: Integer;
    FIdx: Integer;
    [Association([], CascadeTypeAllButRemove)]
    FInvoice: TInvoice;
    FQuantity: Integer;
    FValue: Integer;
    function GetTotalValue: Double;

  public
    property Category: Integer read FCategory write FCategory;
    property Description: String read FDescription write FDescription;
    property Id: Integer read FId write FId;
    property Idx: Integer read FIdx write FIdx;
    property Invoice: TInvoice read FInvoice write FInvoice;
    property Quantity: Integer read FQuantity write FQuantity;
    property Value: Integer read FValue write FValue;



  end;

IMPLEMENTATION

constructor TInvoicePayment.Create;
begin
  inherited;

end;

function TInvoicePayments.LastPaymentDate: NullableDate;
begin
  if self.Count = 0 then
  begin
    Result := SNull;
    Exit;
  end;

  Result := self.Items[0].PaidOn;

  for var i := 1 to self.Count - 1 do
  begin
    var LPayment := self.Items[i];
    if Result < LPayment.PaidOn then
      Result := LPayment.PaidOn;
  end;
end;

function TInvoiceItem.GetTotalValue: Double;
begin
  Result := Quantity * Value;
end;

initialization
  RegisterEntity(TInvoicePayment);
  RegisterEntity(TInvoice);

END.
