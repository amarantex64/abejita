enum LoanTermType {
  daily,
  weekly,
  biweekly,
  monthly;

  static LoanTermType fromIndex(int index) {
    if (index < 0 && index >= LoanTermType.values.length) {
      return daily;
    }
    return LoanTermType.values[index];
  }

  String asName() => switch (this) {
    daily => "Diario",
    weekly => "Semanal",
    biweekly => "Quincenal",
    monthly => "Mensual",
  };

  String get suffixLabel => switch (this) {
    daily => "Días",
    weekly => "Semanas",
    biweekly => "Quincenas",
    monthly => "Meses",
  };

  double get numberForSlider => switch (this) {
    daily => 31,
    weekly => 16,
    biweekly => 16,
    monthly => 24,
  };
}
