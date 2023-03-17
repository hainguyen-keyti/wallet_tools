const ethers = require("ethers");

// In Wallet service format hdPath is: "m/0/0/1"
(() => {
  const xpub = process.argv[2];
  const hdPath = process.argv[3];
  let hdnode = ethers.HDNodeWallet.fromExtendedKey(xpub);
  const path = hdPath.indexOf("m") > -1 ? hdPath : `m/${hdPath}`;
  let wallet = hdnode.derivePath(path);
  console.log(`${path}: ${wallet.address}`);
})();
