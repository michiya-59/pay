
$(function(){
  $(".popup_help").mouseover(function() {
    var marginTop = 0;
    var marginLeft = 35;
    var speed = 130;
    var popupObj = $(".popup_help_window");

    if (!popupObj.length) {
      popupObj = $("<p/>").addClass("popup_help_window").appendTo($("body"));
    }

    popupObj.html($(this).attr("data-message"));

    var offsetTop = $(this).offset().top + marginTop;

    var offsetLeft = $(this).offset().left + marginLeft;

    popupObj.css({
      "top": offsetTop,
      "left": offsetLeft
    }).show(speed);

  }).mouseout(function() {
    $(".popup_help_window").text("").hide("fast");
  });
});

$(function(){
  $(".popup_help").mouseover(function() {
    var marginTop = 0;
    var marginLeft = 35;
    var speed = 130;
    var popupObj = $(".popup_help_window");

    if (!popupObj.length) {
      popupObj = $("<p/>").addClass("popup_help_window").appendTo($("body"));
    }

    popupObj.html($(this).attr("data-message"));

    var offsetTop = $(this).offset().top + marginTop;
    var offsetLeft = $(this).offset().left + marginLeft;

    popupObj.css({
      "top": offsetTop,
      "left": offsetLeft
    }).show(speed);
  }).mouseout(function() {
    $(".popup_help_window").text("").hide("fast");
  });
});