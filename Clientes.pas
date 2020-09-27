unit Clientes;

interface

uses
  Classes, SysUtils, IWAppForm, IWApplication, IWColor, IWTypes, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML;

type
  TIWClientes = class(TIWAppForm)
    IWTemplateProcessorHTMLClientes: TIWTemplateProcessorHTML;
    procedure IWTemplateProcessorHTMLClientesUnknownTag(const AName: string;
      var VValue: string);
  public
  end;

implementation

{$R *.dfm}
uses
RenderHtml,ServerController;

procedure TIWClientes.IWTemplateProcessorHTMLClientesUnknownTag(
  const AName: string; var VValue: string);
begin
  if AName = 'RenderHtmlHead' then
  begin
    VValue := RenderHtml.RenderHead('JPDV Clientes');
  end;

  if AName = 'RenderHtmlHeader' then
  begin
    VValue := RenderHtml.RenderHeader('JJA','JJA Consulting','assets/images/faces/face8.jpg','assets/images/logo.png','jjapdv@jjaconsulting.com.br','Master' );
  end;

  if AName = 'RenderHtmlFooter' then
  begin
    VValue := RenderHtml.RenderFooter;
  end;
end;

end.
