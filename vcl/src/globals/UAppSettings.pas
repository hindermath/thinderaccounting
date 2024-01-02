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
UNIT UAppSettings;

INTERFACE

USES
    System.Classes
  , System.SysUtils
  , System.Generics.Collections
  , System.IniFiles
  ;

TYPE
  TAppSettings = CLASS
    strict private
      CLASS VAR FInstance: TAppSettings;

    FIniFileName: STRING;
    FIniFile: TIniFile;

    public

      CONSTRUCTOR Create;
      DESTRUCTOR Destroy; override;

      FUNCTION IsLaunchPossible: Boolean;

      PROCEDURE GetDatabaseParams( AParams: TStrings );

      FUNCTION WebserviceBaseUrl: STRING;

      CLASS FUNCTION Shared: TAppSettings;
      CLASS DESTRUCTOR Destroy;

  END;

IMPLEMENTATION

USES
    System.IOUtils
  ;


CONST
  SECTION_DATABASE = 'Database';

{ TAppSettings }

CONSTRUCTOR TAppSettings.Create;
BEGIN
  INHERITED;

  FIniFilename := TPath.Combine( TPath.GetLibraryPath, 'settings.ini' );

  FIniFile := TIniFile.Create(FIniFilename);
END;

CLASS DESTRUCTOR TAppSettings.Destroy;
BEGIN
  FInstance.Free;
END;


PROCEDURE TAppSettings.GetDatabaseParams(AParams: TStrings);
VAR
  LParams: TStrings;

BEGIN
  LParams := TStringlist.Create;
  TRY
    FIniFile.ReadSectionValues(SECTION_DATABASE, LParams);

    LParams.Text := LParams.Text.Replace('{APP}', TPath.GetLibraryPath );
    LParams.Text := LParams.Text.Replace('{HOME}', TPath.GetHomePath );
    LParams.Text := LParams.Text.Replace('{DOCUMENTS}', TPath.GetDocumentsPath );

    AParams.Text := LParams.Text;
  FINALLY
    LParams.Free;
  END;
END;

FUNCTION TAppSettings.IsLaunchPossible: Boolean;
VAR
  LParams: TStringlist;

BEGIN
  Result := False;

  // quick sanity test that database configuration exists
  LParams := TStringList.Create;
  TRY
    FIniFile.ReadSectionValues(SECTION_DATABASE, LParams);
    Result := LParams.Count > 0;
  FINALLY
    LParams.Free;
  END;
END;

DESTRUCTOR TAppSettings.Destroy;
BEGIN
  FIniFile.Free;

  INHERITED;
END;

CLASS FUNCTION TAppSettings.Shared: TAppSettings;
BEGIN
  IF NOT Assigned( FInstance ) THEN
  BEGIN
    FInstance := TAppSettings.Create;
  END;

  Result := FInstance;
END;

FUNCTION TAppSettings.WebserviceBaseUrl: STRING;
BEGIN
  Result := FIniFile.ReadString('API', 'BaseURL', '' );
END;

END.
