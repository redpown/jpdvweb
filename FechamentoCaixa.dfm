object IWFechamentoCaixa: TIWFechamentoCaixa
  Left = 0
  Top = 0
  Width = 555
  Height = 400
  RenderInvisibleControls = True
  AllowPageAccess = True
  ConnectionMode = cmAny
  Background.Fixed = False
  LayoutMgr = IWTemplateProcessorHTMLFechamentoCaixa
  HandleTabs = False
  LeftToRight = True
  LockUntilLoaded = True
  LockOnSubmit = True
  ShowHint = True
  XPTheme = True
  JavaScript.Strings = (
    '       $(function(){'
    '        $('#39'#calendario'#39').datepicker({'
    
      '                          buttonImage: "calendario.png",    // a' +
      'dicionamos a url da imagem'
    '                          showOn: "button",'
    '                          buttonImageOnly: true,'
    '                          dateFormat: '#39'yy-mm-dd'#39','
    '              showOtherMonths: true,'
    '              selectOtherMonths: true,'
    
      '              dayNames: ['#39'Domingo'#39','#39'Segunda'#39','#39'Ter'#231'a'#39','#39'Quarta'#39','#39'Q' +
      'uinta'#39','#39'Sexta'#39','#39'S'#225'bado'#39','#39'Domingo'#39'],'
    '              dayNamesMin: ['#39'D'#39','#39'S'#39','#39'T'#39','#39'Q'#39','#39'Q'#39','#39'S'#39','#39'S'#39','#39'D'#39'],'
    
      '              dayNamesShort: ['#39'Dom'#39','#39'Seg'#39','#39'Ter'#39','#39'Qua'#39','#39'Qui'#39','#39'Sex' +
      #39','#39'S'#225'b'#39','#39'Dom'#39'],'
    
      '              monthNames: ['#39'Janeiro'#39','#39'Fevereiro'#39','#39'Mar'#231'o'#39','#39'Abril'#39 +
      ','#39'Maio'#39','#39'Junho'#39','#39'Julho'#39','#39'Agosto'#39','#39'Setembro'#39','#39'Outubro'#39','#39'Novembro'#39 +
      ','#39'Dezembro'#39'],'
    
      '              monthNamesShort: ['#39'Jan'#39','#39'Fev'#39','#39'Mar'#39','#39'Abr'#39','#39'Mai'#39','#39'J' +
      'un'#39','#39'Jul'#39','#39'Ago'#39','#39'Set'#39','#39'Out'#39','#39'Nov'#39','#39'Dez'#39']'
    '                });'
    '       });')
  DesignLeft = 2
  DesignTop = 2
  object IWTemplateProcessorHTMLFechamentoCaixa: TIWTemplateProcessorHTML
    TagType = ttIntraWeb
    Templates.Default = 'PageRenderFechamentoCaixa.html'
    OnUnknownTag = IWTemplateProcessorHTMLFechamentoCaixaUnknownTag
    Left = 320
    Top = 240
  end
end
