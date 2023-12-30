object DataManager: TDataManager
  Height = 422
  Width = 399
  PixelsPerInch = 144
  object FDConnection: TFDConnection
    Params.Strings = (
      'DriverID=SQLite')
    Left = 40
    Top = 176
  end
  object SQLiteUnits: TFDPhysSQLiteDriverLink
    Left = 40
    Top = 296
  end
  object Connection: TAureliusConnection
    AdapterName = 'FireDac'
    Left = 40
    Top = 32
  end
  object MemConnection: TAureliusConnection
    DriverName = 'SQLite'
    Params.Strings = (
      'Database=:memory:'
      'EnableForeignKeys=True')
    Left = 232
    Top = 32
  end
end
