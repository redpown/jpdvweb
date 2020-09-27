unit DataModule;

interface

uses
  DateUtils,  Classes, SysUtils,
  IWAppForm, IWApplication, IWColor, IWTypes, IWCompEdit, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWCompButton, IWVCLComponent,IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML,Controls,IdBaseComponent, IdCoder, IdCoder3to4, IdCoderMIME,
  //data
  DBClient, DB, ZAbstractRODataset, ZAbstractDataset, ZDataset,
  // connectar
  ZConnection,
  //
  IW.Common.AppInfo;


type
  TDataModuleSource = class(TDataModule)
    zq_UsuarioMaster: TZQuery;
    zq_Connection: TZConnection;
    cd_Conexao: TClientDataSet;
  private

    { Private declarations }
  public
   procedure GeraConectionCds(Host, Port, Schema, Database, Protocolo, Usuario, Senha: TIWEdit);
    function conectar: String;
    function Cad_UsuarioMaster(Usuario, Senha: TIWEdit): string;
    procedure CarregaConexao;
    { Public declarations }
  end;

var
   DataModuleSource: TDataModuleSource;



implementation

{$R *.dfm}


 Procedure TDataModuleSource.GeraConectionCds(Host: TIWEdit; Port: TIWEdit; Schema: TIWEdit ; Database:TIWEdit ; Protocolo:TIWEdit ;Usuario: TIWEdit;Senha: TIWEdit);
 begin
       cd_Conexao:= TClientDataSet.Create(nil);


      {
      para criar campos em tempo de execucao
      https://edn.embarcadero.com/article/28959
       with ClientDataSet2.FieldDefs do
        begin
          Clear;
          Add('ID',ftInteger, 0, True);
          Add('First Name',ftString, 20);
          Add('Last Name',ftString, 25);
          Add('Date of Birth',ftDate);
          Add('Active',ftBoolean);
        end; //with ClientDataSet2.FieldDefs
        ClientDataSet2.CreateDataSet;
      }

      with cd_Conexao.FieldDefs do
        begin
          Clear;
          Add('Host',ftString, 80);
          Add('Port',ftString, 80);
          Add('Database',ftString, 80);
          Add('Protocolo',ftString, 80);
          Add('Schema',ftString, 80);
          Add('Usuario',ftString, 80);
          Add('Senha',ftString, 80);

        end;

      cd_Conexao.CreateDataSet;
      cd_Conexao.Active:=true;

      cd_Conexao.Append;
      cd_Conexao.fieldbyname('Host').AsString      := Host.Text;
      cd_Conexao.fieldbyname('Port').AsString      := Port.Text;
      cd_Conexao.fieldbyname('Schema').AsString    := Schema.Text;
      cd_Conexao.fieldbyname('Protocolo').AsString := Database.Text;
      cd_Conexao.fieldbyname('Database').AsString  := Protocolo.Text;
      cd_Conexao.fieldbyname('Usuario').AsString   := Usuario.Text;
      cd_Conexao.fieldbyname('Senha').AsString     := Senha.Text;
      cd_Conexao.Post;

      cd_Conexao.SaveToFile(TIWAppInfo.GetAppPath +'wwwroot\config\conexao.cds');

 end;

 function TDataModuleSource.conectar(): String;
 begin
      //para loadfomfile nao precisa da estrura de dados de cds
      if fileexists(TIWAppInfo.GetAppPath +'wwwroot\config\conexao.cds') then
      begin

       cd_Conexao.LoadFromFile(TIWAppInfo.GetAppPath +'wwwroot\config\conexao.cds');
       zq_Connection := TZConnection.Create(nil);

       {
       zq_Connection.HostName := 'localhost';
       zq_Connection.Port     := 5432;
       zq_Connection.Protocol := 'postgresql-7';
       zq_Connection.Database := 'Andre';
       zq_Connection.User     := 'postgres';
       zq_Connection.Password := 'jjaerp';
       }

       zq_Connection.HostName := cd_Conexao.FieldByName('Host').AsString;
       zq_Connection.Port     := cd_Conexao.FieldByName('Port').AsInteger;
       zq_Connection.Protocol := cd_Conexao.FieldByName('Protocolo').AsString;
       zq_Connection.Database := cd_Conexao.FieldByName('Database').AsString;
       zq_Connection.User     := cd_Conexao.FieldByName('Usuario').AsString;
       zq_Connection.Password := cd_Conexao.FieldByName('Senha').AsString;


       try
          with zq_Connection do
          begin
            Connected := true;
            result:='0';
          end;
       except on E:exception do
          begin
            zq_Connection.Connected := false;
            result:= E.message;
          end;
       end;
       end
       else

         result:='Arquivo nao encontrado!.';

