object IWCaixa: TIWCaixa
  Left = 0
  Top = 0
  Width = 555
  Height = 400
  RenderInvisibleControls = True
  AllowPageAccess = True
  ConnectionMode = cmAny
  Background.Fixed = False
  LayoutMgr = IWTemplateProcessorHTMLCaixa
  HandleTabs = False
  LeftToRight = True
  LockUntilLoaded = True
  LockOnSubmit = True
  ShowHint = True
  XPTheme = True
  DesignLeft = 2
  DesignTop = 2
  object IWTemplateProcessorHTMLCaixa: TIWTemplateProcessorHTML
    TagType = ttIntraWeb
    Templates.Default = 'PageRenderCaixa.html'
    OnUnknownTag = IWTemplateProcessorHTMLCaixaUnknownTag
    Left = 224
    Top = 216
  end
end
