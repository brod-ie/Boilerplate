module.exports = function template(locals) {
var buf = [];
var jade_mixins = {};
var jade_interp;
;var locals_for_with = (locals || {});(function (title, version) {
buf.push("<!DOCTYPE html><html><head><title>" + (jade.escape((jade_interp =  title ) == null ? '' : jade_interp)) + "</title><link rel=\"stylesheet\" type=\"text/css\" href=\"http://fonts.googleapis.com/css?family=Roboto:400,300,300italic,400italic,700,700italic\"><link rel=\"stylesheet\" type=\"text/css\"" + (jade.attr("href", '/styles/main.css?' + ( version ) + '', true, true)) + "></head><body><div class=\"container\"><h1>Hello Hello Hi</h1><p class=\"pull-left\">How's Brodie today?</p></div><script type=\"text/javascript\" src=\"/socket.io/socket.io.js\"></script><script type=\"text/javascript\"" + (jade.attr("src", "/scripts/main.js?" + ( version ) + "", true, true)) + "></script></body></html>");}("title" in locals_for_with?locals_for_with.title:typeof title!=="undefined"?title:undefined,"version" in locals_for_with?locals_for_with.version:typeof version!=="undefined"?version:undefined));;return buf.join("");
};