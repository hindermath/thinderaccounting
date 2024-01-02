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
UNIT UCustomer;

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
  [Entity]
  [Automapping]
  TCustomer = CLASS
  private
    FId: Integer;
    [Column('Address',[], 2048)]
    FAddress: STRING;
    FContact: STRING;
    FEmail: STRING;
    [Column('Name', [TColumnProp.Unique])]
    FName: STRING;

    FUNCTION GetAddressExcel: STRING;

  public
    CONSTRUCTOR Create;

    PROPERTY Id: Integer read FId write FId;
    PROPERTY Address: STRING read FAddress write FAddress;
    PROPERTY Contact: STRING read FContact write FContact;
    PROPERTY EMail: STRING read FEmail write FEmail;
    PROPERTY Name: STRING read FName write FName;
    PROPERTY AddressExcel: STRING read GetAddressExcel;

  END;

IMPLEMENTATION
CONST
  cCarriageReturn = #13;

CONSTRUCTOR TCustomer.Create;
BEGIN
  FAddress  := STRING.Empty;
  FContact  := STRING.Empty;
  FEmail    := STRING.Empty;
  FName     := STRING.Empty;
END;

FUNCTION TCustomer.GetAddressExcel: STRING;
BEGIN
  Result := Address.Replace(cCarriageReturn, STRING.Empty);
END;

INITIALIZATION
  RegisterEntity(TCustomer);

END.
