/*
var previewLink = function() {
  var form = this.parentNode;
  while (form.nodeName != "FORM") {
    form = form.parentNode;
  };    
  new Ajax.Request(this.href, {asynchronous:true, evalScripts:true, method:'post', parameters:Form.serialize(form)}); 
  var win = new Window("new-window-id", {className: "dialog", width:350, height:400, zIndex: 100, resizable: true, title: "Preview", draggable:true, wiredDrag: true});
  win.setDestroyOnClose(true);
  win.getContent().innerHTML= "<div id='preview' style='text-align: left;'></div><div><img src='/images/roar/progress.gif' class='progress-edit' /></div>";
  win.showCenter();
  return false;
}

Event.addBehavior({
  'a.preview-link:click': previewLink
});
*/