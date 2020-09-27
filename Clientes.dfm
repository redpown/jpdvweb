object IWClientes: TIWClientes
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
  LayoutMgr = IWTemplateProcessorHTMLClientes
  HandleTabs = False
  LeftToRight = True
  LockUntilLoaded = True
  LockOnSubmit = True
  ShowHint = True
  XPTheme = True
  DesignLeft = 2
  DesignTop = 2
  object IWTemplateProcessorHTMLClientes: TIWTemplateProcessorHTML
    TagType = ttIntraWeb
    Templates.Default = 'PageRenderClientes.html'
    OnUnknownTag = IWTemplateProcessorHTMLClientesUnknownTag
    Left = 152
    Top = 216
  end
end
