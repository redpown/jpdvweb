object IWFuncionarios: TIWFuncionarios
  Left = 0
  Top = 0
  Width = 555
  Height = 400
  RenderInvisibleControls = True
  AllowPageAccess = True
  ConnectionMode = cmAny
  ExtraHeader.Strings = (
    '')
  Background.Fixed = False
  LayoutMgr = IWTemplateProcessorHTMLFuncionarios
  HandleTabs = False
  LeftToRight = True
  LockUntilLoaded = True
  LockOnSubmit = True
  ShowHint = True
  XPTheme = True
  DesignLeft = 2
  DesignTop = 2
  object IWButton1: TIWButton
    Left = 168
    Top = 272
    Width = 75
    Height = 25
    LockOnAsyncEvents = [aeDoubleClick]
    Caption = 'IWButton1'
    DoSubmitValidation = False
    Color = clBtnFace
    Font.Color = clNone
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'IWButton1'
    TabOrder = 0
    OnClick = IWButton1Click
  end
  object IWTemplateProcessorHTMLFuncionarios: TIWTemplateProcessorHTML
    TagType = ttIntraWeb
    Templates.Default = 'PageRenderFuncionarios.html'
    OnUnknownTag = IWTemplateProcessorHTMLFuncionariosUnknownTag
    Left = 224
    Top = 136
  end
end
