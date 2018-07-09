$(document).ready(function(){
  $('.flexslider').flexslider();
});

$(document).on('turbolinks:load', function() {
  var tags = [ "meo", "mewmew", "meodethuong", "meosociu", "javascript", "asp", "ruby" ];
  $( "#autocomplete" ).autocomplete({
    source: function( request, response ) {
      var matcher = new RegExp( "^" + $.ui.autocomplete.escapeRegex( request.term ), "i" );
      response( $.grep( tags, function( item ){
        return matcher.test( item );
      }) );
    }
  });
}); 
