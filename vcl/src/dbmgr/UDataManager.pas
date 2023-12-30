unit UDataManager;

interface

uses
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

type
  TDataManager = class(TDataModule)
    Connection: TAureliusConnection;
    FDConnection: TFDConnection;

    SQLiteUnits: TFDPhysSQLiteDriverLink;

    MemConnection: TAureliusConnection;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private-Deklarationen }
    FMemoryConnection: IDBConnection;

    function GetConnection: IDBConnection;
    function GetDatabaseManager: TDatabaseManager;
  public
    { Public-Deklarationen }
    procedure CreateDatabase;
    procedure UpdateDatabase;

    procedure CreateTemporaryDatabase;

    property DatabaseManager: TDatabaseManager read GetDatabaseManager;
  end;

var
  DataManager: TDataManager;

implementation
uses
  UAppSettings
  ;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

function TDataManager.GetConnection: IDBConnection;
begin
  Result := Connection.CreateConnection;
end;

function TDataManager.GetDatabaseManager: TDatabaseManager;
begin
  Result := TDatabaseManager.Create(GetConnection);
end;

procedure TDataManager.CreateDatabase;
begin
  {$IFDEF DEBUG}
  var LDatabaseManager := DatabaseManager;
  try
    LDatabaseManager.DestroyDatabase;
    LDatabaseManager.BuildDatabase;
  finally
    LDatabaseManager.Free;
  end;
  {$ENDIF}
end;

procedure TDataManager.UpdateDatabase;
var
  LDatabaseManager: TDatabaseManager;
begin
  LDatabaseManager := DatabaseManager;
  try
    LDatabaseManager.UpdateDatabase;
  finally
    LDatabaseManager.Free;
  end;
end;

procedure TDataManager.CreateTemporaryDatabase;
begin
  var LDataBase := TDatabaseManager.Create(
    FMemoryConnection,
    TMappingExplorer.Get('Temporary')
  );
  try
    LDataBase.BuildDatabase;
  finally
    LDataBase.Free;
  end;
end;

procedure TDataManager.DataModuleCreate(Sender: TObject);
begin
  TAppSettings.Shared.GetDatabaseParams(FDConnection.Params);

  Connection.AdaptedConnection := FDConnection;

  FMemoryConnection := MemConnection.CreateConnection;
  CreateTemporaryDatabase;
end;

end.
