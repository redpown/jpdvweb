unit DataModule;

interface

uses
  DateUtils,  Classes, SysUtils,
  IWAppForm, IWApplication, IWColor, IWTypes, IWCompEdit, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWCompButton, IWCompCheckbox, IWVCLComponent,IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML,Controls,IdBaseComponent, IdCoder, IdCoder3to4, IdCoderMIME,
  //data
  DBClient, DB, ZAbstractRODataset, ZAbstractDataset, ZDataset,
  // connectar
  ZConnection,
  //
  ZAbstractConnection;


type
    TDataModuleSource = class(TDataModule)
    zq_UsuarioMaster: TZQuery;
    zq_Connection: TZConnection;
    cd_Conexao: TClientDataSet;
    zq_Empresa: TZQuery;
    zq_temp: TZQuery;
    cds_DadosEmpresa: TClientDataSet;
    procedure DataModuleCreate(Sender: TObject);
  private


    { Private declarations }
  public
    Schema : String;
    SalvarSql: TStringList;
    function Cad_Empresa(RazaoSocial, CNAE, Complemento, Cep, Email, VersaoArquivoIBPT, NomeFantasia, IM, Bairro, Telefone, Site, AliquotaIBPTNacional, Cnpj, AliquotaIBPTEstadual, Endereco,
CodigoMunicipal, Celular, ChaveIBPT, AliquotaIBPTImportacao, VigenciaIBPT, Fax, Municipio, Numero, IE, AliquotaICMS, AliquotaICMSST, AliquotaIPI, AliquotaPis, AliquotaCofins,
UF, Id : TIWEdit; Base64 : String ;  Isento, SimplesNacional : TIWCheckBox
) : String;
    function VerificaDadEmpresa(ID: TIWEdit): Integer;
    procedure CarregaDadosEmpresa;
    function CopiaDadosDataSet(dtsAtual, dtsComDados: TDataSet; bRegistroAtual: Boolean = False): Boolean;
    function CriaCamposDataSet(cdsAtual: TClientDataSet; dtsAComparar: TDataSet): Boolean;
    procedure GeraConectionCds(Host, Port, Schema, Database, Protocolo, Usuario, Senha: TIWEdit);
    function conectar: String;
    function  Cad_UsuarioMaster(Usuario , Senha: TIWEdit) :string;
    procedure CarregaConexao;

    { Public declarations }
  end;

var
   DataModuleSource: TDataModuleSource;



implementation

{$R *.dfm}

uses
 IW.Common.AppInfo;

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

      cd_Conexao.SaveToFile(TIWAppInfo.GetAppPath + 'wwwroot\config\conexao.cds');

 
 end;

 function TDataModuleSource.conectar(): String;
 begin
      //para loadfomfile nao precisa da estrura de dados de cds
      if fileexists(TIWAppInfo.GetAppPath +'wwwroot\config\conexao.cds') then
      begin
       cd_Conexao.LoadFromFile(TIWAppInfo.GetAppPath +'wwwroot\config\conexao.cds');
       cd_Conexao.Active:=true;
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

       Schema                 := cd_Conexao.fieldbyname('Schema').AsString +'.';

       try
          with zq_Connection do
          begin
            Connected := true;
            result:='Conexão Estabelecida!.';
          end;
       except on E:exception do
          begin
            zq_Connection.Connected := false;
            result:= 'Erro ao conectar: ' + E.message;
          end;
       end;
       end
       else

         result:='Arquivo nao encontrado!.';
        zq_Connection.Disconnect;

end;

procedure TDataModuleSource.DataModuleCreate(Sender: TObject);
begin
CarregaConexao();
conectar();
CarregaDadosEmpresa();
SalvarSql := TStringList.Create;
end;

