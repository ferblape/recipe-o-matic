$(document).ready(function() {
  $("[data-behaviour='focus']").focus();

  $("[data-behaviour='clone-image']").on({
    click: function(e){
      e.preventDefault(); e.stopPropagation();
      var $image = $("input[name^='" + $(this).data('target') + "']").filter(":last");
      var $newImage = $image.clone().val(null);
      $newImage.insertAfter($image).focus().attr('id', '');;
      $("[data-behaviour='delete-cloned-image']").show();
    }
  });

  $("[data-behaviour='delete-cloned-image']").on({
    click: function(e){
      e.preventDefault(); e.stopPropagation();
      var $image = $("input[name^='" + $(this).data('target') + "']").filter(":last");
      $image.remove();
      if($("input[name^='" + $(this).data('target') + "']").length == 1){
        $(this).hide();
      }
    }
  });

  // Hide delete buttons if there is only one element
  $("[data-behaviour='delete-cloned-image']").each(function(){
    var target = $(this).data('target');
    if($("input[name^='" + target + "']").length == 1){
      $(this).hide();
    }
  });
});
