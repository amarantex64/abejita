class UserModel {
  final String id, name, surname, email, avatarUrl;

  UserModel({required this.id, required this.name, required this.surname, required this.email, required this.avatarUrl});
}

class ProviderModel {
  final String id, fullName, email, whatsAppAccount, avatarUrl;
  final String? phoneNumber;
  final List<String> conditions;

  ProviderModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.avatarUrl,
    required this.whatsAppAccount,
    this.phoneNumber,
    required this.conditions,
  });
}
