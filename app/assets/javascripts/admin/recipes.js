$(document).ready(function() {

  $("[data-behaviour='clone-image']").on({
    click: function(e){
      e.preventDefault(); e.stopPropagation();
      var $image = $("input[name^='" + $(this).data('target') + "']").filter(":last");
      var $newImage = $image.clone().val(null);
      $newImage.insertAfter($image).focus().attr('id', '');;
    }
  });

  $("[data-behaviour='delete-cloned-image']").on({
    click: function(e){
      e.preventDefault(); e.stopPropagation();
      var $image = $("input[name^='" + $(this).data('target') + "']").filter(":last");
      $image.remove();
    }
  });
});
