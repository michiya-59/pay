
$(function(){
  $(".popup_help").mouseover(function() {
    var marginTop = 0;
    var marginLeft = -110;
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
    var marginLeft = -110;
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

// 要素をスライドしながら非表示にする関数(jQueryのslideUpと同じ)
const slideUp = (el, duration = 300) => {
  el.style.height = el.offsetHeight + "px";
  el.offsetHeight;
  el.style.transitionProperty = "height, margin, padding";
  el.style.transitionDuration = duration + "ms";
  el.style.transitionTimingFunction = "ease";
  el.style.overflow = "hidden";
  el.style.height = 0;
  el.style.paddingTop = 0;
  el.style.paddingBottom = 0;
  el.style.marginTop = 0;
  el.style.marginBottom = 0;
  setTimeout(() => {
    el.style.display = "none";
    el.style.removeProperty("height");
    el.style.removeProperty("padding-top");
    el.style.removeProperty("padding-bottom");
    el.style.removeProperty("margin-top");
    el.style.removeProperty("margin-bottom");
    el.style.removeProperty("overflow");
    el.style.removeProperty("transition-duration");
    el.style.removeProperty("transition-property");
    el.style.removeProperty("transition-timing-function");
    el.classList.remove("is-open");
  }, duration);
};

// 要素をスライドしながら表示する関数(jQueryのslideDownと同じ)
const slideDown = (el, duration = 300) => {
  el.classList.add("is-open");
  el.style.removeProperty("display");
  let display = window.getComputedStyle(el).display;
  if (display === "none") {
    display = "block";
  }
  el.style.display = display;
  let height = el.offsetHeight;
  el.style.overflow = "hidden";
  el.style.height = 0;
  el.style.paddingTop = 0;
  el.style.paddingBottom = 0;
  el.style.marginTop = 0;
  el.style.marginBottom = 0;
  el.offsetHeight;
  el.style.transitionProperty = "height, margin, padding";
  el.style.transitionDuration = duration + "ms";
  el.style.transitionTimingFunction = "ease";
  el.style.height = height + "px";
  el.style.removeProperty("padding-top");
  el.style.removeProperty("padding-bottom");
  el.style.removeProperty("margin-top");
  el.style.removeProperty("margin-bottom");
  setTimeout(() => {
    el.style.removeProperty("height");
    el.style.removeProperty("overflow");
    el.style.removeProperty("transition-duration");
    el.style.removeProperty("transition-property");
    el.style.removeProperty("transition-timing-function");
  }, duration);
};

// 要素をスライドしながら交互に表示/非表示にする関数(jQueryのslideToggleと同じ)
const slideToggle = (el, duration = 300) => {
  if (window.getComputedStyle(el).display === "none") {
    return slideDown(el, duration);
  } else {
    return slideUp(el, duration);
  }
};

// アコーディオンを全て取得
const accordions = document.querySelectorAll(".js-accordion");
// 取得したアコーディオンをArrayに変換(IE対策)
const accordionsArr = Array.prototype.slice.call(accordions);

accordionsArr.forEach((accordion) => {
  // Triggerを全て取得
  const accordionTriggers = accordion.querySelectorAll(".js-accordion-trigger");
  // TriggerをArrayに変換(IE対策)
  const accordionTriggersArr = Array.prototype.slice.call(accordionTriggers);

  accordionTriggersArr.forEach((trigger) => {
    // Triggerにクリックイベントを付与
    trigger.addEventListener("click", () => {
      // '.is-active'クラスを付与or削除
      trigger.classList.toggle("is-active");
      // 開閉させる要素を取得
      const content = trigger.querySelector(".accordion__content");
      // 要素を展開or閉じる
      slideToggle(content);
    });
  });
});

// グラフの幅と高さを調節している
window.addEventListener('load', () => {
  // ブラウザのウインドウサイズを取得する
  var window_w = window.innerWidth;
  
  var grah = document.getElementById('column-chart');

  var cavas = grah.querySelector('canvas');
  // var canvas_wi = parseInt(cavas.style.width);
  if (window_w <= 540){
    grah.style.width = 324 + "px"
    grah.style.height = 270 + "px"
    cavas.style.width = 324 + "px"
    cavas.style.height = 270 + "px"
  }
});
