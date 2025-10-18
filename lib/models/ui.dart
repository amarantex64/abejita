class LoanEstimate {
  const LoanEstimate(this.total, this.interest, this.periodPayment);

  final double total;
  final double interest;
  final double periodPayment;
}

class ComboboxItem {
  const ComboboxItem(this.id, this.name);

  final String id, name;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is ComboboxItem && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}

class HistoryItem {
  final String id, title;

  const HistoryItem(this.id, this.title);

  factory HistoryItem.fromMap(Map<String, String> map) => HistoryItem(map['id'] ?? '', map['title'] ?? '');

  factory HistoryItem.fromString(String text) {
    final parts = text.split(separator);
    return HistoryItem(parts[0], parts[1]);
  }

  static const String separator = " :=> ";
  static List<HistoryItem> fromList(List<Map<String, String>> list) => list.map((e) => HistoryItem.fromMap(e)).toList();

  Map<String, String> toMap() {
    return {'id': id, 'title': title};
  }

  String toText() => "$id$separator$title";

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is ComboboxItem && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
