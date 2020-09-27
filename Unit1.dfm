object IWForm1: TIWForm1
  Left = 0
  Top = 0
  Width = 555
  Height = 400
  RenderInvisibleControls = True
  AllowPageAccess = True
  ConnectionMode = cmAny
  Background.Fixed = False
  HandleTabs = False
  LeftToRight = True
  LockUntilLoaded = True
  LockOnSubmit = True
  ShowHint = True
  XPTheme = True
  DesignLeft = 8
  DesignTop = 8
  object IWEdit1: TIWEdit
    Left = 168
    Top = 280
    Width = 121
    Height = 21
    StyleRenderOptions.RenderBorder = False
    Font.Color = clNone
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'IWEdit1'
    SubmitOnAsyncEvent = True
    TabOrder = 0
    Text = 'IWEdit1'
  end
  object ZQuery1: TZQuery
    Connection = ZConnection1
    Params = <>
    Left = 240
    Top = 184
  end
  object cd_Conexao: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 144
    Top = 96
    object cd_Conexaohost: TStringField
      FieldName = 'host'
    end
  end
  object ZConnection1: TZConnection
    Left = 256
    Top = 88
  end
end
