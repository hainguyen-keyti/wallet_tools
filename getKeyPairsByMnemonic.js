const bip39 = require("bip39");
const bip32 = require("ripple-bip32");

(() => {
    if (process.argv.length !== 14) return console.log("Please enter the correct format of the mnemonic (12 words).");
    let mnemonic = "";
    for (let index = 2; index <= 13; index++) {
        mnemonic = mnemonic + process.argv[index];
        if (index !== 13) mnemonic += " ";
    }
    const seedBuffer = bip39.mnemonicToSeed(mnemonic);
    const node = bip32.fromSeedBuffer(seedBuffer);
    const xprv = node.toBase58();
    const xpub = node.neutered().toBase58();
    console.log("xprv: ", xprv);
    console.log("xpub: ", xpub);
})();
