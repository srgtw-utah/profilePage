const express = require('express');
const fs = require('fs');
const marked = require('marked');
const path = require('path');
const escapeHtml = require('escape-html');

const app = express();

// @see https://expressjs.com/ja/starter/static-files.html
app.use(express.static('public'));

// @see https://github.com/expressjs/express/tree/master/examples/markdown
app.engine('md', function(path, options, fn){
  fs.readFile(path, 'utf8', function(err, str){
    if (err) return fn(err);
    var html = marked.parse(str).replace(/\{([^}]+)\}/g, function(_, name){
      return escapeHtml(options[name] || '');
    });
    fn(null, html);
  });
});
// app.set('views', path.join(__dirname, 'public'));
app.set('view engine', 'md');

// @see https://expressjs.com/ja/guide/routing.html
const Takeya = require('./private/takeya')(app);
app.get('/takeya/*', Takeya.get);

const port = process.env.PORT || 8080;
app.listen(port, () => {
  console.log('Hello world listening on port', port);
});
