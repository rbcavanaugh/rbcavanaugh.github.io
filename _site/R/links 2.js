$('a[href^=http]:not([href^=http://www.gusdecool.com],[href^=http://gusdecool.com])')
    .add('a[href^=www]:not([href^=www.gusdecool.com])')
        .attr('target','_blank');
        
window.onload = function(){
    l=document.links.length;
    for(i = 0; i<l; i++) {
        n = document.links[i].href.indexOf(".pdf");

        if (n > 0){
            document.links[i].setAttribute('target', '_blank');
        }
    }
}