function TDataModuleSource.Cad_UsuarioMaster(Usuario , Senha: TIWEdit) :string;
begin
     {
      if fileexists(TIWAppInfo.GetAppPath +'wwwroot\config\conexao.cds') then
        begin

         cd_Conexao.LoadFromFile(TIWAppInfo.GetAppPath +'wwwroot\config\conexao.cds');
         zq_Connection := TZConnection.Create(nil);


         zq_Connection.HostName := 'localhost';
         zq_Connection.Port     := 5432;
         zq_Connection.Protocol := 'postgresql-7';
         zq_Connection.Database := 'Andre';
         zq_Connection.User     := 'postgres';
         zq_Connection.Password := 'jjaerp';


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
         }
        zq_UsuarioMaster := TZQuery.Create(nil);
        zq_UsuarioMaster.Connection := zq_Connection;



       try
            begin
            zq_UsuarioMaster.SQL.Clear;
            zq_UsuarioMaster.SQL.Add('insert into '+ Schema +'cad_funcionarios_jpdvweb (usuario, senha, gerente_vendas, financeiro, representante, vendedor, foto_funcionario, cargo, funcao) ');
            zq_UsuarioMaster.SQL.Add('values(:Usuario,:Senha, true, true, true, true, ''wwwroot\assets\images\faces\face8.jpg'', :CMaster,:FMaster);');
            zq_UsuarioMaster.ParamByName('Usuario').AsString := Usuario.Text;
            zq_UsuarioMaster.ParamByName('Senha').AsString   := Senha.Text;
            zq_UsuarioMaster.ParamByName('CMaster').AsString   := 'Master';
            zq_UsuarioMaster.ParamByName('FMaster').AsString   := 'Master';
            //zq_UsuarioMaster.Open;
            zq_UsuarioMaster.ExecSQL();
            zq_UsuarioMaster.Close;
            result:= 'Usuário Master Cadastrado!.';
          end;
       except on E:exception do
          begin
            result:= 'Erro ao cadastrar usuário Master: ' + E.message;
          end;
       end;

end;

procedure TDataModuleSource.CarregaConexao();
begin
   if fileexists(TIWAppInfo.GetAppPath +'wwwroot\config\conexao.cds') then
      begin

       cd_Conexao.LoadFromFile(TIWAppInfo.GetAppPath +'wwwroot\config\conexao.cds');
       cd_Conexao.Active:=true;
       zq_Connection := TZConnection.Create(nil);

       {
       zq_Connection.HostName := 'localhost';
       zq_Connection.Port     := 5432;
       zq_Connection.Protocol := 'postgresql-7';
       zq_Connection.Database := 'Andre';
       zq_Connection.User     := 'postgres';
       zq_Connection.Password := 'jjaerp';
       }
       //nao usar database 64 bit com zeos lib protocolo postgresql-9
       //nao tentar se conectar a uma base 64 com zquery
       //obs colocar na pasta da aplicacao para carregar sempre dela
       //zq_Connection.LibraryLocation := 'C:\zeoslib\src\lib\postgresql\libpq.dll';
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

function TDataModuleSource.VerificaDadEmpresa(ID: TIWEdit):Integer;
begin
      if fileexists(TIWAppInfo.GetAppPath +'wwwroot\config\conexao.cds') then
      begin
      zq_temp := TZQuery.Create(nil);
      zq_temp.Connection := zq_Connection;

      zq_temp.SQL.Clear;
      zq_temp.SQL.Add('select id from ');
      zq_temp.SQL.Add(Schema);
      zq_temp.SQL.Add('dad_empresa_jpdv where cnpj = :id ;');
      zq_temp.ParamByName('id').AsString :=  ID.Text;
      zq_temp.Open; //sempres usar o .Open para fazer qualquer selectr na base

      // zq_temp.Close;
      //SalvarSql.Add(zq_temp.SQL.Text);
      //SalvarSql.SaveToFile('C:\Desenvolvedores\Andre\JPDVWEB\wwwroot\config\sql_zq_empresa.txt');
      if zq_temp.RecordCount>0 then
         result := 1
      else
         result := 0;


      end;
      zq_temp.Close;
end;

procedure TDataModuleSource.CarregaDadosEmpresa();
begin
      if cd_Conexao.Active = true  then
      begin
      zq_Empresa := TZQuery.Create(nil);
      zq_Empresa.Connection := zq_Connection;

      zq_temp.SQL.Clear;

      zq_Empresa.SQL.Add('SELECT id, razaosocial, cnae, complemento, cep, email, versaoarquivoibpt,');
      zq_Empresa.SQL.Add('       nomefantasia, im, bairro, telefone, site, aliquotaibptnacional,');
      zq_Empresa.SQL.Add('       cnpj, aliquotaibptestadual, endereco, codigomunicipal, data_edicao,');
      zq_Empresa.SQL.Add('       celular, chaveibpt, aliquotaibptimportacao, vigenciaibpt, fax,');
      zq_Empresa.SQL.Add('       municipio, numero, ie, aliquotaicms, aliquotaicmsst, aliquotaipi,');
      zq_Empresa.SQL.Add('       aliquotapis, aliquotacofins, uf, base64, last_user_name, isento,');
      zq_Empresa.SQL.Add('       simplesnacional');
      zq_Empresa.SQL.Add('  FROM ' + Schema + 'dad_empresa_jpdv;');
      zq_Empresa.Open; //sempres usar o .Open para fazer qualquer selectr na base

      // zq_temp.Close;
      //SalvarSql.Add(zq_temp.SQL.Text);
      //SalvarSql.SaveToFile('C:\Desenvolvedores\Andre\JPDVWEB\wwwroot\config\sql_zq_empresa.txt');

      CriaCamposDataSet(cds_DadosEmpresa, zq_Empresa);
      CopiaDadosDataSet(cds_DadosEmpresa, zq_Empresa);

      zq_Empresa.Close;

      end;
