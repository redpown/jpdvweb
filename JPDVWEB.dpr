program JPDVWEB;
// As pastas de Debug e Relsia precisa ter os folders
// Templeste e wwwroot com os mesmos arquivos para nao dar bug
uses
  FastMM4,
  IWRtlFix,
  IWJclStackTrace,
  IWJclDebug,
  IWStart,
  Caixa in 'Caixa.pas' {IWCaixa: TIWAppForm},
  Clientes in 'Clientes.pas' {IWClientes: TIWAppForm},
  Configurar in 'Configurar.pas' {IWConfigurar: TIWAppForm},
  Dashboard in 'Dashboard.pas' {IWDashboard: TIWAppForm},
  DataModule in 'DataModule.pas' {DataModuleSource: TDataModule},
  dm_DataModule in 'dm_DataModule.pas' {DataModule1: TDataModule},
  FechamentoCaixa in 'FechamentoCaixa.pas' {IWFechamentoCaixa: TIWAppForm},
  Financeiro in 'Financeiro.pas' {IWFinanceiro: TIWAppForm},
  Fornecedores in 'Fornecedores.pas' {IWFornecedores: TIWAppForm},
  Funcionarios in 'Funcionarios.pas' {IWFuncionarios: TIWAppForm},
  Login in 'Login.pas' {IWLogin: TIWAppForm},
  Produtos in 'Produtos.pas' {IWProdutos: TIWAppForm},
  RenderHtml in 'RenderHtml.pas',
  ServerController in 'ServerController.pas' {IWServerController: TIWServerControllerBase},
  SistemaConfig in 'SistemaConfig.pas' {IWSistemaConfig: TIWAppForm},
  TelaSistemaConfig in 'TelaSistemaConfig.pas' {IWTelaSistemaConfig: TIWAppForm},
  UserSessionUnit in 'UserSessionUnit.pas' {IWUserSession: TIWUserSessionBase};

{$R *.res}

begin
  TIWStart.Execute(True);
end.
