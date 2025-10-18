import 'dart:math';
import 'dart:math' as Math;
import 'package:abejita/models/enums.dart';
import 'package:diacritic/diacritic.dart';
import 'package:abejita/models/ui.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

enum GenerateCharsTypeEnum { digits, upperLetters, lowerLetters, letters, all }

extension DoubleExtension on double? {
  String get asCurrency {
    if (this == null) {
      return "RD\$ 0.00";
    }
    return "RD\$ ${this!.toStringAsFixed(2)}";
  }

  double get rounded {
    if (this == null || this!.isNaN) {
      return 0;
    }
    return (this! * 100).round() / 100;
  }
}

extension OffsetDateTimeFormat on DateTime {
  DateTime applied(TimeOfDay time) {
    return DateTime(year, month, day, time.hour, time.minute);
  }

  TimeOfDay get timeOfDay {
    return TimeOfDay(hour: hour, minute: minute);
  }

  String getMonthName({bool short = true}) {
    String cMonth = [
      'Enero',
      'Febrero',
      'Marzo',
      'Abril',
      'Mayo',
      'Junio',
      'Julio',
      'Agosto',
      'Septiembre',
      'Octubre',
      'Noviembre',
      'Diciembre',
    ][month - 1];
    return short ? cMonth.substring(0, 3) : cMonth;
  }

  /// Convierte la fecha a un string compatible con OffsetDateTime de Rust (time crate)
  String toOffsetDateTimeString() {
    /// Ejemplo: "2025-08-30 03:52:06.722827 +00:00:00"
    final date =
        '${year.toString().padLeft(4, '0')}-'
        '${month.toString().padLeft(2, '0')}-'
        '${day.toString().padLeft(2, '0')}';

    final time =
        '${hour.toString().padLeft(2, '0')}:'
        '${minute.toString().padLeft(2, '0')}:'
        '${second.toString().padLeft(2, '0')}.'
        '${microsecond.toString().padLeft(6, '0')}';

    // Offset respecto a UTC
    final duration = timeZoneOffset;
    final sign = duration.isNegative ? '-' : '+';
    final offsetHours = duration.inHours.abs().toString().padLeft(2, '0');
    final offsetMinutes = (duration.inMinutes.abs() % 60).toString().padLeft(2, '0');
    final offsetSeconds = (duration.inSeconds.abs() % 60).toString().padLeft(2, '0');

    final offset = '$sign$offsetHours:$offsetMinutes:$offsetSeconds';

    return '$date $time $offset';
  }
}

extension StringUtil on String {
  Color get toColor {
    String data = replaceAll("#", "");
    if (data.length == 6) {
      data = "FF$data";
    }
    return Color(int.parse("0x$data"));
  }

  String maxLength(int length) {
    if (length > length) {
      return this;
    } else {
      return substring(0, length);
    }
  }

  String toParagraph([bool addDash = false]) {
    return addDash ? "-\t$this" : "\t$this";
  }

  bool toBool([bool defaultValue = false]) {
    if (toString().compareTo('1') == 0 || toString().compareTo('true') == 0) {
      return true;
    } else if (toString().compareTo('0') == 0 || toString().compareTo('false') == 0) {
      return false;
    }
    return defaultValue;
  }

  int? toInt([int? defaultValue]) {
    try {
      return int.parse(this);
    } catch (e) {
      return defaultValue;
    }
  }

  double toDouble([double defaultValue = 0]) {
    try {
      return double.parse(this);
    } catch (e) {
      return defaultValue;
    }
  }

  String? get nullIfEmpty {
    return isEmpty ? null : this;
  }
}

extension StringExtension on String? {
  String get toStringOrEmpty {
    if (this != null) {
      return toString();
    } else {
      return '';
    }
  }

  String get capitalized {
    if (this == null) return "";
    return this!
        .trim()
        .split(' ')
        .map((word) {
          if (word.isEmpty) return word;
          return word[0].toUpperCase() + word.substring(1).toLowerCase();
        })
        .join(' ');
  }

  String get normalized {
    if (this == null) return "";
    return removeDiacritics(this!);
  }

  String? get asCedulaFormat {
    if (this != null && this!.length == 11) {
      return '${this!.substring(0, 3)}-${this!.substring(3, 10)}-${this!.substring(10)}';
    }
    return this;
  }

  bool get isValidIdStartSecuentation {
    var text = this;
    if (text == null || text.isEmpty) return false;

    bool isValid = true;

    for (var c in '0123456789'.runes) {
      String charStr = String.fromCharCode(c);
      String start = (charStr == '0') ? '000' : charStr * 5;

      if (isValid) {
        if (text.startsWith(start)) {
          isValid = false;
        }
      } else {
        break;
      }
    }

    return isValid;
  }

