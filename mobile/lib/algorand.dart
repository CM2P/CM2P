import 'dart:io';
import 'dart:convert' show json;

import 'package:algorand_dart/algorand_dart.dart';
import 'package:cm2p/auth/auth_util.dart';
import 'package:cm2p/backend/backend.dart';

Future<void> createAccount() async {
  final account = await Account.random();
  final firebaseUser =
      await UsersRecord.getDocument(currentUserReference).first;
  await UsersRecord.collection
      .doc(firebaseUser.reference.id)
      .update({'accountPublicAddress': account.publicAddress});
}

Future<void> setup() async {
  // TODO use our thing
  final algodClient = AlgodClient(
    // apiUrl: 'http://54.93.225.56:46237/',
    // apiKey: '6a9cefe21b7b94267df61f88bb151593c338a0ea4cd9e224d4191c4d5a977991',
    apiUrl: Platform.isAndroid
        ? 'http://10.0.2.2:4001'
        : 'http://169.254.108.248:4001',
    apiKey: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
  );

  final algorand = Algorand(algodClient: algodClient);

  final wordsSNB =
      // ignore: lines_longer_than_80_chars
      'year crumble opinion local grid injury rug happy away castle minimum bitter upon romance federal entire rookie net fabric soft comic trouble business above talent';

  final wordsJB =
      // ignore: lines_longer_than_80_chars
      'beauty nurse season autumn curve slice cry strategy frozen spy panic hobby strong goose employ review love fee pride enlist friend enroll clip ability runway';

  final wordsCS =
      // ignore: lines_longer_than_80_chars
      'picnic bright know ticket purity pluck stumble destroy ugly tuna luggage quote frame loan wealth edge carpet drift cinnamon resemble shrimp grain dynamic absorb edge';

  final accountSNB = await Account.fromSeedPhrase(wordsSNB.split(' '));
  final accountJB = await Account.fromSeedPhrase(wordsJB.split(' '));
  final accountCS = await Account.fromSeedPhrase(wordsCS.split(' '));

  print('Account 1: ${accountSNB.publicAddress}');
  print('Account 2: ${accountJB.publicAddress}');
  print('Account 3: ${accountCS.publicAddress}');

  // Create a new asset
  final assetId = await createAsset(
    algorand: algorand,
    sender: accountSNB,
    manager: accountSNB,
  );

  // // Update manager address
  // await changeManager(
  //   algorand: algorand,
  //   sender: accountSNB,
  //   manager: accountSNB,
  //   assetId: assetId,
  // );

  // Opt in the asset
  await optIn(algorand: algorand, account: accountJB, assetId: assetId);

  // Opt in the asset
  await optIn(algorand: algorand, account: accountCS, assetId: assetId);

  // Transfer the asset
  await transfer(
    algorand: algorand,
    sender: accountSNB,
    receiver: accountJB,
    assetId: assetId,
    amount: 20000000000,
  );

  // Transfer the asset
  await transfer(
    algorand: algorand,
    sender: accountSNB,
    receiver: accountCS,
    assetId: assetId,
    amount: 20000000000,
  );
}

Future<int> createAsset({
  Algorand algorand,
  Account sender,
  Account manager,
}) async {
  print('--- Creating asset ---');

  // Get the suggested transaction params
  final params = await algorand.getSuggestedTransactionParams();

  // Create the asset
  final tx = await (AssetConfigTransactionBuilder()
        ..sender = sender.address
        ..totalAssetsToCreate = 100000000000
        ..decimals = 2
        ..unitName = json.decode(json.encode('CHF-S'))
        ..assetName = json.decode(json.encode('Swiss Digital Stablecoin'))
        ..url = json.decode(json.encode('https://www.snb.ch/de/'))
        // ..metadataText = json.decode(json.encode(''))
        ..defaultFrozen = false
        ..managerAddress = manager.address
        ..reserveAddress = manager.address
        ..freezeAddress = manager.address
        ..clawbackAddress = manager.address
        ..suggestedParams = params)
      .build();

  // Sign the transaction
  final signedTx = await tx.sign(sender);

  // Broadcast the transaction
  final txId = await algorand.sendTransaction(signedTx);
  final response = await algorand.waitForConfirmation(txId);
  final assetId = response.assetIndex ?? 0;

  // Print created asset
  printCreatedAsset(algorand: algorand, account: sender, assetId: assetId);

  // Print asset holding
  printAssetHolding(algorand: algorand, account: sender, assetId: assetId);

  return assetId;
}

