$.fn.extend({
    ensureLoad: function(handler) {//개별 이미지 로드 완료 체크
        var $this = this;
        return (function (){
            return $this.each(function() {
                if(this.complete) {
                    handler.call(this);
                }else{
                    $(this).load(handler);
                    $this.onerror = function(){
                        handler.call(this, true);
                    }
                }
            });
        })();
    },
    imagesLoaded : function (fn, fn2) {
        var $imgs = this.find('img[src!=""]'), imgArr = {cpl : [], err : []};
        if (!$imgs.length){
            if(fn) fn();
            return;
        }
        var dfds = [], cnt = 0;
        $imgs.each(function(){
            var _this = this;
            var dfd = $.Deferred();
            dfds.push(dfd);
            var img = new Image();
            img.onload = function(){
                imgArr.cpl.push(_this);
                check();
            }
            img.onerror = function(){
                imgArr.err.push(_this);
                check();
            }
            img.src = this.src;
        });
        function check(){
            cnt++;
            if(cnt === $imgs.length){
                if(fn) fn.call(imgArr);
                if(imgArr.err && fn2) fn2.call(imgArr);
            }
        }
    }
});

/* imgAlign */
function imgAlign(obj, o){
    o = o || {};
    var divs;
    if (getClassType(obj) === 'Array'){
        obj.forEach( function(v) {
            divs = $(v);
            action($(v));
        });
    }else if (obj instanceof jQuery) (divs = obj, action(obj));
    else divs = $(obj); action($(obj));
    function getClassType(params){
        return Object.prototype.toString.call(params).slice(8,-1);
    }
    function action(ele){
        ele.each(function(){
            var img = $(this), bx = img.parent(), divAspect = bx.outerHeight() / bx.outerWidth();
            img.ensureLoad(function(){
                var imgAspect = img.outerHeight() / img.outerWidth();
                if (imgAspect <= divAspect) {
                    var imgWidthActual = bx.outerHeight() / imgAspect;
                    var marginLeft = -Math.round(((imgWidthActual/bx.outerWidth())-1) / 2 * 100000)/1000;
                    img.css({"margin-left":marginLeft+"%", "top":0, height: "100%"});
                } else {
                    var imgHeightActual = bx.outerWidth() * imgAspect;
                    var marginTop = -Math.round(((imgHeightActual/bx.outerHeight())-1) / 2 * 100000)/1000;
                    img.css({"top":marginTop+"%", "margin-left":0, "width": "100%"});
                }
                if(img.css('visibility') === 'hidden')img.css('visibility', 'visible');
            });
        });//each
    }
    if(o.resize){
        $(window).resize(action);
    }
}//imgAlign