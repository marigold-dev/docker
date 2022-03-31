let path = require("path");

let esyJSON = require(process.argv[2]);
esyJSON.esy.release.rewritePrefix = true;
esyJSON.esy.release.includePackages = ["root", "esy-libev", "esy-gmp"];
console.log(JSON.stringify(esyJSON, null, 2));
