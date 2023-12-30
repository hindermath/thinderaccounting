object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 441
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object Connection: TAureliusConnection
    DriverName = 'MSSQL'
    Params.Strings = (
      'Server=LAPTOP-64643G0F\SQLEXPRESS'
      'Database=ThinderAccounting'
      'UserName=thinderacc'
      'Password=blackbox_48')
    Left = 88
    Top = 64
  end
  object MemConnection: TAureliusConnection
    DriverName = 'SQLite'
    Params.Strings = (
      
        'Database=C:\Users\hinde\OneDrive\Dokumente\Embarcadero\Studio\Pr' +
        'ojekte\thinderaccounting\bin\ThinderAccounting.db'
      'EnableForeignKeys=True')
    Left = 272
    Top = 64
  end
  object SQLiteUnits: TFDPhysSQLiteDriverLink
    Left = 320
    Top = 224
  end
  object FDConnection: TFDConnection
    Left = 80
    Top = 208
  end
end
