program ThinderAccounting;

uses
  Vcl.Forms,
  UFrmMain in 'src\forms\UFrmMain.pas' {Form1},
  UAppGlobals in 'src\globals\UAppGlobals.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