  bool get isValidIdSecuention {
    if (this == null || this!.isEmpty) return false;

    bool isValid = true;

    for (var c in '0123456789'.runes) {
      if (isValid) {
        isValid &= this!.maxCountSecuency(String.fromCharCode(c)) <= 5;
      } else {
        break;
      }
    }

    return isValid;
  }

  int get asIntegerNumber => asDecimalNumber.toInt();

  double get asDecimalNumber {
    var text = this;
    if (text == null || text.trim().isEmpty) return 0;

    String result = '';
    bool pointerFound = false;

    for (int i = text.length - 1; i >= 0; i--) {
      final c = text.codeUnitAt(i);
      if (c >= 48 && c <= 57) {
        // Dígitos 0-9
        result = text[i] + result;
      } else if (!pointerFound && c == 46) {
        // Punto decimal '.'
        pointerFound = true;
        result = text[i] + result;
      }
    }

    return double.tryParse(result) ?? 0;
  }

  String? toPhone({bool nullIfEmpty = true}) {
    if (this == null) {
      return nullIfEmpty ? null : '';
    } else {
      return this!
          .toLowerCase()
          .removeChars(" _-.,+áéíóú='\"¿?¡!;ñÑ@#\$%^&*()`~</>abcdefghijklmnopqrstvwxyz")
          .truncate(16, needTrim: false);
    }
  }

  String? toName({bool nullIfEmpty = true}) {
    if (this == null) {
      return nullIfEmpty ? null : '';
    } else {
      return this!.removeChars(" _-.,+='\"¿?¡!;ñÑ@#\$%^&*()`~</>").capitalized;
    }
  }

  String? toIdentification({bool nullIfEmpty = true}) {
    if (this == null) {
      return nullIfEmpty ? null : '';
    } else {
      return this!.toUpperCase().removeChars(" _-.,+áéíóú='\"¿?¡!;ñÑ@#\$%^&*()`~</>").truncate(11, needTrim: false);
    }
  }

  String truncate(int length, {bool needTrim = true}) {
    var text = this;
    if (text == null || text.isEmpty) return '';

    if (needTrim) {
      text = text.trim();
    }

    return text.length <= length ? text : text.substring(0, length);
  }

  int maxCountSecuency(String character) {
    if (this == null || this!.isEmpty) return 0;

    int count = 0;
    int max = 0;

    for (var c in this!.runes) {
      if (String.fromCharCode(c) == character) {
        count++;
      } else {
        if (count > max) max = count;
        count = 0;
      }
    }

    if (count > max) max = count;

    return max;
  }

  String? removeChars(String characters) {
    var text = this;
    if (text == null || text.isEmpty) return text;

    for (var c in characters.runes) {
      text = text!.replaceAll(String.fromCharCode(c), '');
    }

    return text;
  }
}

class Utils {
  static LoanEstimate getLoanEstimate({
    required double amount,
    required int paymentTerm,
    required LoanTermType termType,
    required double rate,
    required bool isAnualRate,
  }) {
    final monthlyRate = isAnualRate ? (rate / 100 / 12) : (rate / 100);
    final totalMonths = switch (termType) {
      LoanTermType.daily => paymentTerm / 30, //Una estimación
      LoanTermType.weekly => paymentTerm / 4.345,
      LoanTermType.biweekly => paymentTerm / 2.173,
      LoanTermType.monthly => paymentTerm,
    };

    final monthlyPayment =
        amount * (monthlyRate * Math.pow(1 + monthlyRate, totalMonths)) / (Math.pow(1 + monthlyRate, totalMonths) - 1);
    final totalPayment = monthlyPayment * totalMonths;

    double periodPayment, interestPerPeriod;
    switch (termType) {
      case LoanTermType.daily:
        periodPayment = monthlyPayment / 30; // Approximation
        interestPerPeriod = (amount * monthlyRate) / 30; // Approximation
        break;
      case LoanTermType.weekly:
        periodPayment = monthlyPayment / 4.345; // Approximation
        interestPerPeriod = (amount * monthlyRate) / 4.345; // Approximation
        break;
      case LoanTermType.biweekly:
        periodPayment = monthlyPayment / 2.173; // Approximation
        interestPerPeriod = (amount * monthlyRate) / 2.173; // Approximation
        break;
      case LoanTermType.monthly:
        periodPayment = monthlyPayment;
        interestPerPeriod = amount * monthlyRate;
        break;
    }

    return LoanEstimate(totalPayment.rounded, interestPerPeriod.rounded, periodPayment.rounded);
  }

