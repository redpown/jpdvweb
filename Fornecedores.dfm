object IWFornecedores: TIWFornecedores
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
  LayoutMgr = IWTemplateProcessorHTMLFornecedores
  HandleTabs = False
  LeftToRight = True
  LockUntilLoaded = True
  LockOnSubmit = True
  ShowHint = True
  XPTheme = True
  DesignLeft = 2
  DesignTop = 2
  object IWTemplateProcessorHTMLFornecedores: TIWTemplateProcessorHTML
    TagType = ttIntraWeb
    Templates.Default = 'PageRenderFornecedores.html'
    OnUnknownTag = IWTemplateProcessorHTMLFornecedoresUnknownTag
    Left = 272
    Top = 208
  end
end