Future changeManager({
  Algorand algorand,
  Account sender,
  Account manager,
  int assetId,
}) async {
  print('--- Changing manager address ---');

  // Get the suggested transaction params
  final params = await algorand.getSuggestedTransactionParams();

  // Create the asset
  final tx = await (AssetConfigTransactionBuilder()
        ..sender = sender.address
        ..assetId = assetId
        ..managerAddress = sender.address
        ..reserveAddress = manager.address
        ..freezeAddress = manager.address
        ..clawbackAddress = manager.address
        ..suggestedParams = params)
      .build();

  // Sign the transaction
  final signedTx = await tx.sign(sender);

  // Broadcast the transaction
  final txId = await algorand.sendTransaction(signedTx);
  final response = await algorand.waitForConfirmation(txId);
  print(response);

  // Print created asset
  printCreatedAsset(algorand: algorand, account: manager, assetId: assetId);

  return Future.value();
}

/// Opt in to receive an asset
Future optIn({
  Algorand algorand,
  Account account,
  int assetId,
}) async {
  print('--- Opting in ---');
  // Get the suggested transaction params
  final params = await algorand.getSuggestedTransactionParams();

  // Opt in to the asset=
  final tx = await (AssetTransferTransactionBuilder()
        ..assetId = assetId
        ..receiver = account.address
        ..sender = account.address
        ..suggestedParams = params)
      .build();

  // Sign the transaction
  final signedTx = await tx.sign(account);

  // Broadcast the transaction
  final txId = await algorand.sendTransaction(signedTx);
  final response = await algorand.waitForConfirmation(txId);
  print(response);

  // Print created asset
  printAssetHolding(algorand: algorand, account: account, assetId: assetId);

  return Future.value();
}

/// Transfer asset from creator to opted in account
Future<bool> transfer({
  Algorand algorand,
  Account sender,
  Account receiver,
  int assetId,
  int amount,
}) async {
  print('--- Transfering asset ---');

  // Get the suggested transaction params
  final params = await algorand.getSuggestedTransactionParams();

  // Transfer the asset
  final tx = await (AssetTransferTransactionBuilder()
        ..assetId = assetId
        ..sender = sender.address
        ..receiver = receiver.address
        ..amount = amount
        ..suggestedParams = params)
      .build();

  // Sign the transaction
  final signedTx = await tx.sign(sender);

  // Broadcast the transaction
  final txId = await algorand.sendTransaction(signedTx);
  final response = await algorand.waitForConfirmation(txId);
  print(response);

  // Print created asset
  printAssetHolding(algorand: algorand, account: receiver, assetId: assetId);

  printAssetHolding(algorand: algorand, account: sender, assetId: assetId);

  return Future.value(true);
}

void printCreatedAsset({
  Algorand algorand,
  Account account,
  int assetId,
}) async {
  final information = await algorand.getAccountByAddress(account.publicAddress);
  for (var asset in information.createdAssets) {
    if (asset.index == assetId) {
      print('Created asset: $asset');
      return;
    }
  }
}

void printAssetHolding({
  Algorand algorand,
  Account account,
  int assetId,
}) async {
  final information = await algorand.getAccountByAddress(account.publicAddress);
  for (var asset in information.assets) {
    if (asset.assetId == assetId) {
      print('Asset holding: $asset');
      return;
    }
  }
}

Future<void> updateAccountPublicAddress(String publicAddress) async {}