end;

function TDataModuleSource.CopiaDadosDataSet(dtsAtual, dtsComDados : TDataSet; bRegistroAtual : Boolean = False) : Boolean;
var
  i, iRecNo : Integer;
  bkPosicao : TBookMark;
  bOK : Boolean;
begin
  if (dtsComDados.Active = True) and (dtsComDados.Recordcount > 0) then
  begin
    iRecNo := dtsComDados.RecNo;

    if bRegistroAtual = False then
      dtsComDados.First;

    while not dtsComDados.Eof do
    begin
      dtsAtual.Append;

      for i := 0 to dtsComDados.Fields.Count -1 do
        if dtsAtual.FindField(dtsComDados.Fields[i].FieldName) <> nil then
          dtsAtual.FieldValues[dtsComDados.Fields[i].FieldName] := dtsComDados.Fields[i].Value;

      dtsAtual.Post;

      if bRegistroAtual = False then
        dtsComDados.Next
      else
        Break;
    end;

    if bRegistroAtual = False then
    begin
      bOK := False;
      dtsAtual.First;

      repeat
        if dtsAtual.RecNo = iRecNo then
          bOK := True
        else
          dtsAtual.Next;

      until (bOK = True);
    end;
  end;
end;

function TDataModuleSource.CriaCamposDataSet(cdsAtual : TClientDataSet; dtsAComparar : TDataSet) : Boolean;
var
  i : Integer;
begin
  cdsAtual.Close;
  cdsAtual.FieldDefs.Clear;

  i := dtsAComparar.Fields.Count;
  for i := 0 to dtsAComparar.Fields.Count -1 do
    cdsAtual.FieldDefs.Add(dtsAComparar.Fields[i].FieldName,
                           dtsAComparar.Fields[i].DataType,
                           dtsAComparar.Fields[i].Size);

  cdsAtual.CreateDataSet;
end;

