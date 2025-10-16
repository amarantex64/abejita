import 'package:abejita/models/ui.dart';
import 'package:abejita/services/local_storage.dart';

class SearchHistoryService {
  static const String _clientSearchHistoryKey = "samuel";
  static const String _loanSearchHistoryKey = "joshua";

  static Future<bool> clearLoans() => LocalStorage.preferences.remove(_loanSearchHistoryKey);
  static Future<bool> clearClients() => LocalStorage.preferences.remove(_clientSearchHistoryKey);

  static List<HistoryItem> getClients() =>
      LocalStorage.preferences.getStringList(_clientSearchHistoryKey)?.map((e) => HistoryItem.fromString(e)).toList() ?? [];

  static Future<bool> addClient(HistoryItem? client) {
    if (client == null) {
      return Future.value(false);
    }

    final collection = getClients();
    collection.removeWhere((e) => e.id == client.id);
    collection.insert(0, HistoryItem(client.id, client.title));

    return LocalStorage.preferences.setStringList(_clientSearchHistoryKey, collection.map((e) => e.toText()).toList());
  }

  static List<HistoryItem> getLoans() =>
      LocalStorage.preferences.getStringList(_loanSearchHistoryKey)?.map((e) => HistoryItem.fromString(e)).toList() ?? [];

  static Future<bool> addLoan(HistoryItem? loan) {
    if (loan == null) {
      return Future.value(false);
    }

    final collection = getLoans();
    collection.removeWhere((e) => e.id == loan.id);
    collection.insert(0, HistoryItem(loan.id, loan.title));

    return LocalStorage.preferences.setStringList(_loanSearchHistoryKey, collection.map((e) => e.toText()).toList());
  }
}
