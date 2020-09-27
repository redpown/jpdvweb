unit Configurar;

interface

uses
  Classes, SysUtils, IWAppForm, IWApplication, IWColor, IWTypes, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  IdBaseComponent, IdCoder, IdCoder3to4, IdCoderMIME, IWCompButton, IWCompCheckbox, Controls, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWCompEdit;

type
  TIWConfigurar = class(TIWAppForm)
    IWTemplateProcessorHTMLConfigurar: TIWTemplateProcessorHTML;
    IWRazaoSocial: TIWEdit;
    IWCNAE: TIWEdit;
    IWComplemento: TIWEdit;
    IWCep: TIWEdit;
    IWEmail: TIWEdit;
    IWVersaoArquivoIBPT: TIWEdit;
    IWNomeFantasia: TIWEdit;
    IWIM: TIWEdit;
    IWBairro: TIWEdit;
    IWTelefone: TIWEdit;
    IWSite: TIWEdit;
    IWAliquotaIBPTNacional: TIWEdit;
    IWCnpj: TIWEdit;
    IWAliquotaIBPTEstadual: TIWEdit;
    IWEndereco: TIWEdit;
    IWCodigoMunicipal: TIWEdit;
    IWCelular: TIWEdit;
    IWChaveIBPT: TIWEdit;
    IWAliquotaIBPTImportacao: TIWEdit;
    IWVigenciaIBPT: TIWEdit;
    IWFax: TIWEdit;
    IWMunicipio: TIWEdit;
    IWNumero: TIWEdit;
    IWIE: TIWEdit;
    IWAliquotaICMS: TIWEdit;
    IWAliquotaICMSST: TIWEdit;
    IWAliquotaIPI: TIWEdit;
    IWAliquotaPis: TIWEdit;
    IWAliquotaCofins: TIWEdit;
    IWHost: TIWEdit;
    IWPort: TIWEdit;
    IWUsuario: TIWEdit;
    IWSenha: TIWEdit;
    IWSchema: TIWEdit;
    IWMSenha: TIWEdit;
    IWMUsuario: TIWEdit;
    IWChkSimplesNacional: TIWCheckBox;
    IWChkIsento: TIWCheckBox;
    IWUF: TIWEdit;
    IWBtnEnviarImagem: TIWButton;
    IWBtnConfirmar: TIWButton;
    IWBtnEditar: TIWButton;
    IWBase64: TIWEdit;
    IWBtnTestarConexao: TIWButton;
    IWBtnSalvarUserMaster: TIWButton;
    IWProtocolo: TIWEdit;
    IWDatabase: TIWEdit;
    IWId: TIWEdit;
    IdDecoderMIME1: TIdDecoderMIME;
    procedure IWTemplateProcessorHTMLConfigurarUnknownTag(const AName: string; var VValue: string);
    procedure IWBtnTestarConexaoAsyncClick(Sender: TObject; EventParams: TStringList);
  public
  end;

implementation

{$R *.dfm}
uses
RenderHtml,ServerController;

procedure TIWConfigurar.IWBtnTestarConexaoAsyncClick(Sender: TObject; EventParams: TStringList);
begin
    WebApplication.ShowMessage( 'editar ', smAlert );
    //AddToInitProc('console.log("deucerto")');

end;

procedure TIWConfigurar.IWTemplateProcessorHTMLConfigurarUnknownTag(const AName: string; var VValue: string);
begin
   if AName = 'RenderHtmlHeader' then
 begin
      VValue := RenderHtml.RenderHeader('JJA','JJA Consulting','assets/images/faces/face8.jpg','assets/images/logo.png','jjapdv@jjaconsulting.com.br','Master' );
 end;

 if AName = 'RenderHtmlFooter' then
 begin
        VValue := RenderHtml.RenderFooter('<script src="assets/js/jpdvweb_Upload_image.js"></script>' +#13 + '<script src="assets/js/jpdvweb_Mascara_Campos.js"></script>');
 end;
end;

end.
