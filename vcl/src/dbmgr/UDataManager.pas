unit UDataManager;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs, FireDAC.VCLUI.Wait,
  FireDAC.Phys.SQLiteWrapper.Stat, Aurelius.Drivers.FireDac,
  Aurelius.Drivers.SQLite, Aurelius.Comp.Connection, Data.DB,
  FireDAC.Comp.Client;

type
  TDataManager = class(TDataModule)
    FDConnection: TFDConnection;
    SQLiteUnits: TFDPhysSQLiteDriverLink;
    Connection: TAureliusConnection;
    MemConnection: TAureliusConnection;
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  DataManager: TDataManager;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
