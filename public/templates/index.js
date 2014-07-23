function template(locals) {
var buf = [];
var jade_mixins = {};
var jade_interp;
;var locals_for_with = (locals || {});(function (version) {
buf.push("<!DOCTYPE html><html><head><title>Brodie Boilerplate</title><link rel=\"stylesheet\" type=\"text/css\"" + (jade.attr("href", "/styles/main.css?" + ( version ) + "", true, true)) + "></head><body><div class=\"container\"><h1>Hello Hello Hi</h1><p>How's Brodie today?</p></div><script type=\"text/javascript\"" + (jade.attr("src", "/scripts/main.js?" + ( version ) + "", true, true)) + "></script></body></html>");}("version" in locals_for_with?locals_for_with.version:typeof version!=="undefined"?version:undefined));;return buf.join("");
}