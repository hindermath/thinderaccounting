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
unit UDocument;

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
  TDocument = class
  private
    FId: Integer;
    [Column('Document', [TColumnProp.Lazy])]
    FDocument: TBlob;
    FOriginalFilename: String;

    function GetKeyFilename: String;

  public
    property Id: Integer read FId write FId;
    property Document: TBlob read FDocument write FDocument;
    property OriginalFilename: String
      read FOriginalFilename
      write FOriginalFilename;
    property KeyFilename: String read GetKeyFilename;

  end;

implementation
uses
  System.IOUtils
  ;

function TDocument.GetKeyFilename: String;
begin
  Result := TPath.GetFileNameWithoutExtension(FOriginalFilename);
end;

initialization
  RegisterEntity(TDocument);

end.
