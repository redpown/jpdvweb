/*
usar no delphi 
AddToInitProc('');
para que atraves de alguma retono dele ele executar um fancao no pagina
ou apenas execute algo na pagina
*/
/*$(document).on('onchange','#files',function(){
       var reader = new FileReader();

		reader.onload = function (e) {
			// get loaded data and render thumbnail.
			document.getElementById("image").src = e.target.result;
		};

		// read the image file as a data URL.
		reader.readAsDataURL(this.files[0]); 
    });*/
//https://stackoverflow.com/questions/35413377/jquery-mask-number-with-commas-and-decimal	
$("form").on('submit',function(e) {
    e.preventDefault();//evita o refresh da pagina
});
$("button").on('submit',function(e) {
    e.preventDefault();
});
$("input").on('submit',function(e) {
    e.preventDefault();
});

//aciona o click do input file original escondido
$("#EnviarImagem").on( "click", function() {

  $( "#files" ).click();
//---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------//
//separar essa parte pois controla os campos do delphi que na podem ser editados os seus html
//radios e todos os buttons
});

$("#Simples-Nacional").on( "click", function() {
  $( "#IWCHKSIMPLESNACIONAL_CHECKBOX" ).click();
});

$("#Isento").on( "click", function() {
  $( "#IWCHKISENTO_CHECKBOX" ).click();

});

//os id criados pelo delphi sao todos em maiusculo prestar atencao
$("#Editar").on( "click", function() {
	 img = $('#ImgEnviada').attr('src');
	 aux1 = img.replace(/^data:image\/(png|jpg);base64,/, "")
	 $('#IWBASE64').val(aux1);
	 AddChangedControl('IWBASE64');   // colocar AddChangedControl sempre que usar o onAsyncClick pois colocar o campo como alterado
     $( "#IWBTNEDITAR" ).click();
	 console.log('IWBTNEDITAR')

});

$("#Confirmar").on( "click", function() {
		 img = $('#ImgEnviada').attr('src');
		 aux1 = img.replace(/^data:image\/(png|jpg);base64,/, "")
		 $('#IWBASE64').val(aux1);
	     AddChangedControl('IWBASE64');   // colocar AddChangedControl sempre que usar o onAsyncClick pois colocar o campo como alterado
        $("#IWBTNCONFIRMAR" ).click();



});

$("#TestarConexao").on( "click", function() {

  $( "#IWBTNTESTARCONEXAO" ).click();

});

$("#SalvarUserMaster").on( "click", function() {

  $( "#IWBTNSALVARUSERMASTER" ).click();

});

$("#campoUF").on("click", function () {
        //Get text or inner html of the selected option
        var selectedText = $("#campoUF option:selected").text();
      //console.log(selectedText);
		$('#IWUF').val(selectedText);
		AddChangedControl('IWUF');   // colocar AddChangedControl sempre que usar o onAsyncClick pois colocar o campo como alterado
      
});

/*
//sempre usar esse codigo para evitar o refresh da pagina
//se tiver algum bug no codigo ele executa tudo comom padrao.
//ele precisa do evento click nos campos delphi para atualizar o ele pegar o novo valor
$("form").on('submit',function(e) {
    e.preventDefault();
});*/



