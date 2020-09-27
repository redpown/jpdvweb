unit ServerController;

interface

uses
  SysUtils, Classes, IWServerControllerBase, IWBaseForm, HTTPApp,
  // For OnNewSession Event
  UserSessionUnit, IWApplication, IWAppForm, IW.Browser.Browser,
  IW.HTTP.Request, IW.HTTP.Reply,IW.Content.Handlers, IW.Content.Base,
  IW.Content.Redirect,IW.Content.Form,
  //For variables clas;
  Variants,StdCtrls;

type
  TIWServerController = class(TIWServerControllerBase)
    procedure IWServerControllerBaseNewSession(ASession: TIWApplication);
    procedure IWServerControllerBaseConfig(Sender: TObject);
    procedure IWServerControllerBaseBeforeRender(ASession: TIWApplication; AForm: TIWBaseForm; var VNewForm: TIWBaseForm);

  private
    { Private declarations }

  public
    { Public declarations }
   // salvar: TstringList;
   //Teste99:String;
  end;

  function UserSession: TIWUserSession;
  function IWServerController: TIWServerController;

implementation

{$R *.dfm}

uses
  IWInit, IWGlobal, Dashboard, Login, Funcionarios, Clientes, Fornecedores,
  Produtos, Caixa, FechamentoCaixa, TelaSistemaConfig, SistemaConfig;



function IWServerController: TIWServerController;
begin
  Result := TIWServerController(GServerController);
end;



function UserSession: TIWUserSession;
begin
  Result := TIWUserSession(WebApplication.Data);
end;

{ TIWServerController }

procedure TIWServerController.IWServerControllerBaseBeforeRender(ASession: TIWApplication; AForm: TIWBaseForm; var VNewForm: TIWBaseForm);
begin

       if FileExists(WebApplication.ApplicationPath +'wwwroot\config\conexao.cds') then
       begin
         if (UserSession.Usuario  = 0) and (AForm.ClassName <> 'TIWLogin') and (AForm.ClassName <> 'TIWTelaSistemaConfig') then
         begin
           VNewForm := TIWLogin.Create(nil);
           AForm.Release;
         end;
       end
       else
       begin
         VNewForm := TIWTelaSistemaConfig.Create(nil);
         AForm.Release;
       end;

end;

procedure TIWServerController.IWServerControllerBaseConfig(Sender: TObject);
begin


        THandlers.Add('','/login',TContentForm.Create(TIWLogin));
        THandlers.Add('','index',TContentForm.Create(TIWDashboard));
        THandlers.Add('','/dashboard',TContentForm.Create(TIWDashboard));
        THandlers.Add('','/funcionarios',TContentForm.Create(TIWFuncionarios));
        THandlers.Add('','/clientes',TContentForm.Create(TIWClientes));
        THandlers.Add('','/fornecedores',TContentForm.Create(TIWFornecedores));
        THandlers.Add('','/produtos',TContentForm.Create(TIWProdutos));
        THandlers.Add('','/caixa',TContentForm.Create(TIWCaixa));
        THandlers.Add('','/fechamento_de_caixa',TContentForm.Create(TIWFechamentoCaixa));
        THandlers.Add('','configuracao_sistema',TContentForm.Create(TIWTelaSistemaConfig));
        THandlers.Add('','sistema_configuracao',TContentForm.Create(TIWSistemaConfig));


end;


procedure TIWServerController.IWServerControllerBaseNewSession(
  ASession: TIWApplication);
begin
  ASession.Data := TIWUserSession.Create(nil, ASession);
end;

initialization
  TIWServerController.SetServerControllerClass;

end.


