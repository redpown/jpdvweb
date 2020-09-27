
//mascara dos campos
$(document).ready(function(){
  $('.date').mask('00/00/0000', {clearIfNotMatch: true});
  $('.time').mask('00:00:00');
  $('.date_time').mask('99/99/9999 00:00:00');
  $('.cep').mask('99999-999', {clearIfNotMatch: true});
  $('.phone').mask('(99) 9999-9999', {clearIfNotMatch: true});
  $('.fax').mask('(99) 9999-9999', {clearIfNotMatch: true});
  $('.phone_cel').mask('(99) 99999-9999', {clearIfNotMatch: true});
  $('.phone_us').mask('(999) 999-9999', {clearIfNotMatch: true});
  $('.mixed').mask('AAA 000-S0S');
  $('.cnpj').mask('99.999.999/9999-99', {clearIfNotMatch: true});
  $('.cpf').mask('999.999.999-99', {clearIfNotMatch: true});
  $('.rg').mask('99.999.999.99' ,{clearIfNotMatch: true});
  $('.ie').mask('999999999999', {clearIfNotMatch: true});
  $('.im').mask('999999999999', {clearIfNotMatch: true});
  $('.cnae').mask('9999-9/99', {clearIfNotMatch: true});
  $('.aliquota').mask( '99.99', {reverse: true}, {clearIfNotMatch: true});
  $('.codmun').mask('9999999', {clearIfNotMatch: true});
  $('.host').mask('0ZZ.0ZZ.0ZZ.0ZZ', {
    translation: {
      'Z': {
        pattern: /[0-9]/, optional: true
      }
    }
  });
  $('.port').mask(':9999');
   

});

/*
EXEMPLOS
$(document).ready(function(){
  $('.date').mask('00/00/0000');
  $('.time').mask('00:00:00');
  $('.date_time').mask('00/00/0000 00:00:00');
  $('.cep').mask('00000-000');
  $('.phone').mask('0000-0000');
  $('.phone_with_ddd').mask('(00) 0000-0000');
  $('.phone_us').mask('(000) 000-0000');
  $('.mixed').mask('AAA 000-S0S');
  $('.cpf').mask('000.000.000-00', {reverse: true});
  $('.cnpj').mask('00.000.000/0000-00', {reverse: true});
  $('.money').mask('000.000.000.000.000,00', {reverse: true});
  $('.money2').mask("#.##0,00", {reverse: true});
  $('.ip_address').mask('0ZZ.0ZZ.0ZZ.0ZZ', {
    translation: {
      'Z': {
        pattern: /[0-9]/, optional: true
      }
    }
  });
  $('.ip_address').mask('099.099.099.099');
  $('.percent').mask('##0,00%', {reverse: true});
  $('.clear-if-not-match').mask("00/00/0000", {clearIfNotMatch: true});
  $('.placeholder').mask("00/00/0000", {placeholder: "__/__/____"});
  $('.fallback').mask("00r00r0000", {
      translation: {
        'r': {
          pattern: /[\/]/,
          fallback: '/'
        },
        placeholder: "__/__/____"
      }
    });
  $('.selectonfocus').mask("00/00/0000", {selectOnFocus: true});
});
*/