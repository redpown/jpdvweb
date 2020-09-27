document.getElementById("files").onchange = function () {
    var reader = new FileReader();

    reader.onload = function (e) {
        // get loaded data and render thumbnail.
        document.getElementById("ImgEnviada").src = e.target.result;
		//document.getElementById("texto").src = e.target.result;
   
    };

    // read the image file as a data URL.
    reader.readAsDataURL(this.files[0]);
	
};

/*
$('#files').on('onchange',function(){
       var reader = new FileReader();

		reader.onload = function (e) {
			// get loaded data and render thumbnail.
			document.getElementById("image").src = e.target.result;
		};

		// read the image file as a data URL.
		reader.readAsDataURL(this.files[0]); 
    });*/
/*
function thisFileUpload() {
            document.getElementById("files").click();
        };*/
/*		
$("#thisFileUpload").on( "click", function() {
  //document.getElementById("files").click()
  $( "#files" ).click();
alert('thisFileUpload');
});


$(".footer" ).on( "click", function() {
  //document.getElementById("files").click()
$('#sidebar').addClass("esconder");
console.log('ok');
alert('footer');
});

$(document).on('click','.footer',function(){
       alert('document'); 
    });*/


