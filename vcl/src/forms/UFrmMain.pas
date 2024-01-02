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
UNIT UFrmMain;

INTERFACE

USES
   Winapi.Windows
 , Winapi.Messages

 , System.SysUtils
 , System.Variants
 , System.Classes
 , System.Generics.Collections

 , Bcl.Types.Nullable
 , Data.DB

 , Vcl.Graphics
 , Vcl.Controls
 , Vcl.Forms
 , Vcl.Dialogs
 , Vcl.Grids
 , Vcl.DBGrids

 , FireDAC.Stan.ExprFuncs
 , FireDAC.Phys.SQLiteWrapper.Stat
 , FireDAC.Phys.SQLiteDef
 , FireDAC.Stan.Intf
 , FireDAC.Stan.Option
 , FireDAC.Stan.Error
 , FireDAC.UI.Intf
 , FireDAC.Phys.Intf
 , FireDAC.Stan.Def
 , FireDAC.Stan.Pool
 , FireDAC.Stan.Async
 , FireDAC.Phys
 , FireDAC.VCLUI.Wait
 , FireDAC.Comp.Client
 , FireDAC.Phys.SQLite

 , Aurelius.Bind.BaseDataset
 , Aurelius.Bind.Dataset

  ;

TYPE
  TForm1 = CLASS(TForm)
    Documents: TAureliusDataset;
    DocumentsSelf: TAureliusEntityField;
    DocumentsId: TIntegerField;
    DocumentsDocument: TBlobField;
    DocumentsOriginalFilename: TStringField;
    DocumentsKeyFilename: TStringField;
    sourceDocuments: TDataSource;
    DocumentGrid: TDBGrid;
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  END;

VAR
  Form1: TForm1;

IMPLEMENTATION

{$R *.dfm}

END.
