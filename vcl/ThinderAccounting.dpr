program ThinderAccounting;

uses
  Vcl.Forms,
  Vcl.Dialogs,
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
    MessageDlg(
      '''
      Cannot launch application. Please check
      that database cnfiguration
      exists in settings.ini
      ''',
      TMsgDlgType.mtError,
      [mbOK],
      0
    );
  end;
end.
