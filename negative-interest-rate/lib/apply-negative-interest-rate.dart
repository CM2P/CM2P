import 'package:algorand_dart/algorand_dart.dart';

// This code is meant to be run per account after one year in Julius Bar backend system
void main() async {
  // CHF-S private key, should not be here ;-)
  final juliusBarManagerMnemonic =
      'beauty nurse season autumn curve slice cry strategy frozen spy panic hobby strong goose employ review love fee pride enlist friend enroll clip ability runway';

  final account1 = await Account.fromSeedPhrase(
      juliusBarManagerMnemonic.split(' '));

  print('Julius Bar public address 1: ${account1.publicAddress}');

  final clawbackPrivateKey = to_private_key(mnemonic);
  final clawbackAddress = address_from_private_key(clawbackPrivateKey);

  final feePerByte = 10;
  final firstValidRound = 1000;
  final lastValidRound = 2000;
  final genesisHash = 'SGO1GKSzyE7IEPItTxCByw9x8FmnrCDexi9/cOUJOiI=';
  final index = 41960755; // identifying index of the asset

  // where to send the revoked assets, should be Swiss National Bank account!
  final swissNationlBankAccountReceiver = generate_account();

  // here we would use Alice, Bob or Kevin public account address in a loop
  final alicePublicAddress =  'QZRPIHE6TM7D7Z7W5SCPHJLVBGC2T6YA3HP3VUYWTL3P326C4BFXLLNXBI';
  final bobPublicAddress =  'BW4SWBGZLVE4FHHSM6TL52EMUBW3X3F47IR73EQCB7ZNTIHSUKKZLLW7ZU': BOB,
  final kevinPublicAddress =   'BL2O2JVVELGL2PKPCXCEFLMSFP264AC2US2B4PKJVYMCVII6VDEQ3RQLH4': KEVIN

  // address to revoke assets from.
  final targetAddress = alicePublicAddress;

  // read balance in CHF-S
  final balance = 200; // TODO

  final negativ_interest_rate = 7.5 / 100;

  final penalty = balance - balance * negativ_interest_rate;

  // create the asset config transaction
  final txn = AssetTransferTxn(
    sender: clawbackAddress,
    fee: feePerByte,
    first_valid_round: firstValidRound,
    last_valid_round: lastValidRound,
    genesis_hash: genesisHash,
    index: index,
    receiver: receiver.address,
    amt: penalty,
    revocation_target: targetAddress,
  );

  // sign the transction
  final signedTxn = txn.sign(clawbackPrivateKey);
}