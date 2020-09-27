object IWDashboard: TIWDashboard
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
  LayoutMgr = IWTemplateProcessorHTMLDashboard
  HandleTabs = False
  LeftToRight = True
  LockUntilLoaded = True
  LockOnSubmit = True
  ShowHint = True
  XPTheme = True
  DesignLeft = 2
  DesignTop = 2
  object IWTemplateProcessorHTMLDashboard: TIWTemplateProcessorHTML
    TagType = ttIntraWeb
    Templates.Default = 'PageRenderDashboard.html'
    OnUnknownTag = IWTemplateProcessorHTMLDashboardUnknownTag
    Left = 280
    Top = 168
  end
end
