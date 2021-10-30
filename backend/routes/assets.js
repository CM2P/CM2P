var express = require("express");
const router = express.Router();

const algosdk = require("algosdk");
const token = 'Your algod API token';
const server = 'http://54.93.225.56';
const nodePort = 8080;
const client = new algosdk.Algodv2(token, server, nodePort);


// middleware that is specific to this router
router.use(function timeLog(req, res, next) {
  console.log("Assets router: ", Date.now());
  next();
});

// search for asset by name
router.get("/:name", async function (req, res) {
  const assetSearchName = req.params.name;
  console.log("Searching for asset: ", assetSearchName)

  let assetInfo = await client
    .searchForAssets()
    .name(assetSearchName)
    .do();

  const assets = assetInfo.assets.map(asset => ({
      id: asset.index,
      decimals: asset.params.decimals,
      name: asset.params.name,
      total: asset.params.total,
      frozen: asset.params["default-frozen"]
  }))

  res.send(assets);
});

module.exports = router;
