# 마크업 템플릿

여러 템플릿 엔진이 있지만 간단하게 마크업을 생성하는 기능만 사용하려 할때 사용한다.

```js
var _template = '<div>'
              + '   <span class="author">{=name}</span>'
			  + '   <span class="date">{=date}</span>'   
			  + '</div>';
										   
function _itemTpl(data) {
    return _template.replace(/\{=([^{}]*)}/g, function(a, b) {
	    return (typeof data[b] === 'undefined') ? '' : data[b];
    });
};
 
 
_itemTpl({name: 'test', date: '2010'});
```
