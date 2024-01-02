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
UNIT UTransaction;
{$SCOPEDENUMS ON }
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
 , System.Generics.Collections
 , System.DateUtils

 , UDocument

 ;

TYPE
	[Enumeration(TEnumMappingType.emChar, 'I,E,A')]
	TTransactionKind = ( Income, Expense, All ); // All is use for filtering

	[Entity]
	[Automapping]
	[Table('TRANSACT')]
	TTransaction = CLASS
	private
		FId: Integer;
		FTitle: STRING;
		FKind: TTransactionKind;
		FCategory: STRING;
		FAmount: Double;
		FIsMonthly: Boolean;
		[Association([TAssociationProp.Lazy], CascadeTypeAll)]
		FDocument: Proxy<TDocument>;
		FPaidOn: TDateTime;
		FMonth: Integer;
		FMonthsPaid: Integer;
	public
		CONSTRUCTOR Create; overload;
		CONSTRUCTOR Create( Akind: TTransactionKind ); overload;

		FUNCTION GetDocument: TDocument;
		PROCEDURE SetDocument( CONST Value: TDocument );
		FUNCTION GetMonthsPaid: Integer;
		FUNCTION GetMonth: Integer;
		FUNCTION GetAmountTotal: Double;
		FUNCTION GetEffectiveAmount(ARangeStart, ARangeStop: TDateTime): Double;

		PROPERTY Id: Integer read FId write FId;
		PROPERTY Title: STRING read FTitle write FTitle;
		PROPERTY Kind: TTransactionKind read FKind write FKind;
		PROPERTY Category: STRING read FCategory write FCategory;
		PROPERTY Amount: Double read FAmount write FAmount;
		PROPERTY IsMonthly: Boolean read FIsMonthly write FIsMonthly;
		PROPERTY PaidOn: TDateTime read FPaidOn write FPaidOn;
		PROPERTY Document: TDocument read GetDocument write SetDocument;
		PROPERTY MonthsPaid: Integer read GetMonthsPaid;
		PROPERTY Month: Integer read GetMonth;
		PROPERTY AmountTotal: Double read GetAmountTotal;
	END;

IMPLEMENTATION

CONSTRUCTOR TTransaction.Create;
BEGIN
	INHERITED;

	FIsMonthly := False;
END;

CONSTRUCTOR TTransaction.Create(Akind: TTransactionKind);
BEGIN
	Create;

	Kind := Akind;

END;

FUNCTION TTransaction.GetDocument: TDocument;
BEGIN
	Result := FDocument.Value;
END;

PROCEDURE TTransaction.SetDocument( CONST Value: TDocument );
BEGIN
	FDocument.Value := Value;
END;

FUNCTION TTransaction.GetMonthsPaid: Integer;
BEGIN
	IF self.IsMonthly THEN
		Result := 12 - Month +1
	ELSE
		Result := 1;
END;

FUNCTION TTransaction.GetMonth: Integer;
BEGIN
	Result := PaidOn.Month;
END;

FUNCTION TTransaction.GetAmountTotal: Double;
BEGIN
	Result := Amount * MonthsPaid;
END;

FUNCTION TTransaction.GetEffectiveAmount(ARangeStart: TDateTime; ARangeStop: TDateTime): Double;
VAR
  LMonthEff,
  LMonthStart,
  LMonthEnd: Word;
BEGIN
  Result := 0;

  // only valid ranges
  IF ARangeStart < ARangeStop THEN
    Exit;
  // only consider the year the transaction was defined in
  IF ARangeStart.Year <> PaidOn.Year THEN
    Exit;

  LMonthStart := ARangeStart. Month;

  {* if the day in the first month has occured out of range,
   * increase number
   *}
  IF ARangeStart.Day > PaidOn.Day THEN
    Inc(LMonthStart);

  IF ARangeStop.Year > PaidOn.Year THEN
    LMonthEnd := 12
  ELSE
  BEGIN
    LMonthEnd := ARangeStop.Month;
    // if the day in the last month has not occured, reduce number
    IF ARangeStop.Day < PaidOn.Day THEN
      Dec(LMonthEnd);
  END;

  LMonthEff := LMonthEnd - LMonthStart + 1;

  Result := LMonthEff * Amount;
END;

INITIALIZATION
	RegisterEntity(TTransaction);
END.
