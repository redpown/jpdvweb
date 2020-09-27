object IWProdutos: TIWProdutos
  Left = 0
  Top = 0
  Width = 555
  Height = 400
  RenderInvisibleControls = True
  AllowPageAccess = True
  ConnectionMode = cmAny
  Background.Fixed = False
  LayoutMgr = IWTemplateProcessorHTMLProdutos
  HandleTabs = False
  LeftToRight = True
  LockUntilLoaded = True
  LockOnSubmit = True
  ShowHint = True
  XPTheme = True
  JavaScript.Strings = (
    'document.getElementById("files").onchange = function () {'
    '    var reader = new FileReader();'
    ''
    '    reader.onload = function (e) {'
    '        // get loaded data and render thumbnail.'
    '        document.getElementById("image").src = e.target.result;'
    '    };'
    ''
    '    // read the image file as a data URL.'
    '    reader.readAsDataURL(this.files[0]);'
    '};')
  DesignLeft = 2
  DesignTop = 2
  object IWTemplateProcessorHTMLProdutos: TIWTemplateProcessorHTML
    TagType = ttIntraWeb
    Templates.Default = 'PageRenderProdutos.html'
    OnUnknownTag = IWTemplateProcessorHTMLProdutosUnknownTag
    Left = 240
    Top = 224
  end
end