  static Future<T> showOverlay<T>(Future<T> Function() asyncFunction) => Get.showOverlay<T>(
    opacity: 0.5,
    loadingWidget: const Material(
      type: MaterialType.transparency,
      child: Center(child: CircularProgressIndicator()),
    ),
    asyncFunction: asyncFunction,
  );

  static DateTime get minUtcDate => DateTime.fromMillisecondsSinceEpoch(-8640000000000000, isUtc: true);

  static DateTime? tryParseOffsetDateTime(String input) {
    // Elimina zona horaria redundante
    String sinZona = input.replaceAll(RegExp(r' \+00:00:00$'), '');

    // Limita nanosegundos a 6 cifras
    String corregido = sinZona.replaceFirstMapped(RegExp(r'\.(\d{6})\d+'), (m) => '.${m[1]}');

    return DateTime.tryParse(corregido)?.toUtc();
  }

  static DateTime parseOffsetDateTime(String input) {
    // Elimina zona horaria redundante
    String sinZona = input.replaceAll(RegExp(r' \+00:00:00$'), '');

    // Limita nanosegundos a 6 cifras
    String corregido = sinZona.replaceFirstMapped(RegExp(r'\.(\d{6})\d+'), (m) => '.${m[1]}');

    return DateTime.parse(corregido).toUtc();
  }

  static bool checkStringsRequiredValid(List<String?> parameters) {
    return parameters.any((p) => p == null || p.trim().isEmpty);
  }

  static String insertFlexibleSeparators(String input, String format) {
    final digitsOnly = input.replaceAll(RegExp(r'[^0-9]'), '');
    final tokens = RegExp(r'(y+|M+|d+)').allMatches(format).map((m) => m.group(0)!).toList();

    final expectedLengths = {'y': 4, 'M': 2, 'd': 2};

    final values = <String, String>{};
    int position = 0;

    for (final token in tokens) {
      final type = token[0]; // 'y', 'M', or 'd'
      final expected = expectedLengths[type]!;
      final actualLength = (position + expected <= digitsOnly.length) ? expected : digitsOnly.length - position;

      final value = digitsOnly.substring(position, position + actualLength);
      values[token] = value.padLeft(expected, '0');
      position += actualLength;
    }

    final reconstructed = format.replaceAllMapped(RegExp(r'(y+|M+|d+)'), (m) => values[m.group(0)!] ?? '');

    return reconstructed;
  }

  static DateTime? dateConvert(String? dateString, String maskFormat) {
    return (dateString?.isEmpty ?? true)
        ? null
        : DateFormat(maskFormat).tryParse(insertFlexibleSeparators(dateString!, maskFormat));
  }

  static DateTime fromOADate(double oaDate) {
    const int millisecondsPerDay = 86400000;
    final baseDate = DateTime.utc(1899, 12, 30); // Excel epoch
    final totalMilliseconds = (oaDate * millisecondsPerDay).round();
    return baseDate.add(Duration(milliseconds: totalMilliseconds));
  }

  static bool isValidUrl(String uri) {
    try {
      final parsed = Uri.parse(uri);
      return (parsed.isAbsolute && (parsed.scheme == 'http' || parsed.scheme == 'https' || parsed.scheme == 'ftp'));
    } catch (e) {
      return false;
    }
  }

  static String combineUrl(List<String> args) {
    return args.join('/');
  }

  static String generateChars({GenerateCharsTypeEnum type = GenerateCharsTypeEnum.all, int length = 7}) {
    String chars;

    switch (type) {
      case GenerateCharsTypeEnum.digits:
        chars = '0123456789';
        break;
      case GenerateCharsTypeEnum.upperLetters:
        chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
        break;
      case GenerateCharsTypeEnum.lowerLetters:
        chars = 'abcdefghijklmnopqrstuvwxyz';
        break;
      case GenerateCharsTypeEnum.letters:
        chars = 'aAbBcCdDeEfFgGhHiIjJkKlLmMnNoOpPqQrRsStTuUvVwWxXyYzZ';
        break;
      default:
        chars = '0aAbBcC1dDeEfFgGh2HiIjJkKlL3mMnN4oOpPq5QrRs6StTu7UvVw8WxXy9YzZ';
        break;
    }

    final random = Random();
    final count = chars.length - 1;
    String code = '';

    for (var i = 0; i < length; i++) {
      final index = random.nextInt(count);
      code += chars[index];
    }

    return code;
  }

