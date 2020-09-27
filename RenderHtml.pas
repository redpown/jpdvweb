unit RenderHtml;

interface

uses
  DateUtils,  Classes, SysUtils,
  IWAppForm, IWApplication, IWColor, IWTypes, IWCompEdit, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWCompButton, IWVCLComponent,IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML,Controls,IdBaseComponent, IdCoder, IdCoder3to4, IdCoderMIME;

function ExtractText(aText, OpenTag, CloseTag : String) : String;
function GeraPng(Base64,sNome:String):String;
function RenderHeader( Usuario :string = 'JJA';Empresa :string = 'JJA Consulting'; ImgUsuario :string = 'assets/images/faces/face8.jpg'; ImgEmpresa :string = 'assets/images/logo.png'; Email :string = 'jjapdv@jjaconsulting.com.br'; Cargo :string = 'Master'):string;
function RenderFooter(scripjs:string = ''):string;
function RenderHead(Title:string = '' ; Script : String = ''):String;



implementation

uses
ServerController , IW.Common.AppInfo;

//------------------------------------------------------funcoes de extracao

function ExtractText(aText, OpenTag, CloseTag : String) : String;
{ Retorna o texto dentro de 2 tags (open & close Tag's) }
var
  iAux, kAux : Integer;
begin
  Result := '';

  if (Pos(CloseTag, aText) <> 0) and (Pos(OpenTag, aText) <> 0) then
  begin
    iAux := Pos(OpenTag, aText) + Length(OpenTag);
    kAux := Pos(CloseTag, aText);
    Result := Copy(aText, iAux, kAux-iAux);
  end;
end;

//------------------------------------------------------funcoes de gera imagem

//gera imagem atrvaves do codigo base64
function GeraPng(Base64,sNome:string):string;
//classes necessarias TIdDecoderMIME,IdCoder, IdCoder3to4, IdCoderMIME ,IdBaseComponent
var
    MStream:TMemoryStream;
    Decoder:TIdDecoderMIME;
    DT: TDateTime;
    FilePathRoot: String;
    FS: TFormatSettings;
begin
    Decoder := TIdDecoderMIME.Create(nil);
    MStream := TMemoryStream.Create;
    Decoder.DecodeStream(Base64,MStream);
    //formato png esta com bug no windows quando e criado por algun software vlw MS
    FilePathRoot := StringReplace('assets\images\cliente\'+ sNome +'-'+ FormatDateTime('dd-mm-yyyy-hh-MM-ss', Now)+ '.jpg', ' ', '-', [rfReplaceAll]);//[] parametros do proprio delphi para formatacao e substituicao
    MStream.SaveToFile(TIWAppInfo.GetAppPath + 'wwwroot\'+ FilePathRoot);
    FreeAndNil(Decoder);
    FreeAndNil(MStream);
    result:= StringReplace(FilePathRoot, '\', '/', [rfReplaceAll]);//[] parametros do proprio delphi para formatacao e substituicao
end;

//----------------------------------------------funcoes de gerar html

function RenderHead(Title:string = '' ; Script : String = ''):String;
begin
  result:= '    <!-- Required meta tags -->' + #13
+'   <meta charset="utf-8">' + #13
+'   <meta http-equiv="Content-Language" content="pt-br">' + #13
+'   <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">' + #13
+'   <title>'+Title+'</title>' + #13
//


+'    <!-- js do template -->' + #13
+'    <script src="assets/vendors/js/vendor.bundle.base.js"></script>' + #13
+'    <script src="assets/vendors/js/vendor.bundle.addons.js"></script>' + #13
+'    <!-- Custom js for this page-->' + #13
+'    <script src="assets/js/demo_1/dashboard.js"></script>' + #13


//
+'    <!-- jQuery -->  ' + #13
+'    <script src="../vendors/jquery/dist/jquery.min.js"></script> ' + #13

//
+'    <!-- jQuery Mask-->  ' + #13
+'    <script src="vendors/jQuery-Mask-Plugin-master/dist/jquery.mask.min.js"></script>  ' + #13



//

+'    <!-- Font Awesome -->' + #13
+'    <link href="../vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet"/>' + #13
+'    <!-- NProgress -->' + #13
+'    <link href="../vendors/nprogress/nprogress.css" rel="stylesheet"/>' + #13


+'    <!-- plugins:css -->'       + #13
+'    <link rel="stylesheet" href="assets/vendors/iconfonts/mdi/css/materialdesignicons.min.css"/>'   + #13
+'    <link rel="stylesheet" href="assets/vendors/iconfonts/ionicons/css/ionicons.css"/>'     + #13
+'    <link rel="stylesheet" href="assets/vendors/iconfonts/typicons/src/font/typicons.css"/>'  + #13
+'    <link rel="stylesheet" href="assets/vendors/iconfonts/flag-icon-css/css/flag-icon.min.css"/>' + #13
+'    <link rel="stylesheet" href="assets/vendors/css/vendor.bundle.base.css"/>'   + #13
+'    <link rel="stylesheet" href="assets/vendors/css/vendor.bundle.addons.css"/>'   + #13
+'    <!-- endinject -->'           + #13
+'    <!-- plugin css for this page -->'+ #13
+'    <link rel="stylesheet" href="assets/vendors/icheck/skins/all.css"/>' + #13
+'    <!-- End plugin css for this page -->'    + #13
+'    <!-- inject:css -->'                  + #13
+'    <link rel="stylesheet" href="assets/css/shared/style.css"/>'  + #13
+'    <!-- endinject -->'                  + #13
+'    <!-- Layout styles -->'       + #13
+'    <link rel="stylesheet" href="assets/css/demo_1/style.css"/>' + #13
+'    <!-- End Layout styles -->'   + #13
+'     <!-- icones -->'          + #13
+'    <link href="assets/vendors/iconfonts/font-awesome/css/font-awesome.min.css" rel="stylesheet" />'+ #13
+'  	<!-- jpdvweb css -->'  + #13
+'	  <link rel="stylesheet" href="assets/css/jpdvweb.css"/>'   + #13
//logo do JPDV
+'    <link rel="shortcut icon" href="assets/images/favicon.png" />'      + #13
+'    <!-- RenderHeader-->'+ #13
+       Script;
end;


function RenderHeader(Usuario :string = 'JJA';Empresa :string = 'JJA Consulting'; ImgUsuario :string = 'assets/images/faces/face8.jpg'; ImgEmpresa :string = 'assets/images/logo.png'; Email :string = 'jjapdv@jjaconsulting.com.br'; Cargo :string = 'Master' ):string;
begin
  result:=

'	<div class="container-scroller">' + #13
+'		  <nav class="navbar default-layout col-lg-12 col-12 p-0 fixed-top d-flex flex-row">' + #13
+'			<div class="text-center navbar-brand-wrapper d-flex align-items-top justify-content-center">' + #13
//Logos normal e mini
+'			  <a class="navbar-brand brand-logo" href="index">'    + #13
//+'				<img src="assets/images/logo.svg" alt="logo" /> </a>'assets\images\
+'				<img class="rounded-circle logo-img-50px" src="'+ ImgEmpresa + '" alt="logo" /> </a>' + #13
+'			  <a class="navbar-brand brand-logo-mini" href="index">'    + #13
//+'				<img src="assets/images/logo-mini.svg" alt="logo" /> </a>'   + #13
+'				<img class="rounded-circle " src="'+ ImgEmpresa + '" alt="logo" /> </a>' + #13
+'			</div>'     + #13
+'			<div class="navbar-menu-wrapper d-flex align-items-center">' + #13
+'			  <ul class="navbar-nav ml-auto">'    + #13
+'				<li class="nav-item dropdown">'   + #13
+'				  <a class="esconder nav-link count-indicator" id="notificationDropdown" href="#" data-toggle="dropdown">' + #13
+'					<i class="mdi mdi-email-outline"></i>'  + #13
+'					<span class="count bg-success">3</span>'  + #13
+'				  </a>'                             + #13
+'				  <div class="dropdown-menu dropdown-menu-right navbar-dropdown preview-list pb-0" aria-labelledby="notificationDropdown">'  + #13
+'					<a class="dropdown-item py-3 border-bottom">'                       + #13
+'					  <p class="mb-0 font-weight-medium float-left">Você tem 4 novas notifições </p>'  + #13
+'					  <span class="badge badge-pill badge-primary float-right">Ver todas</span>'    + #13
+'					</a>'                                      + #13
+'					<a class="dropdown-item preview-item py-3">'  + #13
+'					  <div class="preview-thumbnail">'           + #13
+'						<i class="mdi mdi-alert m-auto text-primary"></i>'  + #13
+'					  </div>'                     + #13
+'					  <div class="preview-item-content">'   + #13
+'						<h6 class="preview-subject font-weight-normal text-dark mb-1">Debitos e Creditos</h6>'  + #13
+'						<p class="font-weight-light small-text mb-0"> ver agora </p>' + #13
+'					  </div>'                         + #13
+'					</a>'                           + #13
+'					<a class="dropdown-item preview-item py-3">'   + #13
+'					  <div class="preview-thumbnail">'         + #13
+'						<i class="mdi mdi-settings m-auto text-primary"></i>'    + #13
+'					  </div>                           + #13                                                                                                             '
+'					  <div class="preview-item-content">' + #13
+'						<h6 class="preview-subject font-weight-normal text-dark mb-1">Configurações</h6>'  + #13
+'						<p class="font-weight-light small-text mb-0"> ver agora </p>' + #13
+'					  </div>'    + #13
+'					</a>'          + #13
+'					<a class="dropdown-item preview-item py-3">'   + #13
+'					  <div class="preview-thumbnail">'         + #13
+'						<i class="mdi mdi-airballoon m-auto text-primary"></i>' + #13
+'					  </div>'               + #13
+'					  <div class="preview-item-content">'       + #13
+'						<h6 class="preview-subject font-weight-normal text-dark mb-1">Novo cadastro</h6>' + #13
+'						<p class="font-weight-light small-text mb-0"> 2 dias Atrás </p>'     + #13
+'					  </div>'     + #13
+'					</a>'  + #13
+'				  </div>'  + #13
+'				</li>'     + #13
+'				<li class="nav-item dropdown d-none d-xl-inline-block user-dropdown">'    + #13
+'				  <a class="nav-link dropdown-toggle" id="UserDropdown" href="#" data-toggle="dropdown" aria-expanded="false">' + #13
//imagem
+'					<img class="img-xs rounded-circle" src="'+ ImgUsuario+'" alt="Profile image"> </a>'    + #13
+'				  <div class="dropdown-menu dropdown-menu-right navbar-dropdown" aria-labelledby="UserDropdown">' + #13
+'					<div class="dropdown-header text-center">'  + #13
//imagem
+'					  <img class="img-md rounded-circle" src="'+ ImgUsuario +'" alt="Profile image">'  + #13
//usuario
+'					  <p class="mb-1 mt-3 font-weight-semibold">'+ Usuario +'</p>'+ #13
//email
+'					  <p class="font-weight-light text-muted mb-0">'+ Email +'</p>'  + #13
+'					</div>'+ #13
+'					<a class="dropdown-item" href="sistema_configuracao">Configurações<i class="dropdown-item-icon ti-dashboard"></i></a>'+ #13
+'					<a class="dropdown-item">Sangria<i class="dropdown-item-icon ti-comment-alt"></i></a>'  + #13
+'					<a class="dropdown-item">Troca de Funcionário<i class="dropdown-item-icon ti-location-arrow"></i></a>'  + #13
+'					<a class="dropdown-item">Suporte<i class="dropdown-item-icon ti-help-alt"></i></a>' + #13
+'					<a class="dropdown-item">Sair<i class="dropdown-item-icon ti-power-off"></i></a>'+ #13
+'				  </div>'  + #13
+'				</li>'  + #13
+'			  </ul>'  + #13
+'			  <button class="navbar-toggler navbar-toggler-right d-lg-none align-self-center" type="button" data-toggle="offcanvas">'  + #13
+'				<span class="mdi mdi-menu"></span>'+ #13
+'			  </button>' + #13
+'			</div>'   + #13
+'		  </nav>'  + #13
+'		  <!-- partial -->'    + #13
+'		<div class="container-fluid page-body-wrapper">'   + #13
+'		   <!-- partial:../../partials/_sidebar.html -->'   + #13
+'			<nav class="sidebar sidebar-offcanvas" id="sidebar">' + #13
+'			  <ul class="nav">'      + #13
+'				<li class="nav-item nav-profile">' + #13
+'				  <a href="#" class="nav-link">' + #13
+'					<div class="profile-image">'+ #13
//imagem
//+'					  <img class="img-xs rounded-circle" src="'+ UserSession.Img +'" alt="profile image">'
//+'					  <div class="dot-indicator bg-success"></div>'
+'					</div>'
+'					<div class="text-wrapper">' + #13
//usuario
+'					  <p class="profile-name">'+ Empresa +'</p>' + #13
//cargo
+'					  <p class="designation">'+ Cargo+'</p>' + #13
+'					</div>'  + #13
+'				  </a>'  + #13
+'				</li>'+ #13
+'				<li class="nav-item nav-category center-text">Menu</li>' + #13
+'				<li class="nav-item">'        + #13
+'				  <a class="nav-link" href="dashboard">'  + #13
+'					  <span class="input-group-text-home">'  + #13
+'						  <i class="fa fa-bar-chart-o"></i>'+ #13
+'					   </span>'         + #13
+'					<span class="menu-title">Estátisticas e Análises</span>'    + #13
+'				  </a>' + #13
+'				</li>' + #13
+'				<li class="nav-item">'    + #13
+'				  <a class="nav-link" href="funcionarios">'  + #13
+'					  <span class="input-group-text-home">'   + #13
+'						  <i class="fa fa-users"></i>'+ #13
+'					   </span>'      + #13
+'					<span class="menu-title">Cadastro de Funcionário</span>'   + #13
+'				  </a>'      + #13
+'				</li>'      + #13
+'				<li class="nav-item">' + #13
+'				  <a class="nav-link" href="clientes">'  + #13
+'					  <span class="input-group-text-home">' + #13
+'						  <i class="fa fa-vcard"></i>' + #13
+'					   </span>' + #13
+'					<span class="menu-title">Cadastro de Cliente</span>' + #13
+'				  </a>'  + #13
+'				</li>'  + #13
+'				<li class="nav-item">' + #13
+'				  <a class="nav-link" href="fornecedores">' + #13
+'					<span class="input-group-text-home">'   + #13
+'						  <i class="fa fa-drivers-license-o"></i>'  + #13
+'					   </span>'    + #13
+'					<span class="menu-title">Cadastro de Fornecedor</span>'    + #13
+'				  </a>' + #13
+'				</li>' + #13
+'				<li class="nav-item">'+ #13
+'				  <a class="nav-link" href="produtos">'  + #13
+'					  <span class="input-group-text-home">'  + #13
+'						  <i class="fa fa-barcode"></i>'  + #13
+'					   </span>'   + #13
+'					<span class="menu-title">Cadastro de Produto</span>' + #13
+'				  </a>' + #13
+'				</li>'    + #13
+'				<li class="nav-item">'  + #13
+'				  <a class="nav-link" href="fechamento_de_caixa">' + #13
+'					  <span class="input-group-text-home">'+ #13
+'						  <i class="fa fa-usd"></i>' + #13
+'					   </span>'+ #13
+'					<span class="menu-title">Fechamneto de Caixa</span>' + #13
+'				  </a>' + #13
+'				</li>'+ #13
+'				<li class="nav-item" id="caixa">'+ #13
+'				  <a class="nav-link" href="caixa">'+ #13
+'					<span class="input-group-text-home">'+ #13
+'						  <i class="fa fa-desktop"></i>'+ #13
+'					   </span>'+ #13
+'					<span class="menu-title">Caixa</span>'+ #13
+'				  </a>'+ #13
+'				</li>' + #13
+'				</ul>' + #13
+'			 </nav>'+ #13
+'			<!-- partial -->'+ #13
+'			<div class="main-panel">'+ #13
+'				<div class="content-wrapper">';
end;

function RenderFooter(scripjs : string =''):string;
begin
  result:=
 '					<!-- content-wrapper ends -->' + #13
+'				</div>' + #13
+'			  <!-- partial footer.html -->'    + #13
+'			  <footer class="footer">' + #13
+'				<div class="container-fluid clearfix">' + #13
+'				  <span class="text-muted d-block text-center text-sm-left d-sm-inline-block">Copyright ©'+ IntToStr(DateUtils.YearOf(Now)) + #13
+'				  <a href="https://www.jjaerp.com/" target="_blank">JJA Consulting.</a>.'+ #13
+'				  Todos os direitos reservados.' + #13
+'				  </span>'+ #13
+'				</div>' + #13
+'			  </footer>' + #13
+'			  <!-- partial -->'+ #13
+'			</div>'+ #13
+'			<!-- main-panel ends -->' + #13
+'		</div>'+ #13
+'		  <!-- page-body-wrapper ends -->'+ #13
+'	</div>'+ #13
+'        <!-- container-scroller -->' + #13

+'    <!-- js do template -->' + #13
+'    <script src="assets/js/shared/off-canvas.js"></script>' + #13
+'    <script src="assets/js/shared/misc.js"></script>' + #13

+'    <!-- jpdvweb js -->' + #13
+'    <script src="assets/js/jpdvweb.js"></script>' + #13



+'    <!-- RenderHml.Footer(script) -->' + #13
+        scripjs ;

end;

end.

