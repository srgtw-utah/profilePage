module.exports = Takeya;

const CONF_COMMON = require('./conf/common.json');
const CONF_MD = require('./conf/md.json');

function Takeya(app) {
  if (!(this instanceof Takeya)) return new Takeya(app);

  this.app = app;
}

// @see http://expressjs.com/ja/api.html#app.render
Takeya.prototype.get = function get(req, res) {
  res.render(req.path.slice(1), CONF_COMMON, (err, html) => {
    console.log(html);
    if (err) return res.status(404).send('404 not found.');
    res.send(mdTmpl(html));
  });
}

function mdTmpl(body) {
  return `<html><head>${cssTmpl(CONF_MD.css)}</head><body class="markdown-body">${body}</body></html>`;
}

function cssTmpl(list) {
  return list.map(url => `<link href="${url}" rel="stylesheet" />`).join('');
}
