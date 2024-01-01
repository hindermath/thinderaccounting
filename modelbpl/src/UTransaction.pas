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
unit UTransaction;
{$SCOPEDENUMS ON }
interface
uses
   Aurelius.Mapping.AutoMapping
 , Aurelius.Mapping.Attributes
 , Aurelius.Mapping.Metadata
 , Aurelius.Mapping.Explorer
 , Aurelius.Types.Blob

 , Bcl.Types.Nullable

 , System.SysUtils
 , System.Generics.Collections

 , UDocument

 ;

type
  [Enumeration(TEnumMappingType.emChar, 'I,E,A')]
  TTransactionKind = ( Income, Expense, All ); // All is use for filtering

  [Entity]
  [Automapping]
  [Table('TRANSACT')]
  TTransaction = class
  private
    FId: Integer;
    FTitle: String;
    FKind: TTransactionKind;
    FCategory: String;
    FAmount: Double;
    FIsMonthly: Boolean;
    [Association([TAssociationProp.Lazy], CascadeTypeAll)]
    FDocument: TDocument;
    FPaidOn: TDateTime;
  public

  end;

implementation

initialization
  RegisterEntity(TTransaction);
end.
