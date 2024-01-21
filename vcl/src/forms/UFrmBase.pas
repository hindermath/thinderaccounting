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
UNIT UFrmBase;

INTERFACE

USES
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
  , UAppGlobals

  , Aurelius.Engine.ObjectManager

  ;

TYPE
  TFrmBase = CLASS(TForm)
    CONSTRUCTOR FormCreate(Sender: TObject);
    DESTRUCTOR FormDestroy(Sender: TObject);
  private
    FOwnsObjectManager: Boolean;
    FStoreControls: Boolean;
    { Private-Deklarationen }
  protected
    FDataManager: TDataManager;
    FObjectManager: TObjectManager;
    FUNCTION GetObjectManager: TObjectManager;
    PROCEDURE SetObjectManager(CONST Value: TObjectManager);
  public
    PROPERTY DataManager: TDataManager read FDataManager write FDataManager;
    PROPERTY ObjectManager: TObjectManager read GetObjectManager write SetObjectManager;
    PROPERTY OwnsObjectManager: Boolean read FOwnsObjectManager;
    PROPERTY StoreControls: Boolean read FStoreControls write FStoreControls;
    { Public-Deklarationen }
  END;

VAR
  FrmBase: TFrmBase;

IMPLEMENTATION

{$R *.dfm}

CONSTRUCTOR TFrmBase.FormCreate(Sender: TObject);
BEGIN
  INHERITED;

  IF self.Caption = STRING.Empty THEN
    Caption := TAppGlobals.AppFullName;

  FDataManager := TDataManager.Shared;
  FObjectManager := NIL;
  FOwnsObjectManager := False;
END;

DESTRUCTOR TFrmBase.FormDestroy(Sender: TObject);
BEGIN
  IF FOwnsObjectManager THEN
    FObjectManager.Free;

  INHERITED;
END;

FUNCTION TFrmBase.GetObjectManager: TObjectManager;
BEGIN
  IF NOT Assigned( FObjectManager ) THEN
  BEGIN
    FObjectManager := DataManager.ObjectManager;
    FOwnsObjectManager := True;
  END;
  Result := FObjectManager;
END;

PROCEDURE TFrmBase.SetObjectManager(CONST Value: TObjectManager);
BEGIN
  IF Assigned( Value ) THEN
  BEGIN
    FObjectManager.Free;
    FObjectManager := Value;
    FOwnsObjectManager := False;
  END;
END;

END.
