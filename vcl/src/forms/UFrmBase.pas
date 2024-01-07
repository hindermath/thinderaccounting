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

  , Aurelius.Engine.ObjectManager

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
    FObjectManager: TObjectManager;
    function GetObjectManager: TObjectManager;
    procedure SetObjectManager(const Value: TObjectManager);
  public
    property DataManager: TDataManager read FDataManager write FDataManager;
    property ObjectManager: TObjectManager read GetObjectManager write SetObjectManager;
    property OwnsObjectManager: Boolean read FOwnsObjectManager write FOwnsObjectManager;
    property StoreControls: Boolean read FStoreControls write FStoreControls;
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

function TFrmBase.GetObjectManager: TObjectManager;
begin
//  Result := ;
  // TODO -cMM: TFrmBase.GetObjectManager default body inserted
end;

procedure TFrmBase.SetObjectManager(const Value: TObjectManager);
begin
  // TODO -cMM: TFrmBase.SetObjectManager default body inserted
end;

end.
