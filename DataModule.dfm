object DataModuleSource: TDataModuleSource
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 541
  Width = 757
  object zq_UsuarioMaster: TZQuery
    Params = <>
    Left = 32
    Top = 88
  end
  object zq_Connection: TZConnection
    ControlsCodePage = cCP_UTF16
    AutoEncodeStrings = True
    Catalog = ''
    HostName = ''
    Port = 0
    Database = ''
    User = ''
    Password = ''
    Protocol = 'postgresql-7'
    Left = 24
    Top = 160
  end
  object cd_Conexao: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 32
    Top = 32
  end
  object zq_Empresa: TZQuery
    Params = <>
    Left = 136
    Top = 160
  end
  object zq_temp: TZQuery
    Params = <>
    Left = 136
    Top = 104
  end
  object cds_DadosEmpresa: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 72
    Top = 272
  end
end
