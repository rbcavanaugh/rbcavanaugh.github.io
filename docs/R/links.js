
        
window.onload = function(){
    l=document.links.length;
    for(i = 0; i<l; i++) {
        n = document.links[i].href.indexOf(".pdf");

        if (n > 0){
            document.links[i].setAttribute('target', '_blank');
        }
    }
}

$(document).ready(function(){
	
   // external links to new window
    $('a[href^="http://"]').not('a[href*="https://robcavanaugh.com"]').attr('target','_blank');
    
    // force PDF Files to open in new window
    $('a[href$=".pdf"]').attr('target', '_blank');

  });