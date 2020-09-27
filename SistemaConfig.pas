unit SistemaConfig;

interface

uses
  Classes, SysUtils, IWAppForm, IWApplication, IWColor, IWTypes, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML, DB,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, IWCompButton, Controls, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWCompEdit, IWCompRadioButton,
  IWCompCheckbox, IWBSCustomControl, IWBSButton, IWBSCustomInput, IWBSInput, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP,
   IdCoder, IdCoder3to4, IdCoderMIME, DataModule;

type
  TIWSistemaConfig = class(TIWAppForm)
    IWTemplateProcessorHTMLTSistemaConfig: TIWTemplateProcessorHTML;
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
    IdDecoderMIME1: TIdDecoderMIME;
    IWBase64: TIWEdit;
    IWBtnTestarConexao: TIWButton;
    IWBtnSalvarUserMaster: TIWButton;
    IWProtocolo: TIWEdit;
    IWDatabase: TIWEdit;
    IWId: TIWEdit;
    procedure IWTemplateProcessorHTMLTSistemaConfigUnknownTag(const AName: string; var VValue: string);
    procedure IWBtnConfirmarAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure IWBtnTestarConexaoAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure IWBtnSalvarUserMasterAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure IWBtnEditarAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure IWAppFormCreate(Sender: TObject);
    procedure IWAppFormShow(Sender: TObject);
    procedure IWButton1AsyncClick(Sender: TObject; EventParams: TStringList);
  public

  end;

implementation

uses
RenderHtml, ServerController, IW.Common.AppInfo;

{$R *.dfm}



//Async evita e refresh da pagina
procedure TIWSistemaConfig.IWAppFormCreate(Sender: TObject);
begin
//carrega as infromacoes da empresa
     if UserSession.dm_data.cds_DadosEmpresa.Active = true  then
      begin
        IWid.Text                     := UserSession.dm_data.cds_DadosEmpresa.FieldByName('id').AsString;
        IWRazaoSocial.Text            := UserSession.dm_data.cds_DadosEmpresa.FieldByName('razaosocial').AsString;
        IWCNAE.Text                   := UserSession.dm_data.cds_DadosEmpresa.FieldByName('cnae').AsString;
        IWComplemento.Text            := UserSession.dm_data.cds_DadosEmpresa.FieldByName('complemento').AsString;
        IWCep.Text                    := UserSession.dm_data.cds_DadosEmpresa.FieldByName('cep').AsString;
        IWEmail.Text                  := UserSession.dm_data.cds_DadosEmpresa.FieldByName('email').AsString;
        IWVersaoArquivoIBPT.Text      := UserSession.dm_data.cds_DadosEmpresa.FieldByName('versaoarquivoibpt').AsString;
        IWNomeFantasia.Text           := UserSession.dm_data.cds_DadosEmpresa.FieldByName('nomefantasia').AsString;
        IWIM.Text                     := UserSession.dm_data.cds_DadosEmpresa.FieldByName('im').AsString;
        IWBairro.Text                 := UserSession.dm_data.cds_DadosEmpresa.FieldByName('bairro').AsString;
        IWTelefone.Text               := UserSession.dm_data.cds_DadosEmpresa.FieldByName('telefone').AsString;
        IWSite.Text                   := UserSession.dm_data.cds_DadosEmpresa.FieldByName('site').AsString;
        IWAliquotaIBPTNacional.Text   := UserSession.dm_data.cds_DadosEmpresa.FieldByName('aliquotaibptnacional').AsString;
        IWCnpj.Text                   := UserSession.dm_data.cds_DadosEmpresa.FieldByName('cnpj').AsString;
        IWAliquotaIBPTEstadual.Text   := UserSession.dm_data.cds_DadosEmpresa.FieldByName('aliquotaibptestadual').AsString;
        IWEndereco.Text               := UserSession.dm_data.cds_DadosEmpresa.FieldByName('endereco').AsString;
        IWCodigoMunicipal.Text        := UserSession.dm_data.cds_DadosEmpresa.FieldByName('codigomunicipal').AsString;
        IWCelular.Text                := UserSession.dm_data.cds_DadosEmpresa.FieldByName('celular').AsString;
        IWChaveIBPT.Text              := UserSession.dm_data.cds_DadosEmpresa.FieldByName('chaveibpt').AsString;
        IWAliquotaIBPTImportacao.Text := UserSession.dm_data.cds_DadosEmpresa.FieldByName('aliquotaibptimportacao').AsString;
        IWVigenciaIBPT.Text           := UserSession.dm_data.cds_DadosEmpresa.FieldByName('vigenciaibpt').AsString;
        IWFax.Text                    := UserSession.dm_data.cds_DadosEmpresa.FieldByName('fax').AsString;
        IWMunicipio.Text              := UserSession.dm_data.cds_DadosEmpresa.FieldByName('municipio').AsString;
        IWNumero.Text                 := UserSession.dm_data.cds_DadosEmpresa.FieldByName('numero').AsString;
        IWIE.Text                     := UserSession.dm_data.cds_DadosEmpresa.FieldByName('ie').AsString;
        IWAliquotaICMS.Text           := UserSession.dm_data.cds_DadosEmpresa.FieldByName('aliquotaicms').AsString;
        IWAliquotaICMSST.Text         := UserSession.dm_data.cds_DadosEmpresa.FieldByName('aliquotaicmsst').AsString;
        IWAliquotaIPI.Text            := UserSession.dm_data.cds_DadosEmpresa.FieldByName('aliquotaipi').AsString;
        IWAliquotaPis.Text            := UserSession.dm_data.cds_DadosEmpresa.FieldByName('aliquotapis').AsString;
        IWAliquotaCofins.Text         := UserSession.dm_data.cds_DadosEmpresa.FieldByName('aliquotacofins').AsString;
        IWUF.Text                     := UserSession.dm_data.cds_DadosEmpresa.FieldByName('uf').AsString;
        IWBase64.Text                 := UserSession.dm_data.cds_DadosEmpresa.FieldByName('base64').AsString;
        IWChkIsento.Checked           := UserSession.dm_data.cds_DadosEmpresa.FieldByName('isento').AsBoolean;
        IWChkSimplesNacional.Checked  := UserSession.dm_data.cds_DadosEmpresa.FieldByName('simplesnacional').AsBoolean;

      end;
