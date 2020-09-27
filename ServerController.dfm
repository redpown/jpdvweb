object IWServerController: TIWServerController
  OldCreateOrder = False
  AppName = 'JPDV'
  Description = 'JJA Consulting Sistema PDV'
  DebugHTML = True
  DisplayName = 'JPDV Sistema'
  Log = loFile
  HTMLHeaders.Strings = (
    '<meta charset="utf-8">'
    '<meta http-equiv="Content-Language" content="pt-br">'
    
      '<meta name="viewport" content="width=device-width, initial-scale' +
      '=1, shrink-to-fit=no">')
  Port = 8888
  Version = '15.1.10'
  DocType = '<!DOCTYPE html>'
  ExceptionLogger.FilePath = 'C:\Desenvolvedores\Andre\JPDVWEB\Templates'
  ExceptionLogger.FileName = 'JDPV.txt'
  ExceptionLogger.LogType = ltEventLog
  ExceptionLogger.Enabled = True
  JavaScriptOptions.Debug = True
  JavaScriptOptions.UseUncompressedFiles = True
  JavaScriptOptions.EnableFirebug = True
  JavaScriptOptions.AjaxErrorMode = emConsole
  HttpKeepAlive = True
  LogSessionEvents = True
  HTMLLanguage = 'pt-br'
  OnConfig = IWServerControllerBaseConfig
  OnNewSession = IWServerControllerBaseNewSession
  OnBeforeRender = IWServerControllerBaseBeforeRender
  Height = 310
  Width = 342
end