function TDataModuleSource.Cad_Empresa(RazaoSocial, CNAE, Complemento, Cep, Email, VersaoArquivoIBPT, NomeFantasia, IM, Bairro, Telefone, Site, AliquotaIBPTNacional, Cnpj, AliquotaIBPTEstadual, Endereco,
CodigoMunicipal, Celular, ChaveIBPT, AliquotaIBPTImportacao, VigenciaIBPT, Fax, Municipio, Numero, IE, AliquotaICMS, AliquotaICMSST, AliquotaIPI, AliquotaPis, AliquotaCofins,
UF, Id : TIWEdit; Base64 : String ;  Isento, SimplesNacional : TIWCheckBox
) : String;
begin
      if cd_Conexao.Active = true then
      begin
        zq_Empresa := TZQuery.Create(nil);
        zq_Empresa.Connection := zq_Connection;
        zq_Empresa.SQL.Clear;
       try
       begin
         if VerificaDadEmpresa(Cnpj) = 1 then
          begin

            zq_Empresa.SQL.Add('update '+ Schema +'dad_empresa_jpdv ');
            zq_Empresa.SQL.Add('set ');
            zq_Empresa.SQL.Add('razaosocial = :razaosocial ,');
            zq_Empresa.SQL.Add('cnae = :cnae ,');
            zq_Empresa.SQL.Add('complemento = :complemento ,');
            zq_Empresa.SQL.Add('cep = :cep ,');
            zq_Empresa.SQL.Add('email = :email ,');
            zq_Empresa.SQL.Add('versaoarquivoibpt = :versaoarquivoibpt ,');
            zq_Empresa.SQL.Add('nomefantasia = :nomefantasia ,');
            zq_Empresa.SQL.Add('im = :im ,');
            zq_Empresa.SQL.Add('bairro = :bairro ,');
            zq_Empresa.SQL.Add('telefone = :telefone ,');
            zq_Empresa.SQL.Add('site = :site ,');
            zq_Empresa.SQL.Add('aliquotaibptnacional = :aliquotaibptnacional ,');
            zq_Empresa.SQL.Add('cnpj = :cnpj ,');
            zq_Empresa.SQL.Add('aliquotaibptestadual = :aliquotaibptestadual ,');
            zq_Empresa.SQL.Add('endereco = :endereco ,');
            zq_Empresa.SQL.Add('codigomunicipal = :codigomunicipal ,');
            zq_Empresa.SQL.Add('celular = :celular ,');
            zq_Empresa.SQL.Add('chaveibpt = :chaveibpt ,');
            zq_Empresa.SQL.Add('aliquotaibptimportacao = :aliquotaibptimportacao ,');
            zq_Empresa.SQL.Add('vigenciaibpt = :vigenciaibpt ,');
            zq_Empresa.SQL.Add('fax = :fax ,');
            zq_Empresa.SQL.Add('municipio = :municipio ,');
            zq_Empresa.SQL.Add('numero = :numero ,');
            zq_Empresa.SQL.Add('ie = :ie ,');
            zq_Empresa.SQL.Add('aliquotaicms = :aliquotaicms ,');
            zq_Empresa.SQL.Add('aliquotaicmsst = :aliquotaicmsst ,');
            zq_Empresa.SQL.Add('aliquotaipi = :aliquotaipi ,');
            zq_Empresa.SQL.Add('aliquotapis = :aliquotapis ,');
            zq_Empresa.SQL.Add('aliquotacofins = :aliquotacofins ,');
            zq_Empresa.SQL.Add('uf = :uf ,');
            zq_Empresa.SQL.Add('base64 = ');
            zq_Empresa.SQL.Add(''''+ Base64 +'''');
            zq_Empresa.SQL.Add(',isento = :isento ,');
            zq_Empresa.SQL.Add('simplesnacional  = :simplesnacional');
            zq_Empresa.SQL.Add('where  id = :id ;');

            zq_Empresa.ParamByName('id').AsString                     :=  Id.Text ;
            zq_Empresa.ParamByName('razaosocial').AsString            :=  RazaoSocial.Text ;
            zq_Empresa.ParamByName('cnae').AsString                   :=  CNAE.Text ;
            zq_Empresa.ParamByName('complemento').AsString            :=  Complemento.Text ;
            zq_Empresa.ParamByName('cep').AsString                    :=  Cep.Text ;
            zq_Empresa.ParamByName('email').AsString                  :=  Email.Text ;
            zq_Empresa.ParamByName('versaoarquivoibpt').AsString      :=  VersaoArquivoIBPT.Text ;
            zq_Empresa.ParamByName('nomefantasia').AsString           :=  NomeFantasia.Text ;
            zq_Empresa.ParamByName('im').AsString                     :=  IM.Text ;
            zq_Empresa.ParamByName('bairro').AsString                 :=  Bairro.Text ;
            zq_Empresa.ParamByName('telefone').AsString               :=  Telefone.Text ;
            zq_Empresa.ParamByName('site').AsString                   :=  Site.Text ;
            zq_Empresa.ParamByName('aliquotaibptnacional').AsString   :=  AliquotaIBPTNacional.Text;
            zq_Empresa.ParamByName('cnpj').AsString                   :=  Cnpj.Text ;
            zq_Empresa.ParamByName('aliquotaibptestadual').AsString   :=  AliquotaIBPTEstadual.Text;
            zq_Empresa.ParamByName('endereco').AsString               :=  Endereco.Text ;
            zq_Empresa.ParamByName('codigomunicipal').AsString        :=  CodigoMunicipal.Text ;
            zq_Empresa.ParamByName('celular').AsString                :=  Celular.Text ;
            zq_Empresa.ParamByName('chaveibpt').AsString              :=  ChaveIBPT.Text ;
            zq_Empresa.ParamByName('aliquotaibptimportacao').AsString :=  AliquotaIBPTImportacao.Text;
            zq_Empresa.ParamByName('vigenciaibpt').AsString           :=  VigenciaIBPT.Text ;
            zq_Empresa.ParamByName('fax').AsString                    :=  Fax.Text ;
            zq_Empresa.ParamByName('municipio').AsString              :=  Municipio.Text ;
            zq_Empresa.ParamByName('numero').AsString                 :=  Numero.Text ;
            zq_Empresa.ParamByName('ie').AsString                     :=  IE.Text ;
            zq_Empresa.ParamByName('aliquotaicms').AsString           :=  AliquotaICMS.Text ;
            zq_Empresa.ParamByName('aliquotaicmsst').AsString         :=  AliquotaICMSST.Text ;
            zq_Empresa.ParamByName('aliquotaipi').AsString            :=  AliquotaIPI.Text ;
            zq_Empresa.ParamByName('aliquotapis').AsString            :=  AliquotaPis.Text ;
            zq_Empresa.ParamByName('aliquotacofins').AsString         :=  AliquotaCofins.Text ;
            zq_Empresa.ParamByName('uf').AsString                     :=  UF.Text ;
            zq_Empresa.ParamByName('isento').asboolean                :=  Isento.Checked ;
            zq_Empresa.ParamByName('simplesnacional').asboolean       :=  SimplesNacional.Checked ;

          end//if
          else
          begin

            zq_Empresa.SQL.Add('insert into '+ Schema +'dad_empresa_jpdv (');
            //

            zq_Empresa.SQL.Add('razaosocial,');
            zq_Empresa.SQL.Add('cnae,');
            zq_Empresa.SQL.Add('complemento,');
            zq_Empresa.SQL.Add('cep,');
            zq_Empresa.SQL.Add('email,');
            zq_Empresa.SQL.Add('versaoArquivoIBPT,');
            zq_Empresa.SQL.Add('nomeFantasia,');
            zq_Empresa.SQL.Add('iM,');
            zq_Empresa.SQL.Add('bairro,');
            zq_Empresa.SQL.Add('telefone,');
            zq_Empresa.SQL.Add('site,');
            zq_Empresa.SQL.Add('aliquotaIBPTNacional,');
            zq_Empresa.SQL.Add('cnpj,');
            zq_Empresa.SQL.Add('aliquotaIBPTEstadual,');
            zq_Empresa.SQL.Add('endereco,');
            zq_Empresa.SQL.Add('codigoMunicipal,');
            zq_Empresa.SQL.Add('celular,');
            zq_Empresa.SQL.Add('chaveIBPT,');
            zq_Empresa.SQL.Add('aliquotaIBPTImportacao,');
            zq_Empresa.SQL.Add('vigenciaIBPT,');
            zq_Empresa.SQL.Add('fax,');
            zq_Empresa.SQL.Add('municipio,');
            zq_Empresa.SQL.Add('numero,');
            zq_Empresa.SQL.Add('iE,');
            zq_Empresa.SQL.Add('aliquotaICMS,');
            zq_Empresa.SQL.Add('aliquotaICMSST,');
            zq_Empresa.SQL.Add('aliquotaIPI,');
            zq_Empresa.SQL.Add('aliquotaPis,');
            zq_Empresa.SQL.Add('aliquotaCofins,');
            zq_Empresa.SQL.Add('uF,');
            zq_Empresa.SQL.Add('base64,');
            zq_Empresa.SQL.Add('isento,');
            zq_Empresa.SQL.Add('simplesnacional )');
            ///
            zq_Empresa.SQL.Add(' values (');
            //
            zq_Empresa.SQL.Add(':razaosocial,');
            zq_Empresa.SQL.Add(':cnae,');
            zq_Empresa.SQL.Add(':complemento,');
            zq_Empresa.SQL.Add(':cep,');
            zq_Empresa.SQL.Add(':email,');
            zq_Empresa.SQL.Add(':versaoArquivoIBPT,');
            zq_Empresa.SQL.Add(':nomeFantasia,');
            zq_Empresa.SQL.Add(':iM,');
            zq_Empresa.SQL.Add(':bairro,');
            zq_Empresa.SQL.Add(':telefone,');
            zq_Empresa.SQL.Add(':site,');
            zq_Empresa.SQL.Add(':aliquotaIBPTNacional,');
            zq_Empresa.SQL.Add(':cnpj,');
            zq_Empresa.SQL.Add(':aliquotaIBPTEstadual,');
            zq_Empresa.SQL.Add(':endereco,');
            zq_Empresa.SQL.Add(':codigoMunicipal,');
            zq_Empresa.SQL.Add(':celular,');
            zq_Empresa.SQL.Add(':chaveIBPT,');
            zq_Empresa.SQL.Add(':aliquotaIBPTImportacao,');
            zq_Empresa.SQL.Add(':vigenciaIBPT,');
            zq_Empresa.SQL.Add(':fax,');
            zq_Empresa.SQL.Add(':municipio,');
            zq_Empresa.SQL.Add(':numero,');
            zq_Empresa.SQL.Add(':iE,');
            zq_Empresa.SQL.Add(':aliquotaICMS,');
            zq_Empresa.SQL.Add(':aliquotaICMSST,');
            zq_Empresa.SQL.Add(':aliquotaIPI,');
            zq_Empresa.SQL.Add(':aliquotaPis,');
            zq_Empresa.SQL.Add(':aliquotaCofins,');
            zq_Empresa.SQL.Add(':uF,');
            zq_Empresa.SQL.Add(''''+ Base64 +'''');
            zq_Empresa.SQL.Add(', :isento,');
            zq_Empresa.SQL.Add(':simplesnacional');
            //
            zq_Empresa.SQL.Add(');');


            zq_Empresa.ParamByName('razaosocial').AsString            :=  RazaoSocial.Text ;
            zq_Empresa.ParamByName('cnae').AsString                   :=  CNAE.Text ;
            zq_Empresa.ParamByName('complemento').AsString            :=  Complemento.Text ;
            zq_Empresa.ParamByName('cep').AsString                    :=  Cep.Text ;
            zq_Empresa.ParamByName('email').AsString                  :=  Email.Text ;
            zq_Empresa.ParamByName('versaoarquivoibpt').AsString      :=  VersaoArquivoIBPT.Text ;
            zq_Empresa.ParamByName('nomefantasia').AsString           :=  NomeFantasia.Text ;
            zq_Empresa.ParamByName('im').AsString                     :=  IM.Text ;
            zq_Empresa.ParamByName('bairro').AsString                 :=  Bairro.Text ;
            zq_Empresa.ParamByName('telefone').AsString               :=  Telefone.Text ;
            zq_Empresa.ParamByName('site').AsString                   :=  Site.Text ;
            zq_Empresa.ParamByName('aliquotaibptnacional').AsString   :=  AliquotaIBPTNacional.Text;
            zq_Empresa.ParamByName('cnpj').AsString                   :=  Cnpj.Text ;
            zq_Empresa.ParamByName('aliquotaibptestadual').AsString   :=  AliquotaIBPTEstadual.Text;
            zq_Empresa.ParamByName('endereco').AsString               :=  Endereco.Text ;
            zq_Empresa.ParamByName('codigomunicipal').AsString        :=  CodigoMunicipal.Text ;
            zq_Empresa.ParamByName('celular').AsString                :=  Celular.Text ;
            zq_Empresa.ParamByName('chaveibpt').AsString              :=  ChaveIBPT.Text ;
            zq_Empresa.ParamByName('aliquotaibptimportacao').AsString :=  AliquotaIBPTImportacao.Text;
            zq_Empresa.ParamByName('vigenciaibpt').AsString           :=  VigenciaIBPT.Text ;
            zq_Empresa.ParamByName('fax').AsString                    :=  Fax.Text ;
            zq_Empresa.ParamByName('municipio').AsString              :=  Municipio.Text ;
            zq_Empresa.ParamByName('numero').AsString                 :=  Numero.Text ;
            zq_Empresa.ParamByName('ie').AsString                     :=  IE.Text ;
            zq_Empresa.ParamByName('aliquotaicms').AsString           :=  AliquotaICMS.Text ;
            zq_Empresa.ParamByName('aliquotaicmsst').AsString         :=  AliquotaICMSST.Text ;
            zq_Empresa.ParamByName('aliquotaipi').AsString            :=  AliquotaIPI.Text ;
            zq_Empresa.ParamByName('aliquotapis').AsString            :=  AliquotaPis.Text ;
            zq_Empresa.ParamByName('aliquotacofins').AsString         :=  AliquotaCofins.Text ;
            zq_Empresa.ParamByName('uf').AsString                     :=  UF.Text ;
            zq_Empresa.ParamByName('isento').asboolean                :=  Isento.Checked ;
            zq_Empresa.ParamByName('simplesnacional').asboolean       :=  SimplesNacional.Checked ;



          end;//else



            zq_Empresa.ExecSQL;
            zq_Empresa.Close;

       end; //try

           result := 'Dados Salvos.';
       Except
          on E: Exception do
            begin
              result := 'Erro ao cadastrar empresa: ' + e.Message;
              zq_Empresa.Close;
            end;
       end; //exept

     end;  // if


end;

end.
