unit UFrmMain;

interface

uses
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

type
  TForm1 = class(TForm)
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
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

end.
