//图片新闻
$(function () {
    var $con = $('#gg'), $box = $con.find('#ggBox'), $btns = $con.find('#ggBtns'), i = 0, autoChange = function () {
        i += 1;
        if (i === 5) { i = 0; }
        $btns.find('a:eq(' + i + ')').addClass('ggOn').siblings().removeClass('ggOn');
        var curr = $box.find('a:eq(' + i + ')'), prev = curr.siblings();
        prev.css('z-index', 2);
        curr.css('z-index', 3).animate({
            'opacity': 1
        }, 150, function () {
            prev.css({
                'z-index': 1, 'opacity': 0.1
            });
        });
    }, loop = setInterval(autoChange, 5000);
    $con.hover(function () {
        clearInterval(loop);
    }, function () {
        loop = setInterval(autoChange, 5000);
    });
    $btns.find('a').click(function () {
        i = $(this).index() - 1;
        autoChange();
    });
});

//企业展示
var tm=null;  
function newsScroll()
{   
  if(document.getElementById("scrollimg").parentNode.scrollLeft!=(document.getElementById("scrollimg").clientWidth/2))   
    document.getElementById("scrollimg").parentNode.scrollLeft++;   
  else   
    document.getElementById("scrollimg").parentNode.scrollLeft=0;
}   
 
function stop()   
{   
  clearInterval(tm);
}   
 
function start()   
{   
  tm=setInterval('newsScroll()',30);
}
document.getElementById("simg1").innerHTML=document.getElementById("simg").innerHTML;
tm=setInterval('newsScroll()',30);


//浮动
var EX = {
  addEvent:function(k,v){
    var me = this;
    if (me.addEventListener)
      me.addEventListener(k, v, false);
    else if(me.attachEvent)
      me.attachEvent("on" + k, v);
    else
      me["on" + k] = v;
  },
  removeEvent:function(k,v){
    var me = this;
    if (me.removeEventListener)
      me.removeEventListener(k, v, false);
    else if (me.detachEvent)
      me.detachEvent("on" + k, v);
    else
      me["on" + k] = null;
  },
  stop:function(evt){
    evt = evt || window.event;
    evt.stopPropagation?evt.stopPropagation():evt.cancelBubble=true;
  }
};
document.getElementById('pop').onclick = EX.stop;
var url = '#'; 
