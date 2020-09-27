unit Funcionarios;

interface

uses
  Classes, SysUtils, IWAppForm, IWApplication, IWColor, IWTypes, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML, Controls,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWCompButton;

type
  TIWFuncionarios = class(TIWAppForm)
    IWTemplateProcessorHTMLFuncionarios: TIWTemplateProcessorHTML;
    IWButton1: TIWButton;
    procedure IWTemplateProcessorHTMLFuncionariosUnknownTag(const AName: string;
      var VValue: string);
    procedure IWButton1Click(Sender: TObject);
  public
  end;

implementation

{$R *.dfm}

uses
RenderHtml,ServerController;

procedure TIWFuncionarios.IWButton1Click(Sender: TObject);
begin
       WebApplication.ShowMessage('ok', smAlert );
         AddToInitProc('console.log("deucerto")');
end;

procedure TIWFuncionarios.IWTemplateProcessorHTMLFuncionariosUnknownTag(
  const AName: string; var VValue: string);
begin
  if AName = 'RenderHtmlHead' then
  begin
    VValue := RenderHtml.RenderHead('JPDV Funcionários');
  end;

  if AName = 'RenderHtmlHeader' then
  begin
    VValue := RenderHtml.RenderHeader('JJA','JJA Consulting','assets/images/faces/face8.jpg','assets/images/logo.png','jjapdv@jjaconsulting.com.br','Master' );
  end;

 if AName = 'RenderHtmlFooter' then
 begin
        VValue := RenderHtml.RenderFooter('<script src="assets/js/jpdvweb_Upload_Image.js"></script>');
 end;
end;

end.