//*

//carrega dados da conexao
     if UserSession.dm_data.cd_Conexao.Active = true  then
     begin
        IWHost.Text      := UserSession.dm_data.cd_Conexao.FieldByName('Host').AsString;
        IWPort.Text      := UserSession.dm_data.cd_Conexao.FieldByName('Port').AsString;
        IWSchema.Text    := UserSession.dm_data.cd_Conexao.FieldByName('Schema').AsString;
        IWProtocolo.Text := UserSession.dm_data.cd_Conexao.FieldByName('Protocolo').AsString;
        IWDatabase.Text  := UserSession.dm_data.cd_Conexao.FieldByName('Database').AsString;
        IWUsuario.Text   := UserSession.dm_data.cd_Conexao.FieldByName('Usuario').AsString;
        IWSenha.Text     := UserSession.dm_data.cd_Conexao.FieldByName('Senha').AsString;
     end;

end;

procedure TIWSistemaConfig.IWAppFormShow(Sender: TObject);
begin

         if IWChkIsento.Checked then
           AddToInitProc('$( "#Isento" ).click(); $( "#IWCHKISENTO_CHECKBOX" ).click();');

         if IWChkSimplesNacional.Checked then
           AddToInitProc('$( "#Simples-Nacional" ).click(); $( "#IWCHKSIMPLESNACIONAL_CHECKBOX" ).click();');
end;

procedure TIWSistemaConfig.IWBtnConfirmarAsyncClick(Sender: TObject; EventParams: TStringList);
var
Erro,img : String;
begin
        if Copy(IWBase64.Text, 1, 6) <> 'assets' then
           img := RenderHtml.GeraPng(IWBase64.Text,IWRazaoSocial.Text)
        else
           img := IWBase64.Text;
        //UserSession.dm_data.GeraConectionCds(IWHost, IWPort, IWSchema, IWProtocolo, IWDatabase, IWUsuario, IWSenha);

        Erro := UserSession.dm_data.Cad_Empresa(IWRazaoSocial ,IWCNAE ,IWComplemento ,IWCep ,IWEmail ,IWVersaoArquivoIBPT ,
                                             IWNomeFantasia ,IWIM ,IWBairro ,IWTelefone ,IWSite ,IWAliquotaIBPTNacional ,IWCnpj ,
                                             IWAliquotaIBPTEstadual ,IWEndereco ,IWCodigoMunicipal ,IWCelular ,IWChaveIBPT ,
                                             IWAliquotaIBPTImportacao ,IWVigenciaIBPT ,IWFax ,IWMunicipio ,IWNumero ,IWIE ,
                                             IWAliquotaICMS ,IWAliquotaICMSST ,IWAliquotaIPI ,IWAliquotaPis ,IWAliquotaCofins ,IWUF ,IWId,
                                             img,IWChkIsento,IWChkSimplesNacional);
        //WebApplication.GoToURL('/login');

          WebApplication.ShowMessage( Erro , smAlert );



