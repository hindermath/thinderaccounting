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
unit UCustomer;

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

 ;

type
  [Entity]
  [Automapping]
  TCustomer = class
  private
    FId: Integer;
    [Column('Address',[], 2048)]
    FAddress: String;
    FContact: String;
    FEmail: String;
    [Column('Name', [TColumnProp.Unique])]
    FName: String;

    function GetAddressExcel: String;

  public
    constructor Create;

    property Id: Integer read FId write FId;
    property Address: String read FAddress write FAddress;
    property Contact: String read FContact write FContact;
    property EMail: String read FEmail write FEmail;
    property Name: String read FName write FName;
    property AddressExcel: String read GetAddressExcel;

  end;

implementation
const
  cCarriageReturn = #13;

constructor TCustomer.Create;
begin
  FAddress  := String.Empty;
  FContact  := String.Empty;
  FEmail    := String.Empty;
  FName     := String.Empty;
end;

function TCustomer.GetAddressExcel: string;
begin
  Result := Address.Replace(cCarriageReturn, String.Empty);
end;

initialization
  RegisterEntity(TCustomer);

end.
