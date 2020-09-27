unit Login;

interface

uses
  Classes, SysUtils, IWAppForm, IWApplication, IWColor, IWTypes, IWCompEdit, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWCompButton, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  Controls;

type
  TIWLogin = class(TIWAppForm)
    IWTemplateProcessorHTMLLogin: TIWTemplateProcessorHTML;
    IWBtnEntrar: TIWButton;
    IWEditUsuario: TIWEdit;
    IWEditSenha: TIWEdit;
    procedure IWBtnEntrarClick(Sender: TObject);
    procedure IWTemplateProcessorHTMLLoginUnknownTag(const AName: string; var VValue: string);
  public
  end;

implementation

{$R *.dfm}

uses
//precisa usar a unit do ServerController
ServerController;

procedure TIWLogin.IWBtnEntrarClick(Sender: TObject);
begin
  if IWEditUsuario.Text = IWEditSenha.Text then
  UserSession.Usuario  := 1 ;
  WebApplication.GoToUrl('/Dashboard');
end;
procedure TIWLogin.IWTemplateProcessorHTMLLoginUnknownTag(const AName: string; var VValue: string);
begin
  if AName = 'ano' then
  begin
       VValue := IntToStr(SysUtils.CurrentYear);
  end;
end;

initialization
  TIWLogin.SetAsMainForm;

end.