  static String getPartnerCodeByName(String name, {int maxLength = 3}) {
    name = name.trim();
    final int day = DateTime.now().weekday % 7; // Similar a DayOfWeek (0-6)
    final Random gr = Random();
    String code = '';
    int count = 0;

    for (var c in name.runes) {
      if (count == maxLength) return code.toLowerCase();
      if (String.fromCharCode(c).toUpperCase() == String.fromCharCode(c) &&
          RegExp(r'[A-Z]').hasMatch(String.fromCharCode(c))) {
        code += String.fromCharCode(c);
        count++;
      }
    }

    final int diff = maxLength - count - 1;

    if (diff >= 1) {
      code += (day + 1).toString();
    }

    // Agregar caracteres aleatorios (sin incluir el primero)
    for (int i = 0; i < diff; i++) {
      code += String.fromCharCode(gr.nextInt(26) + 65); // Letras A-Z
    }

    return code.toLowerCase();
  }

  static String getDateStringFromDateTime(
    DateTime? dateTime, {
    bool showMonthShort = false,
    String messageIfEmpty = "No disponible",
  }) {
    if (dateTime == null || dateTime.year < 1900) {
      return messageIfEmpty;
    }

    String date = dateTime.day < 10 ? "0${dateTime.day}" : dateTime.day.toString();
    late String month;
    if (showMonthShort) {
      month = dateTime.getMonthName();
    } else {
      month = dateTime.month < 10 ? "0${dateTime.month}" : dateTime.month.toString();
    }

    String year = dateTime.year.toString();
    String separator = showMonthShort ? " " : "/";
    return "$date$separator$month$separator$year";
  }

  static String getTimeStringFromDateTime(
    DateTime? dateTime, {
    bool showSecond = true,
    String messageIfEmpty = "No disponible",
  }) {
    if (dateTime == null || dateTime.year < 1900) {
      return messageIfEmpty;
    }
    String hour = dateTime.hour.toString();
    if (dateTime.hour > 12) {
      hour = (dateTime.hour - 12).toString();
    }

    String minute = dateTime.minute < 10 ? "0${dateTime.minute}" : dateTime.minute.toString();
    String second = "";

    if (showSecond) {
      second = dateTime.second < 10 ? "0${dateTime.second}" : dateTime.second.toString();
    }
    String meridian = "";
    meridian = dateTime.hour < 12 ? " AM" : " PM";

    return "$hour:$minute${showSecond ? ":" : ""}$second$meridian";
  }

  static String getDateTimeStringFromDateTime(
    DateTime? dateTime, {
    bool showSecond = true,
    bool showDate = true,
    bool showTime = true,
    bool showMonthShort = false,
    String messageIfEmpty = "No disponible",
  }) {
    if (dateTime == null || dateTime.year < 1900) {
      return messageIfEmpty;
    }
    if (showDate && !showTime) {
      return getDateStringFromDateTime(dateTime);
    } else if (!showDate && showTime) {
      return getTimeStringFromDateTime(dateTime, showSecond: showSecond);
    }
    return "${getDateStringFromDateTime(dateTime, showMonthShort: showMonthShort)} ${getTimeStringFromDateTime(dateTime, showSecond: showSecond)}";
  }

  static String getStorageStringFromByte(int bytes) {
    double b = bytes.toDouble(); //1024
    double k = bytes / 1024; //1
    double m = k / 1024; //0.001
    double g = m / 1024; //...
    double t = g / 1024; //...

    if (t >= 1) {
      return "${t.toStringAsFixed(2)} TB";
    } else if (g >= 1) {
      return "${g.toStringAsFixed(2)} GB";
    } else if (m >= 1) {
      return "${m.toStringAsFixed(2)} MB";
    } else if (k >= 1) {
      return "${k.toStringAsFixed(2)} KB";
    } else {
      return "${b.toStringAsFixed(2)} Bytes";
    }
  }
}

class MyStringUtils {
  static bool isFirstCapital(String string) {
    if (string.codeUnitAt(0) >= 65 && string.codeUnitAt(0) <= 90) {
      return true;
    }
    return false;
  }

  static bool isFirstLetter(String string) {
    if (string.codeUnitAt(0) >= 0 && string.codeUnitAt(0) <= 9) {
      return true;
    }
    return false;
  }

  static bool isAlphabetIncluded(String string) {
    string = string.toUpperCase();
    for (int i = 0; i < string.length; i++) {
      if (string.codeUnitAt(i) >= 65 && string.codeUnitAt(i) <= 90) {
        return true;
      }
    }
    return false;
  }

