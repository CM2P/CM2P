import 'dart:io';
import 'dart:convert' show json;

import 'package:algorand_dart/algorand_dart.dart';
import 'package:cm2p/auth/auth_util.dart';
import 'package:cm2p/backend/backend.dart';

final ASSET_ID = 41960755;
Algorand algorand;
Account accountSNB;
Account accountJB;
Account accountCS;

final wordsSNB =
    // ignore: lines_longer_than_80_chars
    'year crumble opinion local grid injury rug happy away castle minimum bitter upon romance federal entire rookie net fabric soft comic trouble business above talent';

final wordsJB =
    // ignore: lines_longer_than_80_chars
    'beauty nurse season autumn curve slice cry strategy frozen spy panic hobby strong goose employ review love fee pride enlist friend enroll clip ability runway';

final wordsCS =
    // ignore: lines_longer_than_80_chars
    'picnic bright know ticket purity pluck stumble destroy ugly tuna luggage quote frame loan wealth edge carpet drift cinnamon resemble shrimp grain dynamic absorb edge';

// we should have used secure flutter storage
final SEED_ALICE =
    'useful clinic another hockey hello swim acquire truth jelly indoor surface hollow brush idea option potato sick theory city slender leader drama expire abstract prison';
final SEED_BOB =
    'mention cluster any profit oil roof balcony kite behind early width cost broom barely input valid clarify holiday occur blame door dinosaur toy abstract bring';
final SEED_KEVIN =
    'chapter fantasy picnic amazing pair sadness repeat rebel expand forum blur master urge space poverty setup cart carbon income inside sketch among labor absorb novel';

final seeds = {
  'QZRPIHE6TM7D7Z7W5SCPHJLVBGC2T6YA3HP3VUYWTL3P326C4BFXLLNXBI': SEED_ALICE,
  'BW4SWBGZLVE4FHHSM6TL52EMUBW3X3F47IR73EQCB7ZNTIHSUKKZLLW7ZU': SEED_BOB,
  'BL2O2JVVELGL2PKPCXCEFLMSFP264AC2US2B4PKJVYMCVII6VDEQ3RQLH4': SEED_KEVIN
};

final initialFunds = {
  'QZRPIHE6TM7D7Z7W5SCPHJLVBGC2T6YA3HP3VUYWTL3P326C4BFXLLNXBI': 563789,
  'BW4SWBGZLVE4FHHSM6TL52EMUBW3X3F47IR73EQCB7ZNTIHSUKKZLLW7ZU': 14789038,
  'BL2O2JVVELGL2PKPCXCEFLMSFP264AC2US2B4PKJVYMCVII6VDEQ3RQLH4': 441938718,
};

final initialChfSFunds = {
  'QZRPIHE6TM7D7Z7W5SCPHJLVBGC2T6YA3HP3VUYWTL3P326C4BFXLLNXBI': 0,
  'BW4SWBGZLVE4FHHSM6TL52EMUBW3X3F47IR73EQCB7ZNTIHSUKKZLLW7ZU': 0,
  'BL2O2JVVELGL2PKPCXCEFLMSFP264AC2US2B4PKJVYMCVII6VDEQ3RQLH4': 0,
};

void initAlgorand() async {
  // TODO use our thing
  final algodClient = AlgodClient(
    apiUrl: 'http://54.93.225.56:4001/',
    apiKey: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
    // apiUrl: Platform.isAndroid
    //     ? 'http://10.0.2.2:4001'
    //     : 'http://169.254.108.248:4001',
    // apiKey: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
  );

  algorand = Algorand(algodClient: algodClient);
  accountSNB = await Account.fromSeedPhrase(wordsSNB.split(' '));
  accountJB = await Account.fromSeedPhrase(wordsJB.split(' '));
  accountCS = await Account.fromSeedPhrase(wordsCS.split(' '));
}

Future<void> createAccount() async {
  final firebaseUser =
      await UsersRecord.getDocument(currentUserReference).first;
  final account = await Account.fromSeedPhrase(SEED_KEVIN.split(' '));
  // await optIn(algorand: algorand, account: account, assetId: ASSET_ID);
  await UsersRecord.collection.doc(firebaseUser.reference.id).update({
    'accountPublicAddress': account.publicAddress,
    'fiatWealth': initialFunds[account.publicAddress],
    'chfSWealth': initialChfSFunds[account.publicAddress],
  });
}

Future<void> fundWallet(int amount) async {
  final firebaseUser =
      await UsersRecord.getDocument(currentUserReference).first;

  // Transfer the asset
  await transfer(
    algorand: algorand,
    sender: accountJB,
    receiver: await Account.fromSeedPhrase(
        seeds[firebaseUser.accountPublicAddress].split(' ')),
    assetId: ASSET_ID,
    amount: amount,
  );
}

Future<double> getAssetAmount({
  String publicAddress,
}) async {
  final information = await algorand.getAccountByAddress(publicAddress);
  for (var asset in information.assets) {
    if (asset.assetId == ASSET_ID) {
      return asset.amount / 100;
    }
  }
}

Future<void> setup() async {
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
  // printAssetHolding(algorand: algorand, account: sender, assetId: assetId);

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
  // printAssetHolding(algorand: algorand, account: account, assetId: assetId);

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
  // printAssetHolding(algorand: algorand, account: receiver, assetId: assetId);

  // printAssetHolding(algorand: algorand, account: sender, assetId: assetId);

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

Future<void> updateAccountPublicAddress(String publicAddress) async {}
