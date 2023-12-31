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
  object DocumentGrid: TDBGrid
    Left = 104
    Top = 48
    Width = 320
    Height = 120
    DataSource = sourceDocuments
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'Self'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Id'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Document'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'OriginalFilename'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'KeyFilename'
        Visible = True
      end>
  end
  object Documents: TAureliusDataset
    FieldDefs = <
      item
        Name = 'Self'
        Attributes = [faReadonly]
        DataType = ftVariant
      end
      item
        Name = 'Id'
        Attributes = [faReadonly, faRequired]
        DataType = ftInteger
      end
      item
        Name = 'Document'
        DataType = ftBlob
      end
      item
        Name = 'OriginalFilename'
        Attributes = [faRequired]
        DataType = ftString
        Size = 255
      end
      item
        Name = 'KeyFilename'
        Attributes = [faReadonly, faRequired]
        DataType = ftString
        Size = 255
      end>
    Left = 344
    Top = 200
    DesignClass = 'UDocument.TDocument'
    object DocumentsSelf: TAureliusEntityField
      FieldName = 'Self'
      ReadOnly = True
    end
    object DocumentsId: TIntegerField
      FieldName = 'Id'
      ReadOnly = True
      Required = True
    end
    object DocumentsDocument: TBlobField
      FieldName = 'Document'
    end
    object DocumentsOriginalFilename: TStringField
      FieldName = 'OriginalFilename'
      Required = True
      Size = 255
    end
    object DocumentsKeyFilename: TStringField
      FieldName = 'KeyFilename'
      ReadOnly = True
      Required = True
      Size = 255
    end
  end
  object sourceDocuments: TDataSource
    DataSet = Documents
    Left = 136
    Top = 216
  end
end