  static bool isDigitIncluded(String string) {
    for (int i = 0; i < string.length; i++) {
      if (string.codeUnitAt(i) >= 0 && string.codeUnitAt(i) <= 9) {
        return true;
      }
    }
    return false;
  }

  static bool isSpecialCharacterIncluded(String string) {
    String ch = "~`!@#\$%^&*.?_";

    for (int i = 0; i < string.length; i++) {
      if (ch.contains(string[i])) {
        return true;
      }
    }
    return false;
  }

  static bool isIncludedCharactersPresent(String string, List<String>? includeCharacters) {
    if (includeCharacters == null) {
      return false;
    }

    for (int i = 0; i < string.length; i++) {
      if (includeCharacters.contains(string[i])) {
        return true;
      }
    }
    return false;
  }

  static bool isIgnoreCharactersPresent(String string, List<String>? ignoreCharacters) {
    if (ignoreCharacters == null) {
      return false;
    }

    for (int i = 0; i < string.length; i++) {
      if (ignoreCharacters.contains(string[i])) {
        return true;
      }
    }
    return false;
  }

  static bool checkMaxAlphabet(String string, int maxAlphabet) {
    int counter = 0;
    string = string.toUpperCase();
    for (int i = 0; i < string.length; i++) {
      if (string.codeUnitAt(i) >= 65 && string.codeUnitAt(i) <= 90) {
        counter++;
      }
    }
    if (counter <= maxAlphabet) {
      return true;
    }
    return false;
  }

  static bool checkMaxDigit(String string, int maxDigit) {
    int counter = 0;

    for (int i = 0; i < string.length; i++) {
      if (string.codeUnitAt(i) >= 0 && string.codeUnitAt(i) <= 9) {
        counter++;
      }
    }
    if (counter <= maxDigit) {
      return true;
    }
    return false;
  }

  static bool checkMinAlphabet(String string, int minAlphabet) {
    int counter = 0;
    string = string.toUpperCase();
    for (int i = 0; i < string.length; i++) {
      if (string.codeUnitAt(i) >= 65 && string.codeUnitAt(i) <= 90) {
        counter++;
      }
    }
    if (counter >= minAlphabet) {
      return true;
    }
    return false;
  }

  static bool checkMinDigit(String string, int minDigit) {
    int counter = 0;
    for (int i = 0; i < string.length; i++) {
      if (string.codeUnitAt(i) >= 0 && string.codeUnitAt(i) <= 9) {
        counter++;
      }
    }
    if (counter >= minDigit) {
      return true;
    }
    return false;
  }

  static bool validateString(
    String string, {
    int minLength = 8,
    int maxLength = 20,
    bool firstCapital = false,
    bool firstDigit = false,
    bool includeDigit = false,
    bool includeAlphabet = false,
    bool includeSpecialCharacter = false,
    List<String>? includeCharacters,
    List<String>? ignoreCharacters,
    int minAlphabet = 5,
    int maxAlphabet = 20,
    int minDigit = 0,
    int maxDigit = 20,
  }) {
    if (string.length < minLength) {
      return false;
    }

    if (string.length > maxLength) {
      return false;
    }

    if (firstCapital && !isFirstCapital(string)) {
      return false;
    }

    if (firstDigit && !isFirstLetter(string)) {
      return false;
    }

    if (includeAlphabet && !isAlphabetIncluded(string)) {
      return false;
    }

    if (includeDigit && !isDigitIncluded(string)) {
      return false;
    }

    if (includeSpecialCharacter && !isSpecialCharacterIncluded(string)) {
      return false;
    }

    if (!isIncludedCharactersPresent(string, includeCharacters)) {
      return false;
    }

    if (isIgnoreCharactersPresent(string, ignoreCharacters)) {
      return false;
    }

    if (!checkMaxAlphabet(string, maxAlphabet)) {
      return false;
    }

    if (!checkMinAlphabet(string, minAlphabet)) {
      return false;
    }

    if (!checkMaxDigit(string, maxAlphabet)) {
      return false;
    }

    if (!checkMinDigit(string, minAlphabet)) {
      return false;
    }

    return true;
  }

  static bool isEmail(String email) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{1,}))$';
    RegExp regex = RegExp(pattern as String);

    return regex.hasMatch(email);
  }

  static bool validateStringRange(String text, [int minLength = 8, int maxLength = 20]) {
    return text.length >= minLength && text.length <= maxLength;
  }
}
