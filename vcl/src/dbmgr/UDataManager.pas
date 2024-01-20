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
UNIT UDataManager;

INTERFACE

USES
    System.SysUtils
  , System.Classes

  , System.IOUtils

  , Data.DB

  , Aurelius.Drivers.Interfaces
  , Aurelius.Drivers.SQLite
  , Aurelius.Drivers.FireDac
  , Aurelius.Sql.MySQL
  , Aurelius.Schema.MySQL
  , Aurelius.Sql.SQLite
  , Aurelius.Sql.Register
  , Aurelius.Engine.DatabaseManager
  , Aurelius.Engine.ObjectManager
  , Aurelius.Comp.Connection
  , Aurelius.Mapping.Explorer

  , FireDAC.Phys.MySQLDef
  , FireDAC.Stan.Intf
  , FireDAC.Phys
  , FireDAC.Phys.MySQL
  , FireDAC.Stan.Option
  , FireDAC.Stan.Error
  , FireDAC.UI.Intf
  , FireDAC.Phys.Intf
  , FireDAC.Stan.Def
  , FireDAC.Stan.Pool
  , FireDAC.Stan.Async
  , FireDAC.VCLUI.Wait
  , FireDAC.Comp.Client
  , FireDAC.Stan.ExprFuncs
  , FireDAC.Phys.SQLiteWrapper.Stat
  , FireDAC.Phys.SQLiteDef
  , FireDAC.Phys.SQLite

  ;

TYPE
  TDataManager = class(TDataModule)
    Connection: TAureliusConnection;
    FDConnection: TFDConnection;
    SQLiteUnits: TFDPhysSQLiteDriverLink;

    MemConnection: TAureliusConnection;

    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    FMemoryConnection: IDBConnection;

    function GetConnection: IDBConnection;
    function GetDatabaseManager: TDatabaseManager;
    function GetObjectManager: TObjectManager;
    function GetMemoryObjectManager: TObjectManager;
  strict private
    class var FInstance: TDataManager;

  public
    { Public declarations }
    class destructor Destroy;
    class function Shared: TDataManager;

    procedure CreateDatabase;
    procedure UpdateDatabase;

    procedure CreateTemporaryDatabase;

    property DatabaseManager: TDatabaseManager read GetDatabaseManager;
    property ObjectManager: TObjectManager read GetObjectManager;

    property MemoryObjectManager: TObjectManager read GetMemoryObjectManager;
  end;

var
  DataManager: TDataManager;


IMPLEMENTATION
USES
  UAppSettings
  ;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

FUNCTION TDataManager.GetConnection: IDBConnection;
BEGIN
  Result := Connection.CreateConnection;
END;

FUNCTION TDataManager.GetDatabaseManager: TDatabaseManager;
BEGIN
  Result := TDatabaseManager.Create(GetConnection);
END;

PROCEDURE TDataManager.CreateDatabase;
BEGIN
  {$IFDEF DEBUG}
  VAR LDatabaseManager := DatabaseManager;
  TRY
    LDatabaseManager.DestroyDatabase;
    LDatabaseManager.BuildDatabase;
  FINALLY
    LDatabaseManager.Free;
  END;
  {$ENDIF}
END;

PROCEDURE TDataManager.UpdateDatabase;
VAR
  LDatabaseManager: TDatabaseManager;
BEGIN
  LDatabaseManager := DatabaseManager;
  TRY
    LDatabaseManager.UpdateDatabase;
  FINALLY
    LDatabaseManager.Free;
  END;
END;

PROCEDURE TDataManager.CreateTemporaryDatabase;
BEGIN
  VAR LDataBase := TDatabaseManager.Create(
    FMemoryConnection,
    TMappingExplorer.Get('Temporary')
  );
  TRY
    LDataBase.BuildDatabase;
  FINALLY
    LDataBase.Free;
  END;
END;

PROCEDURE TDataManager.DataModuleCreate(Sender: TObject);
BEGIN
  TAppSettings.Shared.GetDatabaseParams(FDConnection.Params);

  Connection.AdaptedConnection := FDConnection;

  FMemoryConnection := MemConnection.CreateConnection;
  CreateTemporaryDatabase;
END;

function TDataManager.GetObjectManager: TObjectManager;
begin
  Result := TObjectManager.Create(GetConnection);
end;

function TDataManager.GetMemoryObjectManager: TObjectManager;
begin
  Result := TObjectManager.Create(GetConnection);
end;

class destructor TDataManager.Destroy;
begin
    FInstance.Free;
end;

class function TDataManager.Shared: TDataManager;
begin
  if not Assigned( FInstance ) then
    FInstance := TDataManager.Create(nil);

  Result := FInstance;
end;

END.