end;

function TDataModuleSource.Cad_UsuarioMaster(Usuario: TIWEdit; Senha: TIWEdit) :string;
begin
if fileexists(TIWAppInfo.GetAppPath +'wwwroot\config\conexao.cds') then
      begin

       cd_Conexao.LoadFromFile(TIWAppInfo.GetAppPath +'wwwroot\config\conexao.cds');
       zq_Connection := TZConnection.Create(nil);

       {
       zq_Connection.HostName := 'localhost';
       zq_Connection.Port     := 5432;
       zq_Connection.Protocol := 'postgresql-7';
       zq_Connection.Database := 'Andre';
       zq_Connection.User     := 'postgres';
       zq_Connection.Password := 'jjaerp';
       }

       zq_Connection.HostName := cd_Conexao.FieldByName('Host').AsString;
       zq_Connection.Port     := cd_Conexao.FieldByName('Port').AsInteger;
       zq_Connection.Protocol := cd_Conexao.FieldByName('Protocolo').AsString;
       zq_Connection.Database := cd_Conexao.FieldByName('Database').AsString;
       zq_Connection.User     := cd_Conexao.FieldByName('Usuario').AsString;
       zq_Connection.Password := cd_Conexao.FieldByName('Senha').AsString;


       try
          with zq_Connection do
          begin
            Connected := true;
           // result:='0';
          end;
       except on E:exception do
          begin
            zq_Connection.Connected := false;
            //result:= E.message;
          end;
       end;
       end;

  zq_UsuarioMaster := TZQuery.Create(nil);
  zq_UsuarioMaster.Connection := zq_Connection;


      zq_UsuarioMaster.SQL.Text := 'insert into jja.cad_funcionarios_jpdvweb (usuario, senha, gerente_vendas, financeiro, representante, vendedor) values(''teste'',''1234'', true, true, true, true);';
      //zq_UsuarioMaster.ParamByName(':Usuario').AsString := Usuario.Text;
      //zq_UsuarioMaster.Open;
      zq_UsuarioMaster.ExecSQL();
      zq_UsuarioMaster.Close;



end;

procedure TDataModuleSource.CarregaConexao();
begin
   if fileexists(TIWAppInfo.GetAppPath +'wwwroot\config\conexao.cds') then
      begin

       cd_Conexao.LoadFromFile(TIWAppInfo.GetAppPath +'wwwroot\config\conexao.cds');
       zq_Connection := TZConnection.Create(nil);

       {
       zq_Connection.HostName := 'localhost';
       zq_Connection.Port     := 5432;
       zq_Connection.Protocol := 'postgresql-7';
       zq_Connection.Database := 'Andre';
       zq_Connection.User     := 'postgres';
       zq_Connection.Password := 'jjaerp';
       }

       zq_Connection.HostName := cd_Conexao.FieldByName('Host').AsString;
       zq_Connection.Port     := cd_Conexao.FieldByName('Port').AsInteger;
       zq_Connection.Protocol := cd_Conexao.FieldByName('Protocolo').AsString;
       zq_Connection.Database := cd_Conexao.FieldByName('Database').AsString;
       zq_Connection.User     := cd_Conexao.FieldByName('Usuario').AsString;
       zq_Connection.Password := cd_Conexao.FieldByName('Senha').AsString;


       try
          with zq_Connection do
          begin
            Connected := true;
           // result:='0';
          end;
       except on E:exception do
          begin
            zq_Connection.Connected := false;
            //result:= E.message;
          end;
       end;
       end;
end;

end.
