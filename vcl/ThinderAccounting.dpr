program ThinderAccounting;

uses
  Winapi.Messages,
  Vcl.Forms,
  UFrmMain in 'src\forms\UFrmMain.pas' {Form1},
  UAppGlobals in 'src\globals\UAppGlobals.pas',
  UAppSettings in 'src\globals\UAppSettings.pas';

{$R *.res}

begin
  if TAppSettings.Shared.IsLaunchPossible then
  begin
    Application.Initialize;
    Application.MainFormOnTaskbar := True;
    Application.CreateForm(TForm1, Form1);
    Application.Run;
  end
  else
  begin

  end;
end.