end;

procedure TIWSistemaConfig.IWBtnEditarAsyncClick(Sender: TObject; EventParams: TStringList);
begin
          WebApplication.ShowMessage( 'editar ', smAlert );
end;

procedure TIWSistemaConfig.IWBtnSalvarUserMasterAsyncClick(Sender: TObject; EventParams: TStringList);
begin
      WebApplication.ShowMessage(UserSession.dm_data.Cad_UsuarioMaster(IWMUsuario,IWMsenha), smAlert );


end;

procedure TIWSistemaConfig.IWBtnTestarConexaoAsyncClick(Sender: TObject; EventParams: TStringList);
begin

        UserSession.dm_data.GeraConectionCds(IWHost, IWPort, IWSchema, IWProtocolo, IWDatabase, IWUsuario, IWSenha);

        WebApplication.ShowMessage( UserSession.dm_data.conectar())
end;

procedure TIWSistemaConfig.IWButton1AsyncClick(Sender: TObject; EventParams: TStringList);
begin
    WebApplication.ShowMessage( 'botao novo ');
end;

procedure TIWSistemaConfig.IWTemplateProcessorHTMLTSistemaConfigUnknownTag(const AName: string; var VValue: string);
begin
  if AName = 'ano' then
  begin
       VValue := IntToStr(SysUtils.CurrentYear);

  end;

  if AName = 'RenderHtmlHead' then
  begin
       VValue := RenderHtml.RenderHead('Configuração de Sistema JPDV','<script src="vendors/jQuery-Mask-Plugin-master/dist/jquery.mask.min.js"></script>');

  end;

   if AName = 'RenderHtmlHeader' then
 begin
      VValue := RenderHtml.RenderHeader('JJA','JJA Consulting','assets/images/faces/face8.jpg','assets/images/logo.png','jjapdv@jjaconsulting.com.br','Master' );
 end;

 if AName = 'RenderHtmlFooter' then
 begin
        VValue := RenderHtml.RenderFooter('<script src="assets/js/jpdvweb_Upload_image.js"></script>' +#13 + '<script src="assets/js/jpdvweb_Mascara_Campos.js"></script>');
 end;

    if AName = 'ImgEmpresa' then
  begin
    if Copy(IWBase64.Text, 1, 6) <> 'assets' then
        VValue :=  '<img class="form-group img-thumbnail ImgEnviadaEmpresa" id="ImgEnviada" src = "assets/images/logo.png" alt="Logo da Empresa">'
    else
        VValue := '<img class="form-group img-thumbnail ImgEnviadaEmpresa" id="ImgEnviada" src = "'+ IWBase64.Text +'" alt="Logo da Empresa">';
  end;

  if AName = 'ComboxUF' then
  begin
    if (IWUF.Text = '') or (IWUF.Text = 'IWUF')  then
    begin
                 VValue :=  '<select id= "campoUF" class="form-control">'+#13
                              +'<option value="Selecionar UF" selected>Selecionar UF</option>'+#13
                              +'<option value="SP">SP</option>'+#13
                              +'<option value="RO">RO</option>'+#13
                              +'<option value="RJ">RJ</option>'+#13
                              +'<option value="BD">BH</option>'+#13
                  +'</select>';
    end
    else
    begin
                 VValue :=  '<select id= "campoUF" class="form-control">'+#13
                              +'<option value="'+ IWUF.Text +'" selected>'+ IWUF.Text +'</option>'+#13
                              +'<option value="SP">SP</option>'+#13
                              +'<option value="RO">RO</option>'+#13
                              +'<option value="RJ">RJ</option>'+#13
                              +'<option value="BD">BH</option>'+#13
                  +'</select>';
    end;
  end;

end;



end.
