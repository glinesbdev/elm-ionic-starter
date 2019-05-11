var watch = require('@ionic/app-scripts/dist/watch');
var copy = require('@ionic/app-scripts/dist/copy');
const { exec } = require('child_process');

// this is a custom dictionary to make it easy to extend/override
// provide a name for an entry, it can be anything such as 'srcFiles' or 'copyConfig'
// then provide an object with the paths, options, and callback fields populated per the Chokidar docs
// https://www.npmjs.com/package/chokidar

module.exports = {
  srcFiles: {
    paths: ['{{SRC}}/**/*.(elm|ts|html|s(c|a)ss)'],
    options: { ignored: ['{{SRC}}/**/*.spec.ts', '{{SRC}}/**/*.e2e.ts', '**/*.DS_Store', '{{SRC}}/index.html'] },
    callback: function(event, filePath, context) {
        return new Promise(resolve => {
            watch.buildUpdate(event, filePath, context).then(function() {
                exec('elm make src/app/Main.elm --output www/elm.js');
                resolve();
            });
        });
    }
  },
  copyConfig: copy.copyConfigToWatchConfig()
};
