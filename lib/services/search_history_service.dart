import 'package:abejita/models/ui.dart';
import 'package:abejita/services/local_storage.dart';

class SearchHistoryService {
  static const String _clientSearchHistoryKey = "samuel";
  static const String _loanSearchHistoryKey = "joshua";

  static Future<bool> clearLoans() => LocalStorage.preferences.remove(_loanSearchHistoryKey);
  static Future<bool> clearClients() => LocalStorage.preferences.remove(_clientSearchHistoryKey);

  static Set<HistoryItem> getClients() =>
      LocalStorage.preferences.getStringList(_clientSearchHistoryKey)?.map((e) => HistoryItem.fromString(e)).toSet() ?? {};

  static Future<bool> addClient(HistoryItem? client) {
    if (client == null) {
      return Future.value(false);
    }

    final collection = getClients();
    if (collection.contains(client)) {
      return Future.value(false);
    }
    collection.add(HistoryItem(client.id, client.title));

    return LocalStorage.preferences.setStringList(_clientSearchHistoryKey, collection.map((e) => e.toText()).toList());
  }

  static Set<HistoryItem> getLoans() =>
      LocalStorage.preferences.getStringList(_loanSearchHistoryKey)?.map((e) => HistoryItem.fromString(e)).toSet() ?? {};

  static Future<bool> addLoan(HistoryItem? loan) {
    if (loan == null) {
      return Future.value(false);
    }

    final collection = getLoans();
    collection.add(HistoryItem(loan.id, loan.title));

    return LocalStorage.preferences.setStringList(_loanSearchHistoryKey, collection.map((e) => e.toText()).toList());
  }
}
