unit UGridUtils;

interface
uses
    System.Classes
  , DBAdvGrid
  , Vcl.DBGrids
  , Vcl.Graphics
  , Vcl.Forms
  ;

type
  TGridUtils = class
    public
      class procedure UseDefaultHeaderFont(ACollection: TCollection);
      class procedure UseDefaultFont(ACollection: TCollection);

      class procedure UseMonospaceFont(ACollection: TCollection); overload;
      class procedure UseMonospaceFont(AColumn: TColumn); overload;
      class procedure UseMonospaceFont(AColumn: TDBGridColumnItem); overload;

      class procedure UseDefaultFonts(const AForm: TForm);
      class procedure UseMonospaceFonts(const AForm: TForm);
  end;

implementation
uses
  UAppGlobals
  ;

class procedure TGridUtils.UseDefaultHeaderFont(ACollection: TCollection);
begin
  for var LColumn in ACollection do
  begin
    if LColumn is TDBGridColumnItem then
    begin
      var LGridColumn := LColumn as TDBGridColumnItem;

      LGridColumn.HeaderFont.Name := TAppGlobals.DefaultGridHeaderFontName;
      LGridColumn.HeaderFont.Size := TAppGlobals.DefaultGridHeaderFontSize;
      LGridColumn.HeaderFont.Style := [TFontStyle.fsBold];
    end;

    if LColumn is TColumn then
    begin
      var LGridColumn := LColumn as TColumn;

      LGridColumn.Title.Font.Name := TAppGlobals.DefaultGridHeaderFontName;
      LGridColumn.Title.Font.Size := TAppGlobals.DefaultGridHeaderFontSize;
      LGridColumn.Title.Font.Style := [TFontStyle.fsBold];
    end;
  end;
end;

class procedure TGridUtils.UseDefaultFont(ACollection: TCollection);
begin

end;

class procedure TGridUtils.UseMonospaceFont(ACollection: TCollection);
begin

end;

class procedure TGridUtils.UseMonospaceFont(AColumn: TColumn);
begin

end;

class procedure TGridUtils.UseMonospaceFont(AColumn: TDBGridColumnItem);
begin

end;

class procedure TGridUtils.UseDefaultFonts(const AForm: TForm);
begin

end;

class procedure TGridUtils.UseMonospaceFonts(const AForm: TForm);
begin

end;
end.
