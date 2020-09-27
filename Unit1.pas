unit Unit1;

interface

uses
  Classes, SysUtils, IWAppForm, IWApplication, IWColor, IWTypes, DBClient,
  DB, ZAbstractRODataset, ZAbstractDataset, ZDataset, Controls, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWCompEdit, ZConnection;

type
  TIWForm1 = class(TIWAppForm)
    ZQuery1: TZQuery;
    cd_Conexao: TClientDataSet;
    IWEdit1: TIWEdit;
    cd_Conexaohost: TStringField;
    ZConnection1: TZConnection;
  public
  end;

implementation

{$R *.dfm}


end.
