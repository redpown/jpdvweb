unit Unit2;

interface

uses
  Classes, SysUtils, IWAppForm, IWApplication, IWColor, IWTypes,
  ZAbstractConnection, ZConnection;

type
  TIWForm2 = class(TIWAppForm)
    ZConnection1: TZConnection;
  public
  end;

implementation

{$R *.dfm}


end.
