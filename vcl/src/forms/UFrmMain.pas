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
 , System.ImageList
 , System.Actions

 , Bcl.Types.Nullable
 , Data.DB
 , FolderDialog

 , Vcl.Graphics
 , Vcl.Controls
 , Vcl.Forms
 , Vcl.Dialogs
 , Vcl.Grids
 , Vcl.DBGrids
 , Vcl.BaseImageCollection
 , Vcl.ImageCollection
 , Vcl.ImgList
 , Vcl.VirtualImageList
 , Vcl.StdCtrls
 , Vcl.PlatformDefaultStyleActnCtrls
 , Vcl.ActnList
 , Vcl.ActnMan

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

 , UFrmBase

  ;

TYPE
  TFrmMain = CLASS(TFrmBase)
    Images: TVirtualImageList;
    Collection: TImageCollection;
    ImagesDisabled: TVirtualImageList;
    Actions: TActionManager;
    btnCustomers: TButton;
    btnTransactions: TButton;
    btnInvoices: TButton;
    btnReports: TButton;
    btnApiaccess: TButton;
    SelectFolder: TFolderDialog;
    btnCreateDictionary: TButton;
    btnCreateDB: TButton;
    actCustomers: TAction;
    actTransactions: TAction;
    actInvoices: TAction;
    actReports: TAction;
    actApiaccess: TAction;
    procedure FormShow(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  END;

VAR
  FrmMain: TFrmMain;

IMPLEMENTATION

{$R *.dfm}

procedure TFrmMain.FormShow(Sender: TObject);
begin
  self.BorderStyle := bsDialog;
  self.ClientWidth := btnApiaccess.Left + btnApiaccess.Width + 10;
  self.ClientHeight := btnCreateDictionary.Top - 10;
end;

END.
