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
  // TODO -cMM: UseDefaultHeaderFont default body inserted
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
