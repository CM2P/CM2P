import 'package:algorand_dart/algorand_dart.dart';

final algodClient = AlgodClient(
  apiUrl: 'http://54.93.225.56:4001/',
  apiKey: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
  // apiUrl: Platform.isAndroid
  //     ? 'http://10.0.2.2:4001'
  //     : 'http://169.254.108.248:4001',
  // apiKey: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
);

algorand = Algorand(algodClient: algodClient);
final ASSET_ID = 41960755; // identifying index of the asset

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

// This code is meant to be run per account after one year in Julius Bar backend system
void main() async {
  // CHF-S private key, should not be here ;-)
  final juliusBarManagerMnemonic =
      'beauty nurse season autumn curve slice cry strategy frozen spy panic hobby strong goose employ review love fee pride enlist friend enroll clip ability runway';

  final juliusBarManagerAccount = await Account.fromSeedPhrase(
      juliusBarManagerMnemonic.split(' '));

  print('Julius Bar public address 1: ${juliusBarManagerAccount.publicAddress}');

  final clawbackPrivateKey = to_private_key(mnemonic);
  final clawbackAddress = address_from_private_key(clawbackPrivateKey);

  final feePerByte = 10;
  final firstValidRound = 1000;
  final lastValidRound = 2000;
  final genesisHash = 'SGO1GKSzyE7IEPItTxCByw9x8FmnrCDexi9/cOUJOiI=';

  // where to send the revoked CHF-S assets, should be Swiss National Bank account!
  final swissNationalBankAccountReceiver = generate_account();

  // here we would use Alice, Bob or Kevin public account address in a loop
  final alicePublicAddress =  'QZRPIHE6TM7D7Z7W5SCPHJLVBGC2T6YA3HP3VUYWTL3P326C4BFXLLNXBI';
  final bobPublicAddress =  'BW4SWBGZLVE4FHHSM6TL52EMUBW3X3F47IR73EQCB7ZNTIHSUKKZLLW7ZU': BOB,
  final kevinPublicAddress =   'BL2O2JVVELGL2PKPCXCEFLMSFP264AC2US2B4PKJVYMCVII6VDEQ3RQLH4': KEVIN

  // address to revoke assets from.
  final targetAddress = alicePublicAddress;

  final negativ_interest_rate = 7.5 / 100;

  // read on-chain balance of CHF-S
  final chfSbalance = await getAssetAmount(targetAddress)
  final chfSPenalty = balance - chfSbalance * negativ_interest_rate;

  // here we would get fiat CHF balance of account using bank back office system
  final chfBalance = await getFiatBalance(targetAddress)
  final chfPenalty = balance - chfBalance * negativ_interest_rate;
  
  // create the asset config transaction
  final tx = AssetTransferTxn(
    sender: clawbackAddress,
    fee: feePerByte,
    first_valid_round: firstValidRound,
    last_valid_round: lastValidRound,
    genesis_hash: genesisHash,
    index: ASSET_ID,
    receiver: receiver.address,
    amt: chfSPenalty,
    revocation_target: targetAddress,
  );

  // Sign the transaction
  final signedTx = await tx.sign(juliusBarManagerAccount);

  // Broadcast the transaction
  final txId = await algorand.sendTransaction(signedTx);
  final response = await algorand.waitForConfirmation(txId);
  print(response);
  print(response);
}