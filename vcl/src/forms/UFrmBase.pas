unit UFrmBase;

interface

uses
    Winapi.Windows
  , Winapi.Messages

  , System.SysUtils
  , System.Variants
  , System.Classes

  , Vcl.Graphics
  , Vcl.Controls
  , Vcl.Forms
  , Vcl.Dialogs

  , UDataManager

  ;

type
  TFrmBase = class(TForm)
    constructor FormCreate(Sender: TObject);
    destructor FormDestroy(Sender: TObject);
  private
    FOwnsObjectManager: Boolean;
    FStoreControls: Boolean;
    { Private-Deklarationen }
  protected
    FDataManager: TDataManager;
  public
    { Public-Deklarationen }
  end;

var
  FrmBase: TFrmBase;

implementation

{$R *.dfm}

constructor TFrmBase.FormCreate(Sender: TObject);
begin
  inherited;
  // TODO -cMM: TFrmBase.FormCreate default body inserted
end;

destructor TFrmBase.FormDestroy(Sender: TObject);
begin
  inherited;
  // TODO -cMM: TFrmBase.FormDestroy default body inserted
end;

end.
