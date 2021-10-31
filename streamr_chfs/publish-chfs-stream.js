const Algosdk = require("algosdk");
const StreamrClient = require('streamr-client')
const request = require('request');

const assetId = 41960755;

// we use the algorand explorer to get insights about CHF-S account numberOfChfSHolder
request('https://testnet.algoexplorerapi.io/idx2/v2/assets/41960755/balances', { json: true }, (err, res, body) => {
  if (err) { return console.log(err); }
  console.log(res.body.balances);

  var balances =  res.body.balances;
  var count = Object.keys(balances).length;

  var chfsStableCoinCreated = 0;
  var chfsStableCoinOwned = 0;
  var numberOfChfSHolderWithNotZeroAmount = 0;
  balances.forEach(balance => {
    chfsStableCoinOwned += balance.amount;
    chfsStableCoinCreated += balance.amount;

    if (balance.amount != 0)
    {
         numberOfChfSHolderWithNotZeroAmount = numberOfChfSHolderWithNotZeroAmount + 1;
    }
  });

  const numberOfChfSHolder = Object.keys(res.body.balances).length;

  // TODO get this value from Julius Bär back office system
  // using API for now we assume julius bär behave correctly
  // and it is equal to number of token in wallet
  const chfCollateralLocked = chfsStableCoinCreated;

  console.log("number of account is " + count);
  console.log("chfCollateralLocked " + chfCollateralLocked);
  console.log("numberOfChfSHolder " + numberOfChfSHolder);
  console.log("numberOfChfSHolderWithNotZeroAmount " + numberOfChfSHolderWithNotZeroAmount);
  console.log("chfsStableCoinOwned " + chfsStableCoinOwned);
  console.log("chfsStableCoinCreated " + chfsStableCoinCreated);

  const streamrClient = new StreamrClient({
        auth: {
            // test account in mainnet
            privateKey: '5db175cc3d1aa8bdb367c58aa928d5e5e8d75f5579a9dc3a26eccfac4e41bd57',
        },
    })

    // publish to our stream
    streamrClient.publish('0x4ab637f2880fb13fd5d6817eb4ee6981e2002d40/chfs-swiss-stable-coin', {
        chfsStableCoinCreated: chfsStableCoinCreated,
        chfsStableCoinOwned: chfsStableCoinOwned,
        chfCollateralLocked: chfCollateralLocked,
        numberChfsWallet: numberOfChfSHolder,
        numberOfChfSHolderWithNotZeroAmount: numberOfChfSHolderWithNotZeroAmount
    })

});



