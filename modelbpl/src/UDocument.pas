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
UNIT UDocument;

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
  TDocument = CLASS
  private
    FId: Integer;
    [Column('Document', [TColumnProp.Lazy])]
    FDocument: TBlob;
    FOriginalFilename: STRING;

    FUNCTION GetKeyFilename: STRING;

  public
    PROPERTY Id: Integer read FId write FId;
    PROPERTY Document: TBlob read FDocument write FDocument;
    PROPERTY OriginalFilename: STRING
      read FOriginalFilename
      write FOriginalFilename;
    PROPERTY KeyFilename: STRING read GetKeyFilename;

  END;

IMPLEMENTATION
USES
  System.IOUtils
  ;

FUNCTION TDocument.GetKeyFilename: STRING;
BEGIN
  Result := TPath.GetFileNameWithoutExtension(FOriginalFilename);
END;

INITIALIZATION
  RegisterEntity(TDocument);

END.
