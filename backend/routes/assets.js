var express = require("express");
const router = express.Router();

const algosdk = require("algosdk");
//TODO move to .env but node will be deleted after hackathon anyway
const token = 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa';
const server = 'http://169.254.108.248';
const nodePort = 4001;
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
