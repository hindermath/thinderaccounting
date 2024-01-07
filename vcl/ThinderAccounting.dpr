program ThinderAccounting;

uses
  System.UITypes,
  Vcl.Forms,
  Vcl.Dialogs,
  UFrmMain in 'src\forms\UFrmMain.pas' {FrmMain},
  UAppGlobals in 'src\globals\UAppGlobals.pas',
  UAppSettings in 'src\globals\UAppSettings.pas',
  UDataManager in 'src\dbmgr\UDataManager.pas' {DataManager: TDataModule},
  UControlStorage in 'src\tools\UControlStorage.pas',
  UFrmBase in 'src\forms\UFrmBase.pas' {FrmBase};

{$R *.res}

begin
  if TAppSettings.Shared.IsLaunchPossible then
  begin
    Application.Initialize;
    Application.MainFormOnTaskbar := True;
    Application.CreateForm(TFrmMain, FrmMain);
  Application.CreateForm(TFrmBase, FrmBase);
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
