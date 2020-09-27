unit ExemploDeClasse;

interface

uses
  DateUtils,  Classes, SysUtils,
  IWAppForm, IWApplication, IWColor, IWTypes, IWCompEdit, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWCompButton, IWVCLComponent,IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML,Controls,IdBaseComponent, IdCoder, IdCoder3to4, IdCoderMIME,
  //data
  DBClient, DB, ZAbstractRODataset, ZAbstractDataset, ZDataset,IW.Common.AppInfo;

type

TDataModule = class//class(aqui dentro vai a classe a ser herdada)
private
  ZQuery1: TZQuery;
  cd_Conexao: TClientDataSet;
  IWEdit1: TIWEdit;
public
constructor Create();
function getConexao(): string;
function getUsuario(): string;
Procedure GeraConectionCds(Host: TIWEdit; Port: TIWEdit; Schema: TIWEdit ;Usuario: TIWEdit;Senha: TIWEdit);
end;

implementation

constructor TDataModule.Create();
begin
  cd_Conexao:= TClientDataSet.Create(nil);
  cd_Conexao.CreateDataSet;
  cd_Conexao.Active:=true;
end;

function TDataModule.getConexao(): string;
begin

end;

function TDataModule.getUsuario(): string;
begin

end;

 Procedure TDataModule.GeraConectionCds(Host: TIWEdit; Port: TIWEdit; Schema: TIWEdit ;Usuario: TIWEdit;Senha: TIWEdit);
 begin

  cd_Conexao.Append;
  cd_Conexao.fieldbyname('Host').AsString    := Host.Text;
  cd_Conexao.fieldbyname('Port').AsString    := Port.Text;
  cd_Conexao.fieldbyname('Schema').AsString  := Schema.Text;
  cd_Conexao.fieldbyname('Usuario').AsString := Usuario.Text;
  cd_Conexao.fieldbyname('Senha').AsString   := Senha.Text;
  cd_Conexao.Post;
  cd_Conexao.SaveToFile(TIWAppInfo.GetAppPath +'wwwroot\config\conexao.cds');
 end;


end.
