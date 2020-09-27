unit UserSessionUnit;

{
  This is a DataModule where you can add components or declare fields that are specific to 
  ONE user. Instead of creating global variables, it is better to use this datamodule. You can then
  access the it using UserSession.
}
interface

uses
  IWUserSessionBase, SysUtils, Classes,DataModule;

type
  TIWUserSession = class(TIWUserSessionBase)
    procedure IWUserSessionBaseCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Usuario : Integer;
    dm_data : TDataModuleSource;
  end;

implementation

{$R *.dfm}

procedure TIWUserSession.IWUserSessionBaseCreate(Sender: TObject);
begin
   if dm_data = nil then
   dm_data:=   TDataModuleSource.Create(nil);
end;

end.