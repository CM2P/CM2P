import 'package:cm2p/algorand.dart';
import 'package:cm2p/auth/auth_util.dart';
import 'package:cm2p/backend/backend.dart';
import 'package:intl/intl.dart';

final currencyFormatCHF =
    NumberFormat.currency(locale: "de_CH", symbol: "CHF ");
final currencyFormatCHFS =
    NumberFormat.currency(locale: "de_CH", symbol: "CHF-S ");

Future<UsersRecord> updateBalance() async {
  final firebaseUser =
      await UsersRecord.getDocument(currentUserReference).first;
  final balance =
      await getAssetAmount(publicAddress: firebaseUser.accountPublicAddress);
  await UsersRecord.collection.doc(firebaseUser.reference.id).update({
    'fiatWealth': firebaseUser.fiatWealth - balance,
    'chfSWealth': balance,
  });
  return firebaseUser;
}
