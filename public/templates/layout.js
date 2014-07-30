module.exports = function template(locals) {
var buf = [];
var jade_mixins = {};
var jade_interp;
;var locals_for_with = (locals || {});(function (title, version) {
buf.push("<!DOCTYPE html><html><head><title>" + (jade.escape((jade_interp =  title ) == null ? '' : jade_interp)) + "</title><link rel=\"stylesheet\" type=\"text/css\"" + (jade.attr("href", "/styles/main.css?" + ( version ) + "", true, true)) + "></head><body></body></html>");}("title" in locals_for_with?locals_for_with.title:typeof title!=="undefined"?title:undefined,"version" in locals_for_with?locals_for_with.version:typeof version!=="undefined"?version:undefined));;return buf.join("");
};