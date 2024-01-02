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
UNIT UAppGlobals;

INTERFACE

TYPE
  TAppGlobals = CLASS
  public
    CLASS FUNCTION AppTitle: STRING;
    CLASS FUNCTION AppVersion: STRING;
    CLASS FUNCTION AppFullName: STRING;

    CLASS FUNCTION DefaultGridHeaderFontSize: Integer;
    CLASS FUNCTION DefaultGridFontSize: Integer;

    CLASS FUNCTION DefaultGridHeaderFontName: STRING;
    CLASS FUNCTION DefaultGridMonospaceFontName: STRING;
    CLASS FUNCTION DefaultGridFontName: STRING;

    CLASS FUNCTION UserName: STRING;
  END;

IMPLEMENTATION

USES
   ExeInfo
   ;

{ TAppGlobals }

CLASS FUNCTION TAppGlobals.AppFullName: STRING;
BEGIN
  Result := AppTitle + ' (' + AppVersion + ')';
END;

CLASS FUNCTION TAppGlobals.AppTitle: STRING;
VAR
  LExeInfo: TExeInfo;

BEGIN
  Result := '';

  LExeInfo := TExeInfo.Create(NIL);
  TRY
    Result := LExeInfo.ProductName;
  FINALLY
    LExeInfo.Free;
  END;
END;

CLASS FUNCTION TAppGlobals.AppVersion: STRING;
VAR
  LExeInfo: TExeInfo;

BEGIN
  Result := '';

  LExeInfo := TExeInfo.Create(NIL);
  TRY
    Result := LExeInfo.FileVersion;
  FINALLY
    LExeInfo.Free;
  END;
END;

CLASS FUNCTION TAppGlobals.DefaultGridFontName: STRING;
BEGIN
  Result := 'Noto Sans'
END;

CLASS FUNCTION TAppGlobals.DefaultGridFontSize: Integer;
BEGIN
  Result := 11;
END;

CLASS FUNCTION TAppGlobals.DefaultGridHeaderFontName: STRING;
BEGIN
  Result := 'Arial';
END;

CLASS FUNCTION TAppGlobals.DefaultGridHeaderFontSize: Integer;
BEGIN
  Result := 12;
END;

CLASS FUNCTION TAppGlobals.DefaultGridMonospaceFontName: STRING;
BEGIN
 Result := 'Cascadia Code';
END;

CLASS FUNCTION TAppGlobals.UserName: STRING;
VAR
  LExeInfo: TExeInfo;

BEGIN
  Result := '';

  LExeInfo := TExeInfo.Create(NIL);
  TRY
    Result := LExeInfo.UserName;
  FINALLY
    LExeInfo.Free;
  END;
END;
END.